// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workgroups_selection_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkgroupsSelectionViewModel extends WorkgroupsSelectionViewModel {
  @override
  final BuiltList<WorkgroupsViewModel> workgroups;
  @override
  final AaeValueCommand<Workgroup> onWorkgroupsSubmitted;
  @override
  final bool nextButtonEnabled;

  factory _$WorkgroupsSelectionViewModel(
          [void Function(WorkgroupsSelectionViewModelBuilder) updates]) =>
      (new WorkgroupsSelectionViewModelBuilder()..update(updates)).build();

  _$WorkgroupsSelectionViewModel._(
      {this.workgroups, this.onWorkgroupsSubmitted, this.nextButtonEnabled})
      : super._() {
    if (workgroups == null) {
      throw new BuiltValueNullFieldError(
          'WorkgroupsSelectionViewModel', 'workgroups');
    }
    if (onWorkgroupsSubmitted == null) {
      throw new BuiltValueNullFieldError(
          'WorkgroupsSelectionViewModel', 'onWorkgroupsSubmitted');
    }
    if (nextButtonEnabled == null) {
      throw new BuiltValueNullFieldError(
          'WorkgroupsSelectionViewModel', 'nextButtonEnabled');
    }
  }

  @override
  WorkgroupsSelectionViewModel rebuild(
          void Function(WorkgroupsSelectionViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkgroupsSelectionViewModelBuilder toBuilder() =>
      new WorkgroupsSelectionViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final _$dynamicOther = other as dynamic;
    return other is WorkgroupsSelectionViewModel &&
        workgroups == other.workgroups &&
        onWorkgroupsSubmitted == _$dynamicOther.onWorkgroupsSubmitted &&
        nextButtonEnabled == other.nextButtonEnabled;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, workgroups.hashCode), onWorkgroupsSubmitted.hashCode),
        nextButtonEnabled.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WorkgroupsSelectionViewModel')
          ..add('workgroups', workgroups)
          ..add('onWorkgroupsSubmitted', onWorkgroupsSubmitted)
          ..add('nextButtonEnabled', nextButtonEnabled))
        .toString();
  }
}

class WorkgroupsSelectionViewModelBuilder
    implements
        Builder<WorkgroupsSelectionViewModel,
            WorkgroupsSelectionViewModelBuilder> {
  _$WorkgroupsSelectionViewModel _$v;

  ListBuilder<WorkgroupsViewModel> _workgroups;
  ListBuilder<WorkgroupsViewModel> get workgroups =>
      _$this._workgroups ??= new ListBuilder<WorkgroupsViewModel>();
  set workgroups(ListBuilder<WorkgroupsViewModel> workgroups) =>
      _$this._workgroups = workgroups;

  AaeValueCommand<Workgroup> _onWorkgroupsSubmitted;
  AaeValueCommand<Workgroup> get onWorkgroupsSubmitted =>
      _$this._onWorkgroupsSubmitted;
  set onWorkgroupsSubmitted(AaeValueCommand<Workgroup> onWorkgroupsSubmitted) =>
      _$this._onWorkgroupsSubmitted = onWorkgroupsSubmitted;

  bool _nextButtonEnabled;
  bool get nextButtonEnabled => _$this._nextButtonEnabled;
  set nextButtonEnabled(bool nextButtonEnabled) =>
      _$this._nextButtonEnabled = nextButtonEnabled;

  WorkgroupsSelectionViewModelBuilder();

  WorkgroupsSelectionViewModelBuilder get _$this {
    if (_$v != null) {
      _workgroups = _$v.workgroups?.toBuilder();
      _onWorkgroupsSubmitted = _$v.onWorkgroupsSubmitted;
      _nextButtonEnabled = _$v.nextButtonEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkgroupsSelectionViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WorkgroupsSelectionViewModel;
  }

  @override
  void update(void Function(WorkgroupsSelectionViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WorkgroupsSelectionViewModel build() {
    _$WorkgroupsSelectionViewModel _$result;
    try {
      _$result = _$v ??
          new _$WorkgroupsSelectionViewModel._(
              workgroups: workgroups.build(),
              onWorkgroupsSubmitted: onWorkgroupsSubmitted,
              nextButtonEnabled: nextButtonEnabled);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'workgroups';
        workgroups.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WorkgroupsSelectionViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$WorkgroupsViewModel extends WorkgroupsViewModel {
  @override
  final String workgroup;
  @override
  final Optional<Color> borderColor;
  @override
  final AaeCommand onWorkgroupPressed;

  factory _$WorkgroupsViewModel(
          [void Function(WorkgroupsViewModelBuilder) updates]) =>
      (new WorkgroupsViewModelBuilder()..update(updates)).build();

  _$WorkgroupsViewModel._(
      {this.workgroup, this.borderColor, this.onWorkgroupPressed})
      : super._() {
    if (workgroup == null) {
      throw new BuiltValueNullFieldError('WorkgroupsViewModel', 'workgroup');
    }
    if (borderColor == null) {
      throw new BuiltValueNullFieldError('WorkgroupsViewModel', 'borderColor');
    }
    if (onWorkgroupPressed == null) {
      throw new BuiltValueNullFieldError(
          'WorkgroupsViewModel', 'onWorkgroupPressed');
    }
  }

  @override
  WorkgroupsViewModel rebuild(
          void Function(WorkgroupsViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkgroupsViewModelBuilder toBuilder() =>
      new WorkgroupsViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkgroupsViewModel &&
        workgroup == other.workgroup &&
        borderColor == other.borderColor;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, workgroup.hashCode), borderColor.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WorkgroupsViewModel')
          ..add('workgroup', workgroup)
          ..add('borderColor', borderColor)
          ..add('onWorkgroupPressed', onWorkgroupPressed))
        .toString();
  }
}

class WorkgroupsViewModelBuilder
    implements Builder<WorkgroupsViewModel, WorkgroupsViewModelBuilder> {
  _$WorkgroupsViewModel _$v;

  String _workgroup;
  String get workgroup => _$this._workgroup;
  set workgroup(String workgroup) => _$this._workgroup = workgroup;

  Optional<Color> _borderColor;
  Optional<Color> get borderColor => _$this._borderColor;
  set borderColor(Optional<Color> borderColor) =>
      _$this._borderColor = borderColor;

  AaeCommand _onWorkgroupPressed;
  AaeCommand get onWorkgroupPressed => _$this._onWorkgroupPressed;
  set onWorkgroupPressed(AaeCommand onWorkgroupPressed) =>
      _$this._onWorkgroupPressed = onWorkgroupPressed;

  WorkgroupsViewModelBuilder();

  WorkgroupsViewModelBuilder get _$this {
    if (_$v != null) {
      _workgroup = _$v.workgroup;
      _borderColor = _$v.borderColor;
      _onWorkgroupPressed = _$v.onWorkgroupPressed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkgroupsViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WorkgroupsViewModel;
  }

  @override
  void update(void Function(WorkgroupsViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WorkgroupsViewModel build() {
    final _$result = _$v ??
        new _$WorkgroupsViewModel._(
            workgroup: workgroup,
            borderColor: borderColor,
            onWorkgroupPressed: onWorkgroupPressed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
