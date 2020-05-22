import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

/// Main navigation bar.

enum MainPage { home, learning, travel, pay, events, notifications }

const _labelTextStyle = TextStyle(
  fontFamily: 'AmericanSans',
  letterSpacing: .25,
  fontWeight: FontWeight.w500,
  fontSize: 10,
);

class BottomNavigation extends StatelessWidget {
  final MainPage _currentPage;
  final ValueChanged<MainPage> _onSelectTab;

  static final selectedColor = AaeColors.blue;
  static final deselectedColor = AaeColors.darkGray;

  static final Map<MainPage, String> tabText = {
    MainPage.home: 'Home',
    MainPage.learning: 'Learning',
    MainPage.travel: 'Travel',
    MainPage.pay: 'Pay',
    MainPage.events: 'Calendar',
    MainPage.notifications: 'Notifications',
  };

  static final Map<MainPage, IconData> tabIconData = {
    MainPage.home: AaeIcons.home,
    MainPage.learning: AaeIcons.learning,
    MainPage.travel: AaeIcons.travel,
//    MainPage.pay: AaeIcons.calendar,
    MainPage.notifications: AaeIcons.notifications,
    MainPage.events: AaeIcons.calendar,
//    MainPage.events: AaeIcons.calendar,
  };

  BottomNavigation(
      {@required MainPage currentPage,
      @required ValueChanged<MainPage> onSelectTab})
      : _currentPage = currentPage,
        _onSelectTab = onSelectTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: AaeColors.ultraLightGray,
          ),
        ),
//        boxShadow: [
//          BoxShadow(
//            color: AaeColors.darkGray,
//            blurRadius: 15.0,
//            spreadRadius: 5.0,
//            offset: Offset(
//              15.0,
//              15.0,
//            ),
//          ),
//        ],
      ),
      child: BottomNavigationBar(
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(MainPage.home, context, 24, 2.0),
          _buildItem(MainPage.notifications, context, 18, 6.0),
          _buildItem(MainPage.travel, context, 18, 5.0),
          _buildItem(MainPage.events, context, 24, 2.0),
//        _buildItem(MainPage.pay, context),

        ],
        onTap: (index) => _onSelectTab(MainPage.values[index]),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(MainPage page, BuildContext context, double size, double offset) {
    final tabColor = _tabColor(page);
    return BottomNavigationBarItem(
        icon: Container(
          height: 20,
          width: 1000,
          padding: EdgeInsets.only(top: offset,),
//          alignment: Alignment.bottomCenter,
          child: Icon(
            tabIconData[page],
            size: size,
            color: tabColor,
            key: Key("TabIcon.$page"),
          ),
        ),
        title: Container(
          height: 24,
          child: Padding(
            padding: const EdgeInsets.only(top:10),
            child: Text(
              tabText[page],
              style: _labelTextStyle.copyWith(color: tabColor),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  Color _tabColor(MainPage page) {
    return _currentPage == page ? selectedColor : deselectedColor;
  }
}
