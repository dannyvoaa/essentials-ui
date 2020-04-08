import 'package:aae/common/widgets/button/aee_button.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

enum ButtonLayout { horizontal, vertical }

@visibleForTesting
const primaryButtonKey = Key('primaryButton');

@visibleForTesting
const secondaryButtonKey = Key('secondaryButton');

/// A reusable [Widget] that contains the footer navigation buttons for
/// flows.
///

class WorkflowFooterButton extends StatelessWidget {
  /// How the buttons will be laid out in the footer.
  ///
  /// In [ButtonLayout.horizontal], each button will take up 50% of the width of
  /// the screen, max. The minimum size will wrap the text and be aligned to the
  /// edges of the screen.
  ///
  /// In [ButtonLayout.vertical], each button will take up the full screen width
  /// and have a set height.
  final ButtonLayout buttonLayout;

  /// The text for the primary (right) button.
  /// This is optional, null here will hide the widget.
  final String primaryButtonText;

  /// If the primary button is enabled or not.
  ///
  /// A disabled button will not fire its onTapped function.
  final bool primaryButtonEnabled;

  /// The callback to invoke when the primary (right) button is tapped.
  final GestureTapCallback onPrimaryButtonTapped;

  /// The text for the secondary (left) button.
  /// This is optional, null here will hide the widget.
  final String secondaryButtonText;

  /// If the secondary button is enabled or not.
  ///
  /// A disabled button will not fire its onTapped function.
  final bool secondaryButtonEnabled;

  /// The callback to invoke when the secondary (left) button is tapped.
  final GestureTapCallback onSecondaryButtonTapped;

  final Widget _primaryButton;

  final Widget _secondaryButton;

  WorkflowFooterButton({
    this.buttonLayout = ButtonLayout.horizontal,
    this.primaryButtonText,
    this.primaryButtonEnabled = true,
    this.onPrimaryButtonTapped,
    this.secondaryButtonText,
    this.secondaryButtonEnabled = true,
    this.onSecondaryButtonTapped,
  })  : _primaryButton = isEmpty(primaryButtonText)
            ? null
            : AaeButton.primaryRegular(
                key: primaryButtonKey,
                text: primaryButtonText,
                enabled: primaryButtonEnabled,
                onTapped: onPrimaryButtonTapped,
              ),
        _secondaryButton = isEmpty(secondaryButtonText)
            ? null
            : AaeButton.secondaryRegular(
                key: secondaryButtonKey,
                text: secondaryButtonText,
                enabled: secondaryButtonEnabled,
                onTapped: onSecondaryButtonTapped,
              );

  @override
  Widget build(BuildContext context) {
    if (_primaryButton != null || _secondaryButton != null) {
      switch (buttonLayout) {
        case ButtonLayout.horizontal:
          return _horizontalLayout();
        case ButtonLayout.vertical:
          return _verticalLayout();
      }
    }

    // This is both here to make sure adding more ButtonLayouts causes a
    // compilation error in the switch above, and that if no buttons exist then
    // we return a view that takes up no space.
    return Container();
  }

  /// Builds the horizontal layout for the buttons.
  ///
  /// The buttons will be on the left and right edges of the screen.
  Widget _horizontalLayout() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AaeDimens.workflowButtonHorizontalFooterTopMargin,
        bottom: AaeDimens.workflowButtonHorizontalFooterBottomMargin,
      ).add(EdgeInsets.symmetric(
        horizontal: AaeDimens.workflowButtonHorizontalFooterSideMargin,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _secondaryButton,
          SizedBox(
              width: AaeDimens.workflowButtonHorizontalFooterButtonSpacing),
          _primaryButton,
        ].where((object) => object != null).toList(),
      ),
    );
  }

  /// Builds the vertical layout for the buttons.
  Widget _verticalLayout() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AaeDimens.workflowButtonVerticalFooterTopMargin,
        bottom: AaeDimens.workflowButtonVerticalFooterBottomMargin,
      ).add(EdgeInsets.symmetric(
        horizontal: AaeDimens.workflowButtonVerticalFooterSideMargin,
      )),
      // Constrain the buttons to a max width.
      child: Container(
        constraints: BoxConstraints(maxWidth: AaeDimens.contentMaxWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _primaryButton,
            SizedBox(
                height: AaeDimens.workflowButtonVerticalFooterButtonSpacing),
            _secondaryButton,
          ].where((object) => object != null).toList(),
        ),
      ),
    );
  }
}
