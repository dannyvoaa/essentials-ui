import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

class CancelSlider extends StatelessWidget {
  const CancelSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SliderButton(
        action: () {
          ///Do something here OnSlide
          Navigator.pop(context);
          print('slide button has been slid...');
        },

        ///Put label over here
        label: Text(
          "Slide to cancel trip",
          style: TextStyle(
            color: AaeColors.white100,
            fontWeight: FontWeight.w500,
            fontSize: 16,
//          margin: marginOnly(right: 12),
          ),
        ),
        icon: Center(
            child: Icon(
              Icons.arrow_forward_ios,
              color: AaeColors.mediumGray,
              size: 26.0,
              semanticLabel: 'Slide to cancel trip',
            )),

        ///Change All the color and size from here.
        width: 300,
        height: 50,
        buttonSize: 44,
        boxShadow: BoxShadow(
          color: AaeColors.darkGray,
          blurRadius: 4,
        ),
        radius: 10,
        buttonColor: AaeColors.white100,
        backgroundColor: AaeColors.mediumGray,
        highlightedColor: Colors.white,
        baseColor: Colors.red,
        shimmer: false,
        vibrationFlag: true,
        dismissible: false,
        alignLabel: Alignment(0, 0),
      ),
    );
  }
}