import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

import 'top_bar_title_bloc.dart';
import 'top_bar_title_view_model.dart';

/// Component that ties together [TopBarTitleBloc] and [TopBarTitleView].
class TopBarTitleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<TopBarTitleBloc, TopBarTitleBlocFactory>(
      bloc: (factory) => factory.topBarTitleBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<TopBarTitleViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              return _TopBarTitleView(viewModel: snapshot.value);
            } else {
              return _buildEmptyState(context);
            }
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        '',
      ),
    );
  }
}

/// Top Bar Title that shows the current user's name.
/// Shown in the news feed top bar
class _TopBarTitleView extends StatelessWidget {
  final TopBarTitleViewModel viewModel;

  _TopBarTitleView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // TODO: (kiheke) - Move this to BLoC
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Morning';
      }
      if (hour < 17) {
        return 'Afternoon';
      }
      return 'Evening';
    }

    return Text(
      "Good ${greeting()}, ${viewModel.displayName}",
      textAlign: TextAlign.left,
      style: AaeTextStyles.h6,
    );
  }
}
