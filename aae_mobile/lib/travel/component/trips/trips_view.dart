import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'trips_view_model.dart';
import 'package:get/get.dart';

class TripsView extends StatefulWidget {
  final TripsViewModel viewModel;

  TripsView({
    @required this.viewModel,
  });

  @override
  _TripsViewState createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
    return _buildTripsContainer(context);
  }

  Widget _buildTripsContainer(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //?
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TripsCollection(viewModel: this.widget.viewModel, header: 'Current trips'),
                TripsCollection(viewModel: null, header: 'Tools')
              ],
            )),
        padding: const EdgeInsets.all(16.0));
  }
}
