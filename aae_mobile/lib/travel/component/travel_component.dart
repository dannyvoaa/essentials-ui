/// This is generated boilerplate code for [travelTravel] you can modify the following file
/// This class will be the entry point of your new component if you want to create a workflow follow with [SignInWorkflow]
/// If this is only just a page make sure that this new component is registered in [main_page_navigator.dart] within the switch-case starting on line 87 and the route to the page is registered in [routes.dart]

import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:flutter/material.dart';

import '../component/travel_bloc.dart';
import '../travel_view_model.dart';

class TravelTravelComponent extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Component<TravelTravelBloc, TravelTravelBlocFactory>(
            bloc: (factory) => factory.travelTravelBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<TravelTravelViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            return Container(child: Center(child: Text('Implement TravelTravelView')),);
          },
        );
      },
        );
    }
}
