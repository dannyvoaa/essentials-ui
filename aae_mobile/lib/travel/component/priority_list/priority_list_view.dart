import 'package:aae/travel/component/priority_list/results/priority_list_results.dart';
import 'package:flutter/material.dart';
import 'priority_list_view_model.dart';

class PriorityListView extends StatelessWidget {
  final PriorityListViewModel viewModel;

  PriorityListView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PriorityListResults(this.viewModel),
    );
  }
}
