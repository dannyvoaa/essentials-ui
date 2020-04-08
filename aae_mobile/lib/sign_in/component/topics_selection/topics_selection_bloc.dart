import 'dart:collection';

import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/static_values/static_keys.dart';
import 'package:aae/profile/repository/topics_repository.dart';
import 'package:aae/sign_in/component/topics_selection/topics_selection_view_model.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:quiver/core.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:aae/theme/colors.dart';
import 'package:inject/inject.dart';
import 'package:aae/model/topics.dart';

/// BLoC for the [TopicsSelectionComponent].
///
/// Exposes a [TopicsSelectionViewModel] for that component to use.
class TopicsSelectionBloc {
  final SignInSharedDataRepository _sharedDataRepository;
  final TopicsRepository _topicsRepository;
  final CacheService _cacheService;

  List<String> _topics = [];

  final _selectedTopics =
      createBehaviorSubject<Optional<Topics>>(initial: Optional.absent());

  final _events = Subject<WorkflowEvent>();

  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [TopicsSelectionViewModel].
  Source<TopicsSelectionViewModel> get viewModel => toSource(
        combineLatest2(
            Observable.fromFuture(_topicsRepository.topicsList).startWithSingle(
              UnmodifiableListView([]),
            ),
            _selectedTopics,
            _createViewModel),
      );

  @provide
  TopicsSelectionBloc(
    this._sharedDataRepository,
    this._topicsRepository,
    this._cacheService,
  );

  TopicsSelectionViewModel _createViewModel(
    UnmodifiableListView<Topics> topics,
    Optional<Topics> selectedTopics,
  ) =>
      TopicsSelectionViewModel(
        nextButtonEnabled: true,
        topics: BuiltList(
          topics.map(
            (topics) => TopicsViewModel(
              topic: topics.topics,
              borderColor:
                  selectedTopics.isPresent && topics == selectedTopics.value
                      ? Optional.of(AaeColors.black)
                      : Optional.absent(),
              onTopicPressed: () => _onTopicsPressed(topics),
            ),
          ),
        ),
      );

  /// [onTopicsPressed] writes out to the app's cacue until it is uploaded to
  /// aa's server
  void _onTopicsPressed(Topics topics) {
    _topics.add(topics.topics);
    _selectedTopics.sendNext(Optional.of(topics));
    _cacheService.writeStringList(topicsCacheKey, _topics);
    _sharedDataRepository.topics.sendNext(Optional.of(topics));
  }
}

/// Constructs new instances of [TopicsSelectionBloc]s via the DI framework.
abstract class TopicsSelectionBlocFactory implements ProvidedService {
  @provide
  TopicsSelectionBloc topicsSelectionBloc();
}
