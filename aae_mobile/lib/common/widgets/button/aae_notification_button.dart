import 'package:flutter/material.dart';

/// A notification button.
class AaeNotificationButton extends StatelessWidget {
  /// Whether or not the button displays new notifications indicator.
  final bool indicator;

  /// The callback to be invoked when the button is tapped.
  final GestureTapCallback onTapped;

  /// The color of this button.
  final Color color;

  AaeNotificationButton(
      {@required this.indicator,
      @required this.onTapped,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: SizedBox(
        width: 24.6,
        height: 22,
        child: CustomPaint(
          foregroundPainter: CustomCirclesPainter(color: color),
        ),
      ),
    );
  }
}

class CustomCirclesPainter extends CustomPainter {
  final Color color;

  CustomCirclesPainter({this.color});

  var button = Paint()
    ..color = Color(0xFF707070)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  double buttonRadius = 10.5;
  double indicatorRadius = 6;

  @override
  void paint(Canvas canvas, Size size) {
    var indicator = Paint()..color = color;
    print(size);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset.zero, buttonRadius, button);
    canvas.drawCircle(Offset(-8.125, -6.95), indicatorRadius, indicator);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
