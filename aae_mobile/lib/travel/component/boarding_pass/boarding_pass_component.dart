import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_bloc.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_view.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_view_model.dart';
import 'package:flutter/material.dart';

class BoardingPassArguments {
  final String pnr;
  final bool forceRefresh;

  BoardingPassArguments({
    @required this.pnr,
    @required this.forceRefresh,
  });
}

/// Ties together [BoardingPassBloc] and [BoardingPassView].
class BoardingPassComponent extends StatelessWidget {
//  final String pnr;
//
//  BoardingPassComponent({
//    @required this.pnr,
//  });

//  BoardingPassComponent.from(BoardingPassArguments args):
//        this.pnr = args.pnr;

  @override
  Widget build(BuildContext context) {
    return Component<BoardingPassBloc, BoardingPassBlocFactory>(
      bloc: (factory) => factory.boardingPassBloc(),
      builder: (context, bloc) {
//        bloc.loadBoardingPasses(pnr: this.pnr, forceRefresh: false);
        return SourceBuilder.of<BoardingPassViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present && snapshot.value != null && snapshot.value.boardingPasses != null) {
              return BoardingPassView(viewModel: snapshot.value);
            } else {
              return Center(child: AaeLoadingSpinner());
            }
          },
        );
      },
    );
  }
}
