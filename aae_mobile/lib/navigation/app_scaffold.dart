/// Scaffold widget for the app.

import 'package:flutter/material.dart';

import 'bottom_navigation.dart';
import 'main_page_navigator.dart';

class AppScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppScaffoldState();
}

class AppScaffoldState extends State<AppScaffold> {
  MainPage _currentPage = MainPage.home;

  // Shared with the root navigator in main.dart for top-level Profile
  // navigation.
  static WillPopCallback willPopCallback(
      {@required GlobalKey<NavigatorState> key}) {
    return () async => !await key.currentState.maybePop();
  }

  final Map<MainPage, GlobalKey<NavigatorState>> _navigatorKeys = {
    MainPage.home: GlobalKey<NavigatorState>(),
    MainPage.events: GlobalKey<NavigatorState>(),
    MainPage.travel: GlobalKey<NavigatorState>(),
    MainPage.notifications: GlobalKey<NavigatorState>(),
  };

  void _selectTab(MainPage newPage) {
    setState(() {
      // If the user taps the tab they are already on, navigate to the root
      // page of that tab:
      if (_currentPage == newPage) {
        _navigatorKeys[_currentPage]
            .currentState
            .popUntil((route) => route.isFirst);
      }
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback(key: _navigatorKeys[_currentPage]),
      child: Scaffold(
          body: Stack(children: <Widget>[
            _buildOffstageNavigator(MainPage.home),
            _buildOffstageNavigator(MainPage.events),
            _buildOffstageNavigator(MainPage.travel),
            _buildOffstageNavigator(MainPage.notifications),
          ]),
          bottomNavigationBar: BottomNavigation(
            currentPage: _currentPage,
            onSelectTab: _selectTab,
          )),
    );
  }

  Widget _buildOffstageNavigator(MainPage page) {
    return Offstage(
        key: Key("Offstage.$page"),
        offstage: _currentPage != page,
        child: MainPageNavigator(
          navigatorKey: _navigatorKeys[page],
          page: page,
        ));
  }
}
