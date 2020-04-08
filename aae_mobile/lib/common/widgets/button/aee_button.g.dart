// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aee_button.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SizeConfig extends _SizeConfig {
  @override
  final double height;
  @override
  final double iconSize;
  @override
  final double horizontalPadding;
  @override
  final double iconTextMargin;
  @override
  final double border;
  @override
  final double cornerRadius;
  @override
  final TextStyle text;

  factory _$SizeConfig([void Function(_SizeConfigBuilder) updates]) =>
      (new _SizeConfigBuilder()..update(updates)).build();

  _$SizeConfig._(
      {this.height,
      this.iconSize,
      this.horizontalPadding,
      this.iconTextMargin,
      this.border,
      this.cornerRadius,
      this.text})
      : super._() {
    if (height == null) {
      throw new BuiltValueNullFieldError('_SizeConfig', 'height');
    }
    if (iconSize == null) {
      throw new BuiltValueNullFieldError('_SizeConfig', 'iconSize');
    }
    if (horizontalPadding == null) {
      throw new BuiltValueNullFieldError('_SizeConfig', 'horizontalPadding');
    }
    if (iconTextMargin == null) {
      throw new BuiltValueNullFieldError('_SizeConfig', 'iconTextMargin');
    }
    if (border == null) {
      throw new BuiltValueNullFieldError('_SizeConfig', 'border');
    }
    if (cornerRadius == null) {
      throw new BuiltValueNullFieldError('_SizeConfig', 'cornerRadius');
    }
    if (text == null) {
      throw new BuiltValueNullFieldError('_SizeConfig', 'text');
    }
  }

  @override
  _SizeConfig rebuild(void Function(_SizeConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _SizeConfigBuilder toBuilder() => new _SizeConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is _SizeConfig &&
        height == other.height &&
        iconSize == other.iconSize &&
        horizontalPadding == other.horizontalPadding &&
        iconTextMargin == other.iconTextMargin &&
        border == other.border &&
        cornerRadius == other.cornerRadius &&
        text == other.text;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, height.hashCode), iconSize.hashCode),
                        horizontalPadding.hashCode),
                    iconTextMargin.hashCode),
                border.hashCode),
            cornerRadius.hashCode),
        text.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('_SizeConfig')
          ..add('height', height)
          ..add('iconSize', iconSize)
          ..add('horizontalPadding', horizontalPadding)
          ..add('iconTextMargin', iconTextMargin)
          ..add('border', border)
          ..add('cornerRadius', cornerRadius)
          ..add('text', text))
        .toString();
  }
}

class _SizeConfigBuilder implements Builder<_SizeConfig, _SizeConfigBuilder> {
  _$SizeConfig _$v;

  double _height;
  double get height => _$this._height;
  set height(double height) => _$this._height = height;

  double _iconSize;
  double get iconSize => _$this._iconSize;
  set iconSize(double iconSize) => _$this._iconSize = iconSize;

  double _horizontalPadding;
  double get horizontalPadding => _$this._horizontalPadding;
  set horizontalPadding(double horizontalPadding) =>
      _$this._horizontalPadding = horizontalPadding;

  double _iconTextMargin;
  double get iconTextMargin => _$this._iconTextMargin;
  set iconTextMargin(double iconTextMargin) =>
      _$this._iconTextMargin = iconTextMargin;

  double _border;
  double get border => _$this._border;
  set border(double border) => _$this._border = border;

  double _cornerRadius;
  double get cornerRadius => _$this._cornerRadius;
  set cornerRadius(double cornerRadius) => _$this._cornerRadius = cornerRadius;

  TextStyle _text;
  TextStyle get text => _$this._text;
  set text(TextStyle text) => _$this._text = text;

  _SizeConfigBuilder();

