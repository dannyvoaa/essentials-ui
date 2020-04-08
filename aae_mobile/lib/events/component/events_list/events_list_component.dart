import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'events_list_bloc.dart';
import 'events_list_view.dart';
import 'events_list_view_model.dart';

/// Ties together [EventsListBloc] and [EventsListView].
class EventsListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<EventsListBloc, EventsListBlocFactory>(
      bloc: (factory) => factory.eventsListBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<EventsListViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value == null) {
                return _buildEmptyState(context);
              } else {
                return EventsListView(
                  viewModel: snapshot.value,
                );
              }
            } else {
              return _buildLoadingState(context);
            }
          },
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(child: AaeLoadingSpinner());
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'Empty',
      ),
    );
  }
}
