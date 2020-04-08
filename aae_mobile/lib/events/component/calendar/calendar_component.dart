//import 'package:aae/bloc/source_builder.dart';
//import 'package:aae/common/widgets/component/component.dart';
//import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
//import 'package:flutter/material.dart';
//
///// Ties together [CalendarBloc] and [CalendarView].
//class CalendarComponent extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Component<CalendarBloc, CalendarBlocFactory>(
//      bloc: (factory) => factory.calendarBloc(),
//      builder: (context, bloc) {
//        return SourceBuilder.of<CalendarViewModel>(
//          source: bloc.viewModel,
//          builder: (snapshot) {
//            if (snapshot.present) {
//              if (snapshot.value == null) {
//                return _buildEmptyState(context);
//              } else {
//                return CalendarView(
//                  viewModel: snapshot.value,
//                );
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
