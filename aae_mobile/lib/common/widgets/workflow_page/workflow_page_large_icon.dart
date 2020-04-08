import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

/// A large icon that takes up most of the screen in a [WorkflowPageTemplate]
/// widget.
///
class WorkflowPageLargeIcon extends StatelessWidget {
  final IconData icon;

  WorkflowPageLargeIcon({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: AaeDimens.workflowLargeIconSize,
      color: AaeColors.disabledText,
    );
  }
}
