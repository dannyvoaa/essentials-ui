//import 'package:aae/recognition/component/points_history/points_history_component.dart';
//import 'package:aae/theme/colors.dart';
//import 'package:aae/theme/dimensions.dart';
//import 'package:flutter/material.dart';
//
//import 'travel_view_model.dart';
//
//class TravelView extends StatelessWidget {
//  final TravelViewModel viewModel;
//
//  TravelView({
//    @required this.viewModel,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(children: <Widget>[
//      _buildTravelContainer(context),
//    ]);
//  }
//
//  Widget _buildTravelContainer(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.all(AaeDimens.baseUnit),
//      child: Container(
//        decoration: BoxDecoration(
//            color: AaeColors.white,
//            borderRadius: BorderRadius.all(
//                Radius.circular(AaeDimens.currentBalanceCardRadius))),
//        height: AaeDimens.currentBalanceCardHeight,
//        width: AaeDimens.contentWidth,
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding:
//                  const EdgeInsets.all(AaeDimens.currentBalanceCardSpacing),
//              child: Text(
//                'Current balance:',
//                style: TextStyle(fontSize: 18),
//              ),
//            ),
//            Center(
//              child: Padding(
//                padding: const EdgeInsets.only(
//                    top: AaeDimens.currentBalanceCardTopMargin),
//                child: Text(
//                  '${viewModel.currentBalance} points',
//                  style: TextStyle(
//                      fontSize: 50,
//                      color: AaeColors.recognitionGreen,
//                      fontWeight: FontWeight.w800),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
