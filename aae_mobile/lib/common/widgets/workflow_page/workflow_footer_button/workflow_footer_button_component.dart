import 'package:aae/common/widgets/component/component.dart';
import 'package:flutter/material.dart';

import 'workflow_footer_button.dart';
import 'workflow_footer_button_bloc.dart';

/// Wraps an [WorkflowFooterButton] and defines default callback for taps.
class WorkflowFooterButtonComponent extends StatelessWidget {
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

  WorkflowFooterButtonComponent({
    this.buttonLayout = ButtonLayout.horizontal,
    this.primaryButtonText,
    this.primaryButtonEnabled = true,
    this.onPrimaryButtonTapped,
    this.secondaryButtonText,
    this.secondaryButtonEnabled = true,
    this.onSecondaryButtonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Component<WorkflowFooterButtonBloc, WorkflowFooterButtonBlocFactory>(
      bloc: (factory) => factory.workflowFooterButtonBloc(),
      builder: (context, bloc) {
        return WorkflowFooterButton(
          buttonLayout: buttonLayout,
          primaryButtonText: primaryButtonText,
          primaryButtonEnabled: primaryButtonEnabled,
          onPrimaryButtonTapped:
              onPrimaryButtonTapped ?? bloc.onPrimaryButtonPressed,
          secondaryButtonText: secondaryButtonText,
          secondaryButtonEnabled: secondaryButtonEnabled,
          onSecondaryButtonTapped:
              onSecondaryButtonTapped ?? bloc.onSecondaryButtonPressed,
        );
      },
    );
  }
}
