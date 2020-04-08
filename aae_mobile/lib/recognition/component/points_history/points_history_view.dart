import 'package:aae/recognition/component/points_history/points_history_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

class PointsHistoryView extends StatelessWidget {
  final PointsHistoryViewModel viewModel;

  PointsHistoryView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _buildPointsHistoryList(context));
  }

  //TODO: (kiheke) - Make match spec

  Widget _buildPointsHistoryList(BuildContext context) {
    return ListView.separated(
      itemCount: viewModel.recognitionHistory.length,
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
                decoration: BoxDecoration(
                    color: Color(0xFF00B989), shape: BoxShape.circle),
              ),
              title: Text('${viewModel.recognitionHistory[index].name}'),
              subtitle: Text('${viewModel.recognitionHistory[index].message}'),
              isThreeLine: true,
              trailing: Text('+ ${viewModel.recognitionHistory[index].amount}'),
            ),
          ),
        );
      },
    );
  }
}
