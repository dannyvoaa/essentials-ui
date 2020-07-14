import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/common/widgets/workflow_page/workflow_page_template.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import 'hub_locations_selection_bloc.dart';
import 'hub_locations_selection_view_model.dart';

/// Allows the user to select the applicable hubLocation.
/// A [Component] that ties together [HubLocationsSelectionBloc] and [HubLocationsSelectionView].
class HubLocationsSelectionComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<HubLocationsSelectionBloc, HubLocationsSelectionBlocFactory>(
      bloc: (factory) => factory.hubLocationsSelectionBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<HubLocationsSelectionViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              return _HubLocationsSelectionView(viewModel: snapshot.value);
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

class _HubLocationsSelectionView extends StatelessWidget {
  final HubLocationsSelectionViewModel viewModel;

  _HubLocationsSelectionView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WorkflowPageTemplate(
        title: 'Personalize your content',
        body: 'Select hubs that matter to you',
        scrollableChild: _hubLocationsList(context, viewModel.hubLocations),
        primaryButtonText: 'Next',
        primaryButtonEnabled: true,
      ),
    );
  }

  Widget _hubLocationsList(
      BuildContext context, BuiltList<HubLocationsViewModel> viewModels) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: AaeDimens.topicsIconSize,
          mainAxisSpacing: AaeDimens.topicsIconSpacing,
          crossAxisSpacing: AaeDimens.topicsIconSpacing,
        ),
        itemBuilder: (context, i) {
          return _hubLocationsItem(context, viewModels[i]);
        },
        itemCount: viewModels.length);
  }

  Widget _hubLocationsItem(BuildContext context, HubLocationsViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.onHubLocationPressed,
      child: Container(
        width: AaeDimens.topicsIconSize,
        height: AaeDimens.topicsIconSize,
        decoration: BoxDecoration(
          color: viewModel.isSelected ? AaeColors.blue : AaeColors.lightBlue,
          borderRadius: BorderRadius.circular(AaeDimens.topicsIconRadius),
          shape: BoxShape.rectangle,
        ),
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Icon(
                  viewModel.isSelected ? Icons.check : null,
                  color: AaeColors.white,
                  size: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(viewModel.hubLocation,
                    style: TextStyle(
                      color: AaeColors.white,
                      fontSize: 16,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
