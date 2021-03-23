import 'package:aae/model/pnr.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/assets/aae_icons.dart';

class TripsButton extends StatelessWidget {
  TripsButton({this.pnr, this.context});

  final Pnr pnr;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return _buildTripsButton(context);
  }

  _buildTripsButton(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          //trip name
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //record locator and pass type
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text('${pnr.description}',
                      overflow: TextOverflow.ellipsis,
                      style: AaeTextStyles.subtitle18Blue),
                ),
                Text(
                  '${pnr.recordLocator}  ' +
                      String.fromCharCode(0x2022) +
                      '  ${pnr.passType}',
                  style: AaeTextStyles.subtitle15MediumGray,
                ),
              ],
            ),
          ),
        ),
        // arrow icon
        Icon(
          Icons.arrow_forward_ios,
          color: AaeColors.lightGray,
        ),
      ],
    );
  }
}

