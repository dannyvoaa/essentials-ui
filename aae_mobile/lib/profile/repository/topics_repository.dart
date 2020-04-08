import 'dart:collection';

import 'package:aae/model/topics.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a list of account topics.
class TopicsRepository {
  static final _log = Logger('TopicsRepository');

  UnmodifiableListView<Topics> _cachedTopicsList;

  @provide
  @singleton
  TopicsRepository();

  /// Gets the list of possible user topics.
  Future<UnmodifiableListView<Topics>> get topicsList async =>
      _cachedTopicsList ??= await _fetchTopicsList();

  Future<UnmodifiableListView<Topics>> _fetchTopicsList() async {
    List<Topics> listOfTopics = List<Topics>();
    listOfTopics.add(Topics((b) => b.topics = 'Topic here'));
    listOfTopics.add(Topics((b) => b.topics = 'Topic here'));
    listOfTopics.add(Topics((b) => b.topics = 'Topic here'));
    listOfTopics.add(Topics((b) => b.topics = 'Topic here'));
    listOfTopics.add(Topics((b) => b.topics = 'Topic here'));
    listOfTopics.add(Topics((b) => b.topics = 'Topic here'));
    listOfTopics.add(Topics((b) => b.topics = 'Topic here'));
    listOfTopics.add(Topics((b) => b.topics = 'Topic here'));
    return UnmodifiableListView(listOfTopics);
  }
}