  _SizeConfigBuilder get _$this {
    if (_$v != null) {
      _height = _$v.height;
      _iconSize = _$v.iconSize;
      _horizontalPadding = _$v.horizontalPadding;
      _iconTextMargin = _$v.iconTextMargin;
      _border = _$v.border;
      _cornerRadius = _$v.cornerRadius;
      _text = _$v.text;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(_SizeConfig other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SizeConfig;
  }

  @override
  void update(void Function(_SizeConfigBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SizeConfig build() {
    final _$result = _$v ??
        new _$SizeConfig._(
            height: height,
            iconSize: iconSize,
            horizontalPadding: horizontalPadding,
            iconTextMargin: iconTextMargin,
            border: border,
            cornerRadius: cornerRadius,
            text: text);
    replace(_$result);
    return _$result;
  }
}

class _$ColorConfig extends _ColorConfig {
  @override
  final Color enabledBackground;
  @override
  final Color enabledText;
  @override
  final Color enabledBorder;
  @override
  final Color disabledBackground;
  @override
  final Color disabledText;
  @override
  final Color disabledBorder;

  factory _$ColorConfig([void Function(_ColorConfigBuilder) updates]) =>
      (new _ColorConfigBuilder()..update(updates)).build();

  _$ColorConfig._(
      {this.enabledBackground,
      this.enabledText,
      this.enabledBorder,
      this.disabledBackground,
      this.disabledText,
      this.disabledBorder})
      : super._() {
    if (enabledBackground == null) {
      throw new BuiltValueNullFieldError('_ColorConfig', 'enabledBackground');
    }
    if (enabledText == null) {
      throw new BuiltValueNullFieldError('_ColorConfig', 'enabledText');
    }
    if (enabledBorder == null) {
      throw new BuiltValueNullFieldError('_ColorConfig', 'enabledBorder');
    }
    if (disabledBackground == null) {
      throw new BuiltValueNullFieldError('_ColorConfig', 'disabledBackground');
    }
    if (disabledText == null) {
      throw new BuiltValueNullFieldError('_ColorConfig', 'disabledText');
    }
    if (disabledBorder == null) {
      throw new BuiltValueNullFieldError('_ColorConfig', 'disabledBorder');
    }
  }

  @override
  _ColorConfig rebuild(void Function(_ColorConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _ColorConfigBuilder toBuilder() => new _ColorConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is _ColorConfig &&
        enabledBackground == other.enabledBackground &&
        enabledText == other.enabledText &&
        enabledBorder == other.enabledBorder &&
        disabledBackground == other.disabledBackground &&
        disabledText == other.disabledText &&
        disabledBorder == other.disabledBorder;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc(0, enabledBackground.hashCode),
                        enabledText.hashCode),
                    enabledBorder.hashCode),
                disabledBackground.hashCode),
            disabledText.hashCode),
        disabledBorder.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('_ColorConfig')
          ..add('enabledBackground', enabledBackground)
          ..add('enabledText', enabledText)
          ..add('enabledBorder', enabledBorder)
          ..add('disabledBackground', disabledBackground)
          ..add('disabledText', disabledText)
          ..add('disabledBorder', disabledBorder))
        .toString();
  }
}

class _ColorConfigBuilder
    implements Builder<_ColorConfig, _ColorConfigBuilder> {
  _$ColorConfig _$v;

  Color _enabledBackground;
  Color get enabledBackground => _$this._enabledBackground;
  set enabledBackground(Color enabledBackground) =>
      _$this._enabledBackground = enabledBackground;

  Color _enabledText;
  Color get enabledText => _$this._enabledText;
  set enabledText(Color enabledText) => _$this._enabledText = enabledText;

  Color _enabledBorder;
  Color get enabledBorder => _$this._enabledBorder;
  set enabledBorder(Color enabledBorder) =>
      _$this._enabledBorder = enabledBorder;

  Color _disabledBackground;
  Color get disabledBackground => _$this._disabledBackground;
  set disabledBackground(Color disabledBackground) =>
      _$this._disabledBackground = disabledBackground;

  Color _disabledText;
  Color get disabledText => _$this._disabledText;
  set disabledText(Color disabledText) => _$this._disabledText = disabledText;

  Color _disabledBorder;
  Color get disabledBorder => _$this._disabledBorder;
  set disabledBorder(Color disabledBorder) =>
      _$this._disabledBorder = disabledBorder;

  _ColorConfigBuilder();

  _ColorConfigBuilder get _$this {
    if (_$v != null) {
      _enabledBackground = _$v.enabledBackground;
      _enabledText = _$v.enabledText;
      _enabledBorder = _$v.enabledBorder;
      _disabledBackground = _$v.disabledBackground;
      _disabledText = _$v.disabledText;
      _disabledBorder = _$v.disabledBorder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(_ColorConfig other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ColorConfig;
  }

  @override
  void update(void Function(_ColorConfigBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ColorConfig build() {
    final _$result = _$v ??
        new _$ColorConfig._(
            enabledBackground: enabledBackground,
            enabledText: enabledText,
            enabledBorder: enabledBorder,
            disabledBackground: disabledBackground,
            disabledText: disabledText,
            disabledBorder: disabledBorder);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
