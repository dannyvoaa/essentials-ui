import 'dart:ui';

import 'package:aae/assets/aae_icons.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/common/widgets/nav/aae_top_nav.dart';
import 'package:flutter/material.dart';

class TravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AaeDrawer(),
      appBar: AaeTopNavBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 80,
                width: 1000,
                child: Icon(
                  AaeIcons.travel,
                  size: 80,
                  color: AaeColors.blue,
                ),
              ),
              Container(
                child: Text(
                  'Travel',
                  style: TextStyle(
                    fontSize: 30,
                    color: AaeColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TravelPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => TravelPage();
  }
}
