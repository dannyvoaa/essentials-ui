import 'package:aae/navigation/page_provider.dart';
import 'package:aae/recognition/component/points_balance/points_balance_component.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

class RecognitionPage extends StatelessWidget {
  final List<Tab> tabs = <Tab>[
    Tab(
      child: Text(
        'Points Balance',
        style: TextStyle(color: AaeColors.gray),
      ),
    ),
    Tab(
        child: Text(
      'Send',
      style: TextStyle(color: AaeColors.gray),
    )),
    Tab(
      child: Text(
        'Redeem',
        style: TextStyle(color: AaeColors.gray),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.grey),
          backgroundColor: AaeColors.white,
          elevation: AaeDimens.noElevation,
          actions: <Widget>[],
          bottom: TabBar(tabs: tabs),
        ),
        body: TabBarView(
          children: <Widget>[
            PointsBalanceComponent(),
            PointsBalanceComponent(),
            PointsBalanceComponent(),
          ],
        ),
      ),
    );
  }
}

class RecognitionPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => RecognitionPage();
  }
}
