import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/common/widgets/workflow_page/workflow_page_template.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/profile/profile_details.dart';
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
      body: Builder(
        builder: (context) => WorkflowPageTemplate(
          title: 'Select hub locations',
          scrollableChild: _hubLocationsList(context, viewModel.hubLocations),
          primaryButtonText: 'NEXT',
          primaryButtonEnabled: viewModel.nextButtonEnabled,
       //   secondaryButtonText: 'BACK',
        ),
      ),
    );
  }


Widget _hubLocationsList(
      BuildContext context, BuiltList<HubLocationsViewModel> viewModels) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return _hubLocationsItem(context, viewModels[i]);
                  },
                  itemCount: viewModels.length);
  }

  Widget _hubLocationsItem(BuildContext context, HubLocationsViewModel viewModel) {
    ProfileDetails profiledetails = ProfileDetails.getInstance();
    String location = profiledetails.userlocation;
    if (location == null) {
      location = "";
    }

    if (viewModel.hubLocation == location) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 40, right: 40),
            width: AaeDimens.workgroupsButtonWidth,
            height: AaeDimens.workgroupsButtonHeight,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(AaeDimens.topicsIconRadius),
                shape: BoxShape.rectangle,
                border:
                Border.all(
                    color: AaeColors.white,
                    width: 0)
              //: Border.all(color: AaeColors.black, width: 1),
            ),
            child: Center(
              child: Text(viewModel.hubLocation,
                  style: TextStyle(
                    color: AaeColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  )),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: viewModel.onHubLocationPressed,
          child: Container(
            margin: const EdgeInsets.only(left: 40, right: 40),
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
              child: Text(viewModel.hubLocation,
                  style: TextStyle(
                    color: viewModel.isSelected ? AaeColors.white : AaeColors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  )),
            ),
          ),
        ),
      );
    }
  }


}
