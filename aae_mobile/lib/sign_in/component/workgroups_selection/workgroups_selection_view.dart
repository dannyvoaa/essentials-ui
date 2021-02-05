import 'package:aae/common/widgets/workflow_page/workflow_page_template.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import 'workgroups_selection_view_model.dart';

class WorkgroupsSelectionView extends StatelessWidget {
  final WorkgroupsSelectionViewModel viewModel;

  WorkgroupsSelectionView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => WorkflowPageTemplate(
          title: 'Select your workgroup',
          scrollableChild: _workgroupsList(context, viewModel.workgroups),
          primaryButtonText: 'NEXT',
          primaryButtonEnabled: viewModel.nextButtonEnabled,
          secondaryButtonText: 'BACK',
        ),
      ),
    );
  }

  Widget _workgroupsList(
      BuildContext context, BuiltList<WorkgroupsViewModel> viewModels) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return _workgroupsItem(context, viewModels[i]);
        },
        itemCount: viewModels.length);
  }

  Widget _workgroupsItem(BuildContext context, WorkgroupsViewModel viewModel) {
    return Padding(
    padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: viewModel.onWorkgroupPressed,
        child: Container(
        margin: const EdgeInsets.only(left:40,right:40),
          width: AaeDimens.workgroupsButtonWidth,
          height: AaeDimens.workgroupsButtonHeight,
          decoration: BoxDecoration(
            color: viewModel.isSelected ? AaeColors.lightBlue : AaeColors.white100,
            borderRadius: BorderRadius.circular(AaeDimens.topicsIconRadius),
            shape: BoxShape.rectangle,
            border: viewModel.isSelected
                              ? Border.all(
                                  color: AaeColors.white100,
                                  width: 0)
                              : Border.all(color: AaeColors.black, width: 1),
          ),
          child: Center(
            child: Text(viewModel.workgroup,
                style: TextStyle(
                  color:  viewModel.isSelected ? AaeColors.white100 : AaeColors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                )),
          ),
        ),
      ),
    );
  }
}
