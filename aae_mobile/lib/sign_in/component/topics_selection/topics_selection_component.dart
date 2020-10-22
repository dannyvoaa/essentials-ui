import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/common/widgets/workflow_page/workflow_page_template.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import 'topics_selection_bloc.dart';
import 'topics_selection_view_model.dart';

/// A [Component] that ties together [TopicsSelectionBloc] and
/// [TopicsSelectionView].
class TopicsSelectionComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<TopicsSelectionBloc, TopicsSelectionBlocFactory>(
      bloc: (factory) => factory.topicsSelectionBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<TopicsSelectionViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              return _TopicsSelectionView(viewModel: snapshot.value);
            } else {
              return _loadingState();
            }
          },
        );
      },
    );
  }

  Widget _loadingState() => Center(child: AaeLoadingSpinner());
}

class _TopicsSelectionView extends StatelessWidget {
  final TopicsSelectionViewModel viewModel;

  _TopicsSelectionView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => WorkflowPageTemplate(
          title: 'Select topics of interest',
          scrollableChild: _topicsList(context, viewModel.topics),
          primaryButtonText: 'FINISH',
          primaryButtonEnabled: viewModel.nextButtonEnabled,
          secondaryButtonText: 'BACK',
        ),
      ),
    );
  }

 Widget _topicsList(
      BuildContext context, BuiltList<TopicsViewModel> viewModels) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return _topicsItem(context, viewModels[i]);
                  },
                  itemCount: viewModels.length);
  }


   Widget _topicsItem(BuildContext context, TopicsViewModel viewModel) {
      return Padding(
       padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: viewModel.onTopicPressed,
          child: Container(
           margin: const EdgeInsets.only(left:40,right:40),
                width: AaeDimens.workgroupsButtonWidth,
                       height: AaeDimens.workgroupsButtonHeight,
            decoration: BoxDecoration(
              color: viewModel.isSelected ? AaeColors.lightBlue : AaeColors.white,
              borderRadius: BorderRadius.circular(AaeDimens.topicsIconRadius),
              shape: BoxShape.rectangle,
              border: viewModel.isSelected
                  ? Border.all(
                      color: AaeColors.white,
                      width: 0)
                  : Border.all(color: AaeColors.black, width: 1),
            ),
            child: Center(
              child: Text(viewModel.topic,
                  style: TextStyle(
                    color:  viewModel.isSelected ? AaeColors.white : AaeColors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  )),
            ),
          ),
        ),
      );
    }


}
