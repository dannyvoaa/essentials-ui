import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_exp_panel.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_passenger_panel.dart';
import 'package:slider_button/slider_button.dart';

class ReservationView extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  final String origin;
  final String destination;
//  final Map<String, String> args;

  ReservationView({
    this.viewModel,
    this.origin,
    this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTripsContainer(context);
  }

  Widget _buildTripsContainer(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: AaeDimens.smallCardVerticalContentPadding),
                  child: SizedBox(
                    height: 48.00,
                    child: Column(children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            'DFW - MAD 11/22/2020',
                            style: AaeTextStyles.reservationHeading,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Nov 22 - Nov 30 Boards 10:45 AM',
                            style: AaeTextStyles.reservationSubHeading,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Container(
                child: TripsExpPanel(),
              ),
              Container(
                child: TripsPassengerPanel(),
              ),
              Container(
                child: TripsCollection(viewModel: null, header: 'Tools'),
              ),
              Container(
                child: CancelSlider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CancelSlider extends StatelessWidget {
  const CancelSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:12.0),
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
            color: AaeColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
//          margin: marginOnly(right: 12),
          ),
        ),
        icon: Center(
            child: Icon(
              Icons.arrow_forward_sharp,
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
        buttonColor: AaeColors.white,
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



//import 'package:aae/travel/component/trips/trips_collection.dart';
//import 'package:flutter/material.dart';
//import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
//
//class ReservationView extends StatelessWidget {
//  final ReservationDetailViewModel viewModel;
//
//  ReservationView({
//    @required this.viewModel,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return _buildReservationContainer(context);
//  }
//
//  Widget _buildReservationContainer(BuildContext context) {
//    return Container(
//        child: SingleChildScrollView(
//            scrollDirection: Axis.vertical,
//            child: Column(
//              //?
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Text('testing res view'),
//                Text('testing res view'),
////                TripsCollection(viewModel: this.viewModel, header: 'Current trips'),
////                TripsCollection(viewModel: null, header: 'Tools')
//              ],
//            )),
//        padding: const EdgeInsets.all(16.0));
//  }
//}