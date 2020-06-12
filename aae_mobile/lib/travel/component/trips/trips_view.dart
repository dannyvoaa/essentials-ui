import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'trips_view_model.dart';

class TripsView extends StatelessWidget {
  final TripsViewModel viewModel;

  TripsView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _buildTripsContainer(context));

  }

  Widget _buildTripsContainer(BuildContext context) {
    return ListView.separated(
      itemCount: viewModel.trips.length,
      separatorBuilder: (_, __) {
        return Container(
          height: AaeDimens.smallCardVerticalContentPadding,
        );
      },
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AaeDimens.baseUnit),
          child: Container(
            width: AaeDimens.contentWidth,
            color: AaeColors.white,
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
              ),
              title: Text('${viewModel.trips[index].pnrDescription}'),
              subtitle: Text('${viewModel.trips[index].pnr}'),
              isThreeLine: true,
            ),
          ),
        );
      },
    );
  }
}
