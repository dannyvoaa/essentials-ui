import 'package:aae/common/widgets/button/large_button.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum InternationalDetailsEditMode { readOnly, editable }

/// The action bar at the bottom of the international details screen providing
/// "Edit", "Continue" and "Save" buttons depending on the state of the screen.
///
/// This is a "dumb" widget in that it only knows to execute callback methods
/// when corresponding button clicks occur.
class InternationalDetailsActionBar extends StatefulWidget {
  static final _log = Logger('InternationalDetailsActionBar');

  final InternationalDetailsEditMode initialMode;
  final Function(BuildContext) onContinuePressed;
  final Function(BuildContext) onEditPressed;
  final Function(BuildContext) onSavePressed;

  /// Builds an action bar that will transition between an "Edit" & "Continue"
  /// state and a "Save" state, delivering callback events on button clicks.
  InternationalDetailsActionBar({
    @required this.initialMode,
    @required this.onContinuePressed,
    @required this.onEditPressed,
    @required this.onSavePressed,
  });

  @override
  _InternationalDetailsActionBarState createState() =>
      _InternationalDetailsActionBarState(this.initialMode);
}

class _InternationalDetailsActionBarState extends State<InternationalDetailsActionBar> {
  InternationalDetailsEditMode currentMode;

  _InternationalDetailsActionBarState(this.currentMode);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x29131313),
            offset: Offset(0, -2),
            blurRadius: 3,
          ),
        ],
      ),
      child: AnimatedSwitcher(
        child: Row(
          // we are binding the key of this widget to the current edit mode to
          // trigger transition animations when a button layout change is needed
          key: ValueKey<InternationalDetailsEditMode>(currentMode),
          children: [
            ..._buildButtons(context),
          ],
        ),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    switch (widget.initialMode) {
      case InternationalDetailsEditMode.readOnly:
        return _buildReadOnlyModeButtons(context);

      case InternationalDetailsEditMode.editable:
        return _buildEditModeButtons(context);

      default:
        return [];
    }
  }

  List<Widget> _buildReadOnlyModeButtons(BuildContext context) {
    return [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(AaeDimens.baseUnit3_4x),
          child: LargeButton.secondary(
            stringTitle: 'Edit',
            onTapAction: () {
              this.setState(() => currentMode = InternationalDetailsEditMode.editable);
              if (widget.onEditPressed != null) widget.onEditPressed(context);
            },
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(AaeDimens.baseUnit3_4x),
          child: LargeButton.primary(
            stringTitle: 'Continue',
            onTapAction: () {
              InternationalDetailsActionBar._log.info("clicked continue in international details");
              if (widget.onContinuePressed != null) widget.onContinuePressed(context);
            },
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildEditModeButtons(BuildContext context) {
    return [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(AaeDimens.baseUnit3_4x),
          child: LargeButton.primary(
            stringTitle: 'Save',
            onTapAction: () {
              this.setState(() => currentMode = InternationalDetailsEditMode.readOnly);
              if (widget.onSavePressed != null) widget.onSavePressed(context);
            },
          ),
        ),
      ),
    ];
  }
}
