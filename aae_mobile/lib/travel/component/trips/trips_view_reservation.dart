import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'trips_view_model.dart';
import 'package:get/get.dart';
import 'package:aae/theme/colors.dart';

class TripsReservationView extends StatefulWidget {
  final TripsViewModel viewModel;

  TripsReservationView({
    @required this.viewModel,
  });

  @override
  _TripsViewState createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsReservationView> {
  @override
  Widget build(BuildContext context) {
    return _buildTripsContainer(context);
  }

  Widget _buildTripsContainer(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
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
          )),
//          padding: const EdgeInsets.all(16.0)),
    );
  }
}
