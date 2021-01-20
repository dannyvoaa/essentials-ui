import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class D0StatsTick extends StatelessWidget {
  final String identifier;
  final String data;
  final String changeColor;

  D0StatsTick(this.identifier, this.data, this.changeColor);

  @override
  Widget build(BuildContext context) => RichText(
          text: TextSpan(
              text: identifier,
              style: AaeTextStyles.t2.copyWith(color: AaeColors.black, fontSize: 12.0,),
              children: <TextSpan>[
            TextSpan(
                text: data,
                style: AaeTextStyles.t2.copyWith(color: getColor(changeColor), fontSize: 12.0,))
          ]));

  Color getColor(String colorId) {
    return colorId == "Black" ? AaeColors.black : colorId == "Green" ? AaeColors.recognitionGreen : AaeColors.red;
  }
}

class D0StatsTickPercent extends StatelessWidget {
  final String identifier;
  final String data;
  final String changeColor;

  D0StatsTickPercent(this.identifier, this.data, this.changeColor);

  @override
  Widget build(BuildContext context) => RichText(
      text: TextSpan(
          text: identifier,
          style: AaeTextStyles.t2.copyWith(color: AaeColors.black, fontSize: 12.0,),
          children: <TextSpan>[
            TextSpan(
                text: data + "%",
                style: AaeTextStyles.t2.copyWith(color: getColor(changeColor), fontSize: 12.0,))
          ]));

  Color getColor(String colorId) {
    return colorId == "Black" ? AaeColors.black : colorId == "Green" ? AaeColors.recognitionGreen : AaeColors.red;
  }
}