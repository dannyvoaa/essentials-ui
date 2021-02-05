import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

const _strokeWidth = 2.0;

class AaeLoadingSpinner extends StatelessWidget {
  /// The progressValue argument can be either null for an indeterminate
  /// progress indicator, or non-null for a determinate progress indicator with
  /// the given value.
  ///
  /// See [CircularProgressIndicator.value] for details.
  final double progressValue;

  const AaeLoadingSpinner({
    Key key,
    this.progressValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: progressValue,
      strokeWidth: _strokeWidth,
      valueColor: AlwaysStoppedAnimation<Color>(AaeColors.recognitionGreen),
    );
  }
}
