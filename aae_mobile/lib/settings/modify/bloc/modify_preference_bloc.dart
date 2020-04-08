import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/static_values/static_keys.dart';
import 'package:aae/common/widgets/placeholder/placeholder_functions.dart';
import 'package:aae/common/widgets/tables/table_components.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:aae/settings/page/component/preference_section/preference_section_view_model.dart';

class ModifyPreferenceBloc {
  static const modificationBlocKey = 'ModifyPreferenceBloc';
  static final _log = Logger('ModifyPreferences');
  final CacheService _cacheService;

  final _events = Subject<WorkflowEvent>();
  List<TableCellTitleValue> tableCells;

  Observable<WorkflowEvent> get events => _events;

  //MARK: For new preference panels append to this view model
  Source<PreferenceSectionViewModel> get viewModel => toSource(combineLatest2(
      Observable.fromValues(_cacheService.readString(workgroupCacheKey)),
      Observable.fromValues(_cacheService.readStringList(topicsCacheKey)),
      _createViewModel));

  PreferenceSectionViewModel _createViewModel(
    String selectedWorkgroup,
    List<String> selectedTopics,
  ) {
    debugPrint('workgroup cache: $selectedWorkgroup');
    debugPrint('topics cache: $selectedTopics');
    return PreferenceSectionViewModel((b) => b
      ..table = _combineData({
        workgroupCacheKey: [selectedWorkgroup],
        topicsCacheKey: selectedTopics
      })
      ..onTapped = () =>
          PlaceholderSnackBar(aaeIdentifier: 'placeholder', context: null));
  }

  @provide
  ModifyPreferenceBloc(
    this._cacheService,
  );

  //TODO (rpaglinawan): Name params something better
  Widget _combineData(Map<String, List> sources) =>
      //TODO (rpaglinawan): break each section up into sections
      Center(
        child: Column(
          children: <Widget>[
            buildCountedCell(sources[topicsCacheKey]),
            buildTableCell(sources[workgroupCacheKey]),
          ],
        ),
      );

  TableCellTitleValue buildCountedCell(List source) {
    return TableCellTitleValue(
      boolBorderBottom: true,
      boolEnabled: true,
      boolShowDisclosureIndicator: true,
      stringTitle: 'Topics',
      stringValue:
          '${source.length} ${source.length > 1 || source.length == 0 ? 'topics' : 'topic'} selected',
    );
  }

  TableCellTitleValue buildTableCell(List source) => TableCellTitleValue(
        boolBorderBottom: true,
        boolEnabled: true,
        boolShowDisclosureIndicator: true,
        stringTitle: 'Current Workgroup',
        stringValue: source.first,
      );
}

abstract class ModifyPreferenceBlocFactory implements ProvidedService {
  @provide
  ModifyPreferenceBloc preferenceBloc();
}
