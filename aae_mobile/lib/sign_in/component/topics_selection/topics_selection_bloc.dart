import 'dart:collection';

import 'package:aae/model/topics.dart';
import 'package:aae/profile/repository/topics_repository.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/component/topics_selection/topics_selection_view_model.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';

/// BLoC for the [TopicsSelectionComponent].
///
/// Exposes a [TopicsSelectionViewModel] for that component to use.
class TopicsSelectionBloc {
  final SignInSharedDataRepository _sharedDataRepository;
  final TopicsRepository _topicsRepository;

  final _selectedTopics = createBehaviorSubject<List<String>>(initial: []);

  final _events = Subject<WorkflowEvent>();

  /// Publishes events to be consumed by the [SignInStateMachine].
  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [TopicsSelectionViewModel].
  Source<TopicsSelectionViewModel> get viewModel => toSource(combineLatest2(Observable.fromFuture(_topicsRepository.topicsList), _selectedTopics, _createViewModel));

  @provide
  TopicsSelectionBloc(this._sharedDataRepository, this._topicsRepository);

  TopicsSelectionViewModel _createViewModel(UnmodifiableListView<Topics> topics, List<String> selectedTopics) =>
      TopicsSelectionViewModel(
        nextButtonEnabled: true,
        topics: BuiltList(
          topics.map(
            (topics) => TopicsViewModel(
              isSelected: selectedTopics.contains(topics.topics),
              topic: topics.topics,
              onTopicPressed: () {
                if (selectedTopics.contains(topics.topics)) {
                  selectedTopics.remove(topics.topics);
                  _selectedTopics.sendNext(selectedTopics);
                  print(
                      '------------------------------------Removed: ${topics.topics}-------------------------------------');
                } else
                  selectedTopics.add(topics.topics);
                print(
                    '------------------------------------Added: ${topics.topics}-------------------------------------');
                _sharedDataRepository.topics.sendNext(selectedTopics);
                _selectedTopics.sendNext(selectedTopics);
              },
            ),
          ),
        ),
      );
}

/// Constructs new instances of [TopicsSelectionBloc]s via the DI framework.
abstract class TopicsSelectionBlocFactory implements ProvidedService {
  @provide
  TopicsSelectionBloc topicsSelectionBloc();
}
