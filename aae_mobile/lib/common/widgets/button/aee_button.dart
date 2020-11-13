import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:quiver/strings.dart';

part 'aee_button.g.dart';

/// Different sizes buttons can be rendered at.
enum ButtonSize {
  regular,
  small,
}

/// Different types of buttons with different color styles.
enum ButtonType {
  primary,
  secondary,
  hairline,
}

const _iconTextMargin = 4.0;
const _border = 2.0;

final _sizeConfigs = <ButtonSize, _SizeConfig>{
  ButtonSize.regular: _SizeConfig((b) => b
    ..height = AaeDimens.regularButtonHeight
    ..iconSize = AaeDimens.regularButtonIconSize
    ..horizontalPadding = AaeDimens.regularButtonHorizontalPadding
    ..iconTextMargin = _iconTextMargin
    ..border = _border
    ..cornerRadius = AaeDimens.regularButtonCornerRadius
    ..text = AaeTextStyles.btn1.copyWith(
      height: 1.0,
    )),
  ButtonSize.small: _SizeConfig((b) => b
    ..height = AaeDimens.smallButtonHeight
    ..iconSize = AaeDimens.smallButtonIconSize
    ..horizontalPadding = AaeDimens.smallButtonHorizontalPadding
    ..iconTextMargin = _iconTextMargin
    ..border = _border
    ..cornerRadius = AaeDimens.smallButtonCornerRadius
    ..text = AaeTextStyles.btn2.copyWith(
      height: 1.0,
    )),
};

final _colorConfigs = <ButtonType, _ColorConfig>{
  ButtonType.primary: _ColorConfig((b) => b
    ..enabledBackground = AaeColors.boardBackground
    ..enabledText = AaeColors.lightGray
    ..enabledBorder = Colors.transparent
    ..disabledBackground = AaeColors.buttonPrimaryDisabledBackground
    ..disabledText = AaeColors.buttonPrimaryDisabledText
    ..disabledBorder = Colors.transparent),
  ButtonType.secondary: _ColorConfig((b) => b
    ..enabledBackground = AaeColors.buttonSecondaryBackground
    ..enabledText = AaeColors.buttonSecondaryText
    ..enabledBorder = Colors.transparent
    ..disabledBackground = AaeColors.buttonSecondaryDisabledBackground
    ..disabledText = AaeColors.buttonSecondaryDisabledText
    ..disabledBorder = Colors.transparent),
  ButtonType.hairline: _ColorConfig((b) => b
    ..enabledBackground = Colors.transparent
    ..enabledText = AaeColors.buttonHairlineText
    ..enabledBorder = AaeColors.buttonHairlineBackground
    ..disabledBackground = Colors.transparent
    ..disabledText = AaeColors.buttonHairlineDisabledText
    ..disabledBorder = AaeColors.buttonHairlineDisabledBackground),
};

/// A generic button that contains text and an icon.
class AaeButton extends StatelessWidget {
  /// The text to render within the button.
  final String text;

  /// The width to render the button at.
  ///
  /// When this is not set, the button will just wrap its content. To have a
  /// button that expands to the full width of the containing widget, set this
  /// width to [double.infinity]. In [Column]s, you can also use
  /// [CrossAxisAlignment.stretch].
  ///

  final double width;

  /// The icon to render within the button.
  final IconData icon;

  /// The callback to be invoked when the button is tapped.
  ///
  /// If this is null, the button will look very weird because Flutter will
  /// disable it by default. The text color will be wrong though, and this is
  /// intentional to reduce the possibility of programmer error (all buttons
  /// should do something when tapped).
  final GestureTapCallback onTapped;

  /// Whether or not the button is currently enabled.
  final bool enabled;

  /// The size to render the button at.
  final _SizeConfig _sizeConfig;

  /// The color configuration  of this button.
  final _ColorConfig _colorConfig;

  //
  // Convenience constructors:
  //

  AaeButton.primaryRegular({
    String text,
    IconData icon,
    GestureTapCallback onTapped,
    bool enabled,
    double width,
    Key key,
  }) : this(
          type: ButtonType.primary,
          size: ButtonSize.regular,
          text: text,
          icon: icon,
          onTapped: onTapped,
          enabled: enabled,
          width: width,
          key: key,
        );

  AaeButton.primarySmall({
    String text,
    IconData icon,
    GestureTapCallback onTapped,
    bool enabled,
    double width,
    Key key,
  }) : this(
          type: ButtonType.primary,
          size: ButtonSize.small,
          text: text,
          icon: icon,
          onTapped: onTapped,
          enabled: enabled,
          width: width,
          key: key,
        );

  AaeButton.secondaryRegular({
    String text,
    IconData icon,
    GestureTapCallback onTapped,
    bool enabled,
    double width,
    Key key,
  }) : this(
          type: ButtonType.secondary,
          size: ButtonSize.regular,
          text: text,
          icon: icon,
          onTapped: onTapped,
          enabled: enabled,
          width: width,
          key: key,
        );

