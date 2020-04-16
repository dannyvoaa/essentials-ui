// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topics_selection_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TopicsSelectionViewModel extends TopicsSelectionViewModel {
  @override
  final BuiltList<TopicsViewModel> topics;
  @override
  final bool nextButtonEnabled;

  factory _$TopicsSelectionViewModel(
          [void Function(TopicsSelectionViewModelBuilder) updates]) =>
      (new TopicsSelectionViewModelBuilder()..update(updates)).build();

  _$TopicsSelectionViewModel._({this.topics, this.nextButtonEnabled})
      : super._() {
    if (topics == null) {
      throw new BuiltValueNullFieldError('TopicsSelectionViewModel', 'topics');
    }
    if (nextButtonEnabled == null) {
      throw new BuiltValueNullFieldError(
          'TopicsSelectionViewModel', 'nextButtonEnabled');
    }
  }

  @override
  TopicsSelectionViewModel rebuild(
          void Function(TopicsSelectionViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TopicsSelectionViewModelBuilder toBuilder() =>
      new TopicsSelectionViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TopicsSelectionViewModel &&
        topics == other.topics &&
        nextButtonEnabled == other.nextButtonEnabled;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, topics.hashCode), nextButtonEnabled.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TopicsSelectionViewModel')
          ..add('topics', topics)
          ..add('nextButtonEnabled', nextButtonEnabled))
        .toString();
  }
}

class TopicsSelectionViewModelBuilder
    implements
        Builder<TopicsSelectionViewModel, TopicsSelectionViewModelBuilder> {
  _$TopicsSelectionViewModel _$v;

  ListBuilder<TopicsViewModel> _topics;
  ListBuilder<TopicsViewModel> get topics =>
      _$this._topics ??= new ListBuilder<TopicsViewModel>();
  set topics(ListBuilder<TopicsViewModel> topics) => _$this._topics = topics;

  bool _nextButtonEnabled;
  bool get nextButtonEnabled => _$this._nextButtonEnabled;
  set nextButtonEnabled(bool nextButtonEnabled) =>
      _$this._nextButtonEnabled = nextButtonEnabled;

  TopicsSelectionViewModelBuilder();

  TopicsSelectionViewModelBuilder get _$this {
    if (_$v != null) {
      _topics = _$v.topics?.toBuilder();
      _nextButtonEnabled = _$v.nextButtonEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TopicsSelectionViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TopicsSelectionViewModel;
  }

  @override
  void update(void Function(TopicsSelectionViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TopicsSelectionViewModel build() {
    _$TopicsSelectionViewModel _$result;
    try {
      _$result = _$v ??
          new _$TopicsSelectionViewModel._(
              topics: topics.build(), nextButtonEnabled: nextButtonEnabled);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'topics';
        topics.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TopicsSelectionViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TopicsViewModel extends TopicsViewModel {
  @override
  final String topic;
  @override
  final AaeCommand onTopicPressed;
  @override
  final bool isSelected;

  factory _$TopicsViewModel([void Function(TopicsViewModelBuilder) updates]) =>
      (new TopicsViewModelBuilder()..update(updates)).build();

  _$TopicsViewModel._({this.topic, this.onTopicPressed, this.isSelected})
      : super._() {
    if (topic == null) {
      throw new BuiltValueNullFieldError('TopicsViewModel', 'topic');
    }
    if (onTopicPressed == null) {
      throw new BuiltValueNullFieldError('TopicsViewModel', 'onTopicPressed');
    }
    if (isSelected == null) {
      throw new BuiltValueNullFieldError('TopicsViewModel', 'isSelected');
    }
  }

  @override
  TopicsViewModel rebuild(void Function(TopicsViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TopicsViewModelBuilder toBuilder() =>
      new TopicsViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is TopicsViewModel &&
        topic == other.topic &&
        onTopicPressed == _$dynamicOther.onTopicPressed &&
        isSelected == other.isSelected;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, topic.hashCode), onTopicPressed.hashCode),
        isSelected.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TopicsViewModel')
          ..add('topic', topic)
          ..add('onTopicPressed', onTopicPressed)
          ..add('isSelected', isSelected))
        .toString();
  }
}

class TopicsViewModelBuilder
    implements Builder<TopicsViewModel, TopicsViewModelBuilder> {
  _$TopicsViewModel _$v;

  String _topic;
  String get topic => _$this._topic;
  set topic(String topic) => _$this._topic = topic;

  AaeCommand _onTopicPressed;
  AaeCommand get onTopicPressed => _$this._onTopicPressed;
  set onTopicPressed(AaeCommand onTopicPressed) =>
      _$this._onTopicPressed = onTopicPressed;

  bool _isSelected;
  bool get isSelected => _$this._isSelected;
  set isSelected(bool isSelected) => _$this._isSelected = isSelected;

  TopicsViewModelBuilder();

  TopicsViewModelBuilder get _$this {
    if (_$v != null) {
      _topic = _$v.topic;
      _onTopicPressed = _$v.onTopicPressed;
      _isSelected = _$v.isSelected;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TopicsViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TopicsViewModel;
  }

  @override
  void update(void Function(TopicsViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TopicsViewModel build() {
    final _$result = _$v ??
        new _$TopicsViewModel._(
            topic: topic,
            onTopicPressed: onTopicPressed,
            isSelected: isSelected);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
