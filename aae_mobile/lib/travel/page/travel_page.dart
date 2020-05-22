import 'dart:ui';

import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/theme/colors.dart';

import 'package:flutter/material.dart';

class TravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: SafeArea(),
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
