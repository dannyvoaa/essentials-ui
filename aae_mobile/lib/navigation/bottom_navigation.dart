import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

/// Main navigation bar.

enum MainPage { home, travel, events, notifications }

const _labelTextStyle = TextStyle(
  fontFamily: 'AmericanSans',
  letterSpacing: .25,
  fontWeight: FontWeight.w500,
  fontSize: 10,
);

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class BottomNavigation extends StatelessWidget {
  final MainPage _currentPage;
  final ValueChanged<MainPage> _onSelectTab;

  static final selectedColor = AaeColors.blue;
  static final deselectedColor = AaeColors.darkGray;

  static final Map<MainPage, String> tabText = {
    MainPage.home: 'Home',
  //  MainPage.notifications: 'Notifications',
    MainPage.travel: 'Trips',
    MainPage.events: 'Calendar',
  };

  static final Map<MainPage, IconData> tabIconData = {
    MainPage.home: AaeIcons.home,
  //  MainPage.notifications: AaeIcons.notifications,
    MainPage.travel: AaeIcons.travel,
    MainPage.events: AaeIcons.calendar,
  };

//  void _closeDrawer() {
//  _scaffoldKey.currentState.openDrawer();
//  }

  BottomNavigation(
      {@required MainPage currentPage,
      @required ValueChanged<MainPage> onSelectTab})
      : _currentPage = currentPage,
        _onSelectTab = onSelectTab;

  @override
  Widget build(BuildContext context) {
    Scaffold(key: _scaffoldKey,);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: AaeColors.ultraLightGray,
          ),
        ),
      ),
      child: BottomNavigationBar(
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(MainPage.home, context, 24, 2.0),
       //   _buildItem(MainPage.notifications, context, 18, 6.0),
          _buildItem(MainPage.travel, context, 18, 5.0),
          _buildItem(MainPage.events, context, 24, 2.0),
        ],
//        onTap: _scaffoldKey.currentState.openDrawer,
//        onTap: (index) => [_onSelectTab(MainPage.values[index]), Navigator.of(context).pop()],
        onTap: (index) => _onSelectTab(MainPage.values[index]),
//          onTap: _scaffoldKey.currentState.isDrawerOpen ? (index) => _onSelectTab(MainPage.values[index]) : (){},
//        onTap: menuTap(index, context),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(MainPage page, BuildContext context, double size, double offset) {
    final tabColor = _tabColor(page);
    return BottomNavigationBarItem(
        icon: Container(
          height: 20,
//          width: 1000,
          padding: EdgeInsets.only(top: offset,),
//          alignment: Alignment.bottomCenter,
          child: Container(
            height:80,
//            width:1000,
            child: Icon(
              tabIconData[page],
              size: size,
              color: tabColor,
              key: Key("TabIcon.$page"),
            ),
          ),
        ),
        title: Container(
          height: 24,
          child: Padding(
            padding: const EdgeInsets.only(top:10),
            child: Text(
              tabText[page],
//              'Test Text Test Text',
              style: _labelTextStyle.copyWith(color: tabColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
    );
  }

  Color _tabColor(MainPage page) {
    return _currentPage == page ? selectedColor : deselectedColor;
  }
}
