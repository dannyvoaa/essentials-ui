import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

/// An image that takes up most of the screen underneath the title and body
/// in a [WorkflowPageTemplate].
///
class WorkflowPageImage extends StatelessWidget {
  final ImageProvider image;

  WorkflowPageImage({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AaeDimens.workflowBodyBottomMargin,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: AaeDimens.workflowImageMaxHeight,
        ),
        child: Image(
          image: image,
        ),
      ),
    );
  }
}
