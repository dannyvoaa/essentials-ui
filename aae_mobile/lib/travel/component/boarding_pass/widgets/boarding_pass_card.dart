import 'package:aae/model/boarding_pass.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_view_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:built_collection/built_collection.dart';

class BoardingPassCard extends StatelessWidget {
  final BoardingPass boardingPass;

  BoardingPassCard({
    this.boardingPass,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom:16,
      ),
      width: MediaQuery.of(context).size.width,
      height: 600,
      margin: EdgeInsets.only(
        left: 0,
        top: 6,
        bottom:12,
      ),
      decoration: BoxDecoration(
        color: AaeColors.white100,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: AaeColors.lightGray,
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 18.0,
              right: 18.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  boardingPass.firstName + ' ' + boardingPass.lastName,
                  style: AaeTextStyles.body16,
                ),
                Text(
                  'Seat ' + (boardingPass.seatNumber ?? '--'),
                  style: AaeTextStyles.body16,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: QrImage(
                data: boardingPass.barcodeString,
                version: QrVersions.auto,
                gapless: true,
              ),
            ),
          ),
          Container(
            height: boardingPass.isTsaPrecheck ? 40 : 0,
            width: 100,
            child: Image.asset(
              'assets/common/TSAPreCheck_logo.png',
            ),
          ),
        ],
      ),
    );
  }
}