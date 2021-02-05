import 'package:aae/model/pnr.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

class TripsButton extends StatelessWidget {
  TripsButton({this.pnr, this.context});

  final Pnr pnr;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return _buildTripsButton(context);
  }

  _buildTripsButton(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 6,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${pnr.description}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                color: AaeColors.darkGray,
              ),
              textAlign: TextAlign.left,
            ),
          )),
      Expanded(
        flex: 2,
        child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${pnr.recordLocator}',
              style: TextStyle(
                fontSize: 15,
                color: AaeColors.mediumGray,
              ),
              textAlign: TextAlign.right,
            )),
      ),
    ]);
  }
}
