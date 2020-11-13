import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/tables/table_cell_title_value_hub.dart';
import 'package:aae/common/widgets/tables/table_components.dart';
import 'package:aae/common/widgets/tables/table_header.dart';
import 'package:flutter/material.dart';
import 'package:aae/profile/profile_details.dart';
import 'settings_list_bloc.dart';
import 'settings_list_view_model.dart';

/// A [Component] that ties together [SettingsListBloc] and
/// [SettingsListView].
class HubLocationListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<SettingsListBloc, SettingsListBlocFactory>(
      bloc: (factory) => factory.settingsListBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<SettingsListViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              return _SettingsListView(viewModel: snapshot.value);
            } else {
              return _loadingState();
            }
          },
        );
      },
    );
  }

  Widget _loadingState() => Column();
}

/// A View that shows a list on the settings page.
///
class _SettingsListView extends StatelessWidget {
  final SettingsListViewModel viewModel;

  _SettingsListView({this.viewModel});

  @override
  Widget build(BuildContext context) {
    ProfileDetails profiledetails = ProfileDetails.getInstance();
    String username = profiledetails.userfullname;
    String location = profiledetails.userlocation;

    if (location == null) {
      location = "";
    }
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              TableHeader(
                stringTitle: 'Select hub',
              ),
              _buildHubLocations(context, location),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
      ),
    );
  }


  Widget _buildHubLocations(BuildContext context, String location) {

       return Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           for (var i = 0; i < viewModel.hubLocation.length; i++)
             TableCellTitleValueHub(
                 onTapAction: () {
                   //print(viewModel.hubLocation[i]);
                   if (viewModel.hubLocation[i] != location)
                      viewModel.onHubLocationTapped(viewModel.hubLocation[i]);
                 },
                 boolShowCheckmark:viewModel.selectedHubLocations.contains(viewModel.hubLocation[i]),
                 boolBorderTop: true,
                 boolEnabled: true,
                 boolShowDisclosureIndicator: viewModel.hubLocation[i] != location ? true : false,
                 stringTitle: viewModel.hubLocation[i] != location ? viewModel.hubLocation[i] : '$location (Your location)',
                 boolHubTextGray: viewModel.hubLocation[i] != location ? false : true,
                 stringValue: '')
         ],
       );
     }


}