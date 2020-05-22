/// This is generated boilerplate code for [d0Stats] you can modify the following file
/// This class will be the entry point of your new component if you want to create a workflow follow with [SignInWorkflow]
/// If this is only just a page make sure that this new component is registered in [main_page_navigator.dart] within the switch-case starting on line 87 and the route to the page is registered in [routes.dart]

import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/d0_stats_bar/bloc/d0_stats_bar_bloc.dart';
import 'package:aae/d0_stats_bar/page/d0_stats_tick.dart';
import 'package:flutter/material.dart';

import '../d0_stats_bar_view_model.dart';

class D0StatsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<D0StatsBloc, D0StatsBlocFactory>(
      bloc: (factory) => factory.d0StatsBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<D0StatsViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              return Container(
                color: Color(0xFFD0DAE0),
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: D0StatsTick('AAL: ', snapshot.value.stockStats.price, snapshot.value.stockStats.aalChange),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: D0StatsTickPercent('D0: ', snapshot.value.performanceStats.d0, snapshot.value.performanceStats.d0Change),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: D0StatsTickPercent('A14: ', snapshot.value.performanceStats.a14, snapshot.value.performanceStats.a14Change),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right:20.0),
                          child: D0StatsTickPercent('CF: ', snapshot.value.performanceStats.cf, snapshot.value.performanceStats.cfChange),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                color: Color(0xFFD0DAE0),
                height: 32,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: D0StatsTick('AAL: ', '-.-', "Black"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: D0StatsTick('D0: ', '-.-', "Black"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: D0StatsTick('A14: ', '-.-',  "Black"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: D0StatsTick('CF: ', '-.-',  "Black"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      child: AaeLoadingSpinner(),
    );
  }
}
