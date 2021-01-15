import 'package:aae/assets/aae_icons.dart';
import 'package:aae/events/page/events_page.dart';
import 'package:aae/home/news_feed_page.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

/// Main navigation bar.

enum MainPage { home,  events, travel, notifications }

const _labelTextStyle = TextStyle(
  fontFamily: 'AmericanSans',
  letterSpacing: .25,
  fontWeight: FontWeight.w500,
  fontSize: 14,
  textBaseline: TextBaseline.alphabetic,
);

class BottomNavigation extends StatelessWidget {
  final MainPage _currentPage;
  final ValueChanged<MainPage> _onSelectTab;

  static final selectedColor = AaeColors.blue;
  static final deselectedColor = AaeColors.darkGray;

  //if working on travel feature uncomment lines 30, 37, 69.  Please do not stage these changes when merging into develop.
  static final Map<MainPage, String> tabText = {
    MainPage.home: 'Home',
    MainPage.events: 'Calendar',
    MainPage.travel: 'Trips',
//    MainPage.notifications: 'Notifications',
  };

  static final Map<MainPage, IconData> tabIconData = {
    MainPage.home: AaeIcons.home,
    MainPage.events: AaeIcons.calendar,
    MainPage.travel: AaeIcons.travel,
//    MainPage.notifications: AaeIcons.notifications,
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
        selectedFontSize: 14,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(MainPage.home, context, 24, 2.0),
          _buildItem(MainPage.events, context, 24, 2.0),
          _buildItem(MainPage.travel, context, 18, 5.0),
//          _buildItem(MainPage.notifications, context, 18, 6.0),
        ],
          onTap: (index) {
          SSKeys mysskeys = new SSKeys();
          try {
            if (mysskeys.scaffoldKeyH.currentState != null) {
              if (mysskeys.scaffoldKeyH.currentState.hasEndDrawer) {
                if (mysskeys.scaffoldKeyH.currentState.isEndDrawerOpen) {
                  mysskeys.scaffoldKeyH.currentState.openDrawer();
                }
              }
            }
            if (mysskeys.scaffoldKeyE.currentState != null) {
              if (mysskeys.scaffoldKeyE.currentState.hasEndDrawer) {
                if (mysskeys.scaffoldKeyE.currentState.isEndDrawerOpen) {
                  mysskeys.scaffoldKeyE.currentState.openDrawer();
                }
              }
            }
          } catch (e) {
            print(e.toString());
          }
            return _onSelectTab(MainPage.values[index]);
          }
      ),
    );
  }

  BottomNavigationBarItem _buildItem(MainPage page, BuildContext context, double size, double offset) {
    final tabColor = _tabColor(page);
    return BottomNavigationBarItem(
        icon: Container(
          padding: EdgeInsets.only(top: offset,),
          height:20,
          width: 50,
          child: Icon(
            tabIconData[page],
            size: size,
            color: tabColor,
            key: Key("TabIcon.$page"),
          ),
        ),
      title: Container(
        height: 24,
        padding: EdgeInsets.only(top:10.0),
        child: Container(
          child: Text(
            tabText[page],
            style: _labelTextStyle.copyWith(color: tabColor),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Color _tabColor(MainPage page) {
    return _currentPage == page ? selectedColor : deselectedColor;
  }
}
