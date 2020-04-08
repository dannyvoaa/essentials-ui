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
      body: WorkflowPageTemplate(
        title: 'Personalize your content',
        body: 'Select topics that matter to you',
        scrollableChild: _topicsList(context, viewModel.topics),
        primaryButtonText: 'Next',
        primaryButtonEnabled: true,
      ),
    );
  }

  Widget _topicsList(
      BuildContext context, BuiltList<TopicsViewModel> viewModels) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: AaeDimens.topicsIconSize,
          mainAxisSpacing: AaeDimens.topicsIconSpacing,
          crossAxisSpacing: AaeDimens.topicsIconSpacing,
        ),
        itemBuilder: (context, i) {
          return _topicsItem(context, viewModels[i]);
        },
        itemCount: viewModels.length);
  }

  Widget _topicsItem(BuildContext context, TopicsViewModel viewModel) {
    return Container(
      width: AaeDimens.topicsIconSize,
      height: AaeDimens.topicsIconSize,
      decoration: BoxDecoration(
        color: AaeColors.lightBlue,
        borderRadius: BorderRadius.circular(AaeDimens.topicsIconRadius),
        shape: BoxShape.rectangle,
        border: viewModel.borderColor.isPresent
            ? Border.all(
                color: viewModel.borderColor.value,
                width: AaeDimens.topicsIconSelectionBorderSize)
            : null,
      ),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(viewModel.topic,
              style: TextStyle(
                color: AaeColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              )),
        ),
        onTap: viewModel.onTopicPressed,
      ),
    );
  }
}
