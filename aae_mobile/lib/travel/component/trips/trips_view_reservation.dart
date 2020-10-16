import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'trips_view_model.dart';
import 'package:get/get.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:aae/travel/component/ui/trip_exp_panel.dart';

class TripsReservationView extends StatelessWidget {
  final TripsViewModel viewModel;
  final String origin;
  final String destination;
//  final Map<String, String> args;

  TripsReservationView({
    @required this.viewModel,
    @required this.origin,
    @required this.destination,
  });

//  TripsReservationView({@required Map<String, dynamic> arguments})
//      : assert(arguments != null),
//        args = arguments;

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
                    height: 68.00,
                    child: Column(children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text('DFW - MAD 11/22/2020'),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text('Nov 22 - Nov 30 Boards 10:45 AM'),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    TripsExpPanel(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text(
                          "test",
                          style: TextStyle(
                            fontSize: 15,
                            color: AaeColors.blue,
                            fontWeight: FontWeight.w700,
                            height: 2.6666666666666665,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//class TripsExpPanel extends StatelessWidget {
//  const TripsExpPanel({
//    Key key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ExpansionTile(
//      title: Text(
//        'Sub title',
//      ),
//      children: <Widget>[
//        ListTile(
//          title: Text('data'),
//        )
//      ],
//    );
//  }
//}

//class TripsReservationView extends StatefulWidget {
//  final TripsViewModel viewModel;
//
//  TripsReservationView({
//    @required this.viewModel,
//  });
//
//  @override
//  _TripsViewState createState() => _TripsViewState();
//}
//
//class _TripsViewState extends State<TripsReservationView> {
//  @override
//  Widget build(BuildContext context) {
//    return _buildTripsContainer(context);
//  }
//
//  Widget _buildTripsContainer(BuildContext context) {
//    return Scaffold(
//      backgroundColor: const Color(0xfff0f0f0),
//      body: Container(
//          alignment: Alignment.topLeft,
//          child: Padding(
//            padding: const EdgeInsets.only(bottom: 5),
//            child: Text(
//              "test",
//              style: TextStyle(
//                fontSize: 15,
//                color: AaeColors.blue,
//                fontWeight: FontWeight.w700,
//                height: 2.6666666666666665,
//              ),
//              textAlign: TextAlign.left,
//            ),
//          )),
////          padding: const EdgeInsets.all(16.0)),
//    );
//  }
//}
