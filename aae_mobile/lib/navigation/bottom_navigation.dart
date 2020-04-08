import 'package:aae/assets/aae_icons.dart';
import 'package:flutter/material.dart';

/// Main navigation bar.

enum MainPage { home, learning, travel, pay }

const _labelTextStyle = TextStyle(
  fontFamily: 'AmericanSans',
  letterSpacing: .25,
  fontWeight: FontWeight.w500,
);

class BottomNavigation extends StatelessWidget {
  final MainPage _currentPage;
  final ValueChanged<MainPage> _onSelectTab;

  static final selectedColor = Colors.blue;
  static final deselectedColor = Colors.grey;

  static final Map<MainPage, String> tabText = {
    MainPage.home: 'Home',
    MainPage.learning: 'Learning',
    MainPage.travel: 'Travel',
    MainPage.pay: 'Pay'
  };

  static final Map<MainPage, IconData> tabIconData = {
    MainPage.home: AaeIcons.home,
    MainPage.learning: AaeIcons.learning,
    MainPage.travel: AaeIcons.travel,
    MainPage.pay: AaeIcons.pay
  };

  BottomNavigation(
      {@required MainPage currentPage,
      @required ValueChanged<MainPage> onSelectTab})
      : _currentPage = currentPage,
        _onSelectTab = onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(MainPage.home, context),
        _buildItem(MainPage.learning, context),
        _buildItem(MainPage.travel, context),
        _buildItem(MainPage.pay, context)
      ],
      onTap: (index) => _onSelectTab(MainPage.values[index]),
    );
  }

  BottomNavigationBarItem _buildItem(MainPage page, BuildContext context) {
    final tabColor = _tabColor(page);
    return BottomNavigationBarItem(
        icon: Icon(
          // TODO (rpaglinawan): request a redo of the icons
          tabIconData[page],
          size: 20,
          color: tabColor,
          key: Key("TabIcon.$page"),
        ),
        title: Text(
          tabText[page],
          style: _labelTextStyle.copyWith(color: tabColor),
        ));
  }

  Color _tabColor(MainPage page) {
    return _currentPage == page ? selectedColor : deselectedColor;
  }
}
