import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

import 'top_bar_title_bloc.dart';
import 'top_bar_title_view_model.dart';
import 'package:recase/recase.dart';

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
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'morning';
      }
      if (hour < 17) {
        return 'afternoon';
      }
      return 'evening';
    }
    String toTitleCase(String str) {
      return str
          .replaceAllMapped(
          RegExp(
              r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
              (Match m) =>
          "${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}")
          .replaceAll(RegExp(r'(_|-)+'), ' ');
    }
    return Text(
      "Good ${greeting()}, ${(viewModel.displayName).titleCase}",
      textAlign: TextAlign.left,
      style: AaeTextStyles.body16WhiteMed125,
    );
  }
}
