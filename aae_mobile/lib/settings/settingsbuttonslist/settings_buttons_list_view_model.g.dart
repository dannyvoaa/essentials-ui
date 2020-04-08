// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_buttons_list_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SettingsButtonsListViewModel extends SettingsButtonsListViewModel {
  @override
  final List<SettingsButton> buttons;

  factory _$SettingsButtonsListViewModel(
          [void Function(SettingsButtonsListViewModelBuilder) updates]) =>
      (new SettingsButtonsListViewModelBuilder()..update(updates)).build();

  _$SettingsButtonsListViewModel._({this.buttons}) : super._() {
    if (buttons == null) {
      throw new BuiltValueNullFieldError(
          'SettingsButtonsListViewModel', 'buttons');
    }
  }

  @override
  SettingsButtonsListViewModel rebuild(
          void Function(SettingsButtonsListViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsButtonsListViewModelBuilder toBuilder() =>
      new SettingsButtonsListViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsButtonsListViewModel && buttons == other.buttons;
  }

  @override
  int get hashCode {
    return $jf($jc(0, buttons.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsButtonsListViewModel')
          ..add('buttons', buttons))
        .toString();
  }
}

class SettingsButtonsListViewModelBuilder
    implements
        Builder<SettingsButtonsListViewModel,
            SettingsButtonsListViewModelBuilder> {
  _$SettingsButtonsListViewModel _$v;

  List<SettingsButton> _buttons;
  List<SettingsButton> get buttons => _$this._buttons;
  set buttons(List<SettingsButton> buttons) => _$this._buttons = buttons;

  SettingsButtonsListViewModelBuilder();

  SettingsButtonsListViewModelBuilder get _$this {
    if (_$v != null) {
      _buttons = _$v.buttons;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsButtonsListViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SettingsButtonsListViewModel;
  }

  @override
  void update(void Function(SettingsButtonsListViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsButtonsListViewModel build() {
    final _$result =
        _$v ?? new _$SettingsButtonsListViewModel._(buttons: buttons);
    replace(_$result);
    return _$result;
  }
}

class _$SettingsButton extends SettingsButton {
  @override
  final String text;
  @override
  final IconData icon;
  @override
  final AaeContextCommand route;

  factory _$SettingsButton([void Function(SettingsButtonBuilder) updates]) =>
      (new SettingsButtonBuilder()..update(updates)).build();

  _$SettingsButton._({this.text, this.icon, this.route}) : super._() {
    if (text == null) {
      throw new BuiltValueNullFieldError('SettingsButton', 'text');
    }
    if (icon == null) {
      throw new BuiltValueNullFieldError('SettingsButton', 'icon');
    }
    if (route == null) {
      throw new BuiltValueNullFieldError('SettingsButton', 'route');
    }
  }

  @override
  SettingsButton rebuild(void Function(SettingsButtonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsButtonBuilder toBuilder() =>
      new SettingsButtonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final _$dynamicOther = other as dynamic;
    return other is SettingsButton &&
        text == other.text &&
        icon == other.icon &&
        route == _$dynamicOther.route;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, text.hashCode), icon.hashCode), route.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsButton')
          ..add('text', text)
          ..add('icon', icon)
          ..add('route', route))
        .toString();
  }
}

class SettingsButtonBuilder
    implements Builder<SettingsButton, SettingsButtonBuilder> {
  _$SettingsButton _$v;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  IconData _icon;
  IconData get icon => _$this._icon;
  set icon(IconData icon) => _$this._icon = icon;

  AaeContextCommand _route;
  AaeContextCommand get route => _$this._route;
  set route(AaeContextCommand route) => _$this._route = route;

  SettingsButtonBuilder();

  SettingsButtonBuilder get _$this {
    if (_$v != null) {
      _text = _$v.text;
      _icon = _$v.icon;
      _route = _$v.route;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsButton other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SettingsButton;
  }

  @override
  void update(void Function(SettingsButtonBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsButton build() {
    final _$result =
        _$v ?? new _$SettingsButton._(text: text, icon: icon, route: route);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
