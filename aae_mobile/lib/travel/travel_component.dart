//import 'package:aae/bloc/source_builder.dart';
//import 'package:aae/common/widgets/component/component.dart';
//import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
//import 'package:flutter/material.dart';
//
//import 'travel_bloc.dart';
//import 'travel_view.dart';
//import 'travel_view_model.dart';
//
///// Ties together [TravelBloc] and [TravelView].
//class TravelComponent extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Component<TravelBloc, TravelBlocFactory>(
//      bloc: (factory) => factory.travelBloc(),
//      builder: (context, bloc) {
//        return SourceBuilder.of<TravelViewModel>(
//          source: bloc.viewModel,
//          builder: (snapshot) {
//            if (snapshot.present) {
//              if (snapshot.value == null) {
//                return _buildEmptyState(context);
//              } else {
//                return TravelView(viewModel: snapshot.value);
//              }
//            } else {
//              return _buildLoadingState(context);
//            }
//          },
//        );
//      },
//    );
//  }
//
//  Widget _buildLoadingState(BuildContext context) {
//    return Center(child: AaeLoadingSpinner());
//  }
//
//  Widget _buildEmptyState(BuildContext context) {
//    return Center(
//      child: Text(
//        'Empty',
//      ),
//    );
//  }
//}