  AaeButton.secondarySmall({
    String text,
    IconData icon,
    GestureTapCallback onTapped,
    bool enabled,
    double width,
    Key key,
  }) : this(
          type: ButtonType.secondary,
          size: ButtonSize.small,
          text: text,
          icon: icon,
          onTapped: onTapped,
          enabled: enabled,
          width: width,
          key: key,
        );

  AaeButton.hairlineRegular({
    String text,
    IconData icon,
    GestureTapCallback onTapped,
    bool enabled,
    double width,
    Key key,
  }) : this(
          type: ButtonType.hairline,
          size: ButtonSize.regular,
          text: text,
          icon: icon,
          onTapped: onTapped,
          enabled: enabled,
          width: width,
          key: key,
        );

  AaeButton.hairlineSmall({
    String text,
    IconData icon,
    GestureTapCallback onTapped,
    bool enabled,
    double width,
    Key key,
  }) : this(
          type: ButtonType.hairline,
          size: ButtonSize.small,
          text: text,
          icon: icon,
          onTapped: onTapped,
          enabled: enabled,
          width: width,
          key: key,
        );

  //
  // Implementation:
  //

  AaeButton({
    @required ButtonSize size,
    @required ButtonType type,
    this.text,
    this.icon,
    this.onTapped,
    this.width,
    bool enabled,
    Key key,
  })  : enabled = enabled ?? true,
        _sizeConfig = _sizeConfigs[size],
        _colorConfig = _colorConfigs[type],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonWidget;
    if (icon != null && isNotEmpty(text)) {
      // Make a RaisedButton with text and icon, using the convenience
      // constructor.
      buttonWidget = RaisedButton.icon(
        icon: _buildIcon(context),
        label: _buildLabel(context),
        // The below fields are the same as the other buttons.
        onPressed: _onPressed(),
        elevation: AaeDimens.noElevation,
        color: _colorConfig.background(enabled),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _colorConfig.border(enabled),
            width: _sizeConfig.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(_sizeConfig.cornerRadius),
          ),
        ),
      );
    } else if (icon != null && isEmpty(text)) {
      // Make a RaisedButton with just an icon.
      final borderRadius =
          BorderRadius.all(Radius.circular(_sizeConfig.cornerRadius));
      buttonWidget = InkWell(
        onTap: _onPressed(),
        borderRadius: borderRadius,
        child: Container(
          decoration: ShapeDecoration(
              color: _colorConfig.background(enabled),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: _colorConfig.border(enabled),
                  width: _sizeConfig.border,
                ),
                borderRadius: borderRadius,
              )),
          child: Icon(icon, size: _sizeConfig.iconSize),
        ),
      );
    } else if (icon == null && isNotEmpty(text)) {
      // Make a RaisedButton with just text.
      buttonWidget = RaisedButton(
        child: _buildLabel(context),
        // The below fields are the same as the other buttons.
        onPressed: _onPressed(),
        elevation: AaeDimens.noElevation,
        color: _colorConfig.background(enabled),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _colorConfig.border(enabled),
            width: _sizeConfig.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(_sizeConfig.cornerRadius),
          ),
        ),
      );
    } else {
      buttonWidget = Container();
    }

    return SizedBox(
      height: _sizeConfig.height,
      width: width,
      child: buttonWidget,
    );
  }

  /// Allow the [enabled] field to enable and disable the native buttons, which
  /// base that state on the presence of a function in onPressed.
  ///
  /// theme can support it.
  VoidCallback _onPressed() => enabled ? onTapped : () => {};

  Widget _buildIcon(BuildContext context) {
    return Icon(
      icon,
      size: _sizeConfig.text.fontSize,
      color: _colorConfig.text(enabled),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: _sizeConfig.text.copyWith(
        color: _colorConfig.text(enabled),
      ),
    );
  }
}

/// A configuration class for storing different sizing configurations for
/// different [ButtonSize]s.
abstract class _SizeConfig implements Built<_SizeConfig, _SizeConfigBuilder> {
  double get height;

  double get iconSize;

  double get horizontalPadding;

  double get iconTextMargin;

  double get border;

  double get cornerRadius;

  TextStyle get text;

  _SizeConfig._();

  factory _SizeConfig([updates(_SizeConfigBuilder b)]) = _$SizeConfig;
}

/// A configuration class for storing different color configurations for
/// different [ButtonType]s.
abstract class _ColorConfig
    implements Built<_ColorConfig, _ColorConfigBuilder> {
  Color get enabledBackground;

  Color get enabledText;

  Color get enabledBorder;

  Color get disabledBackground;

  Color get disabledText;

  Color get disabledBorder;

  Color background(bool enabled) =>
      enabled ? enabledBackground : disabledBackground;

  Color text(bool enabled) => enabled ? enabledText : disabledText;

  Color border(bool enabled) => enabled ? enabledBorder : disabledBorder;

  _ColorConfig._();

  factory _ColorConfig([updates(_ColorConfigBuilder b)]) = _$ColorConfig;
}
