import 'package:aae/home/news_feed_page.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

/// A app bar for the news feed page.
class TravelTopBar extends StatefulWidget implements PreferredSizeWidget {
  TravelTopBar(
      {this.tabs,
      this.tabController,
      this.tripsNestedNavKey,
      this.priorityListNestedNavKey,
      this.flightStatusNestedNavKey,
      Key key})
      : super(key: key);
  final TabController tabController;
  final List<BuildContext> navStack = [null, null, null];
  final List<Tab> tabs;

  List<GlobalKey<NavigatorState>> travelNavKeys = [null, null, null];

  final GlobalKey<NavigatorState> tripsNestedNavKey;
  final GlobalKey<NavigatorState> priorityListNestedNavKey;
  final GlobalKey<NavigatorState> flightStatusNestedNavKey;

  @override
  TravelTopBarState createState() => TravelTopBarState();

  @override
  final preferredSize = Size.fromHeight(105);
}

class TravelTopBarState extends State<TravelTopBar> {
  @override
  void initState() {
    widget.travelNavKeys[0] = widget.tripsNestedNavKey;
    widget.travelNavKeys[1] = widget.priorityListNestedNavKey;
    widget.travelNavKeys[2] = widget.flightStatusNestedNavKey;

    widget.tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GradientAppBar(
        leading: _canPopTravelPage() ? _buildBackButton() : null,
        title: !_canPopTravelPage()
            ? Text(
                'Travel',
              )
            : null,
        gradient: AaeColors.appBarGradient,
        bottom: PreferredSize(
          preferredSize: widget.preferredSize,
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: widget.tabController,
              tabs: widget.tabs,
              isScrollable: true,
              indicatorColor: AaeColors.orange,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
      ),
    );
  }

  _buildBackButton() {
//    return InkWell(
//      child: Container(
//          padding: EdgeInsets.only(left: 15),
//          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//          child: Align(
//            alignment: Alignment.centerLeft,
//            child: Icon(
//              Icons.arrow_back_ios,
//              color: AaeColors.white100,
//            ),
//          ),
//        ),
//    );
    return new IconButton(
        icon: new Container(
//          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.arrow_back_ios,
            color: AaeColors.white100,
          ),
        ),
        onPressed: () => {
              Navigator.of(widget.navStack[widget.tabController.index])
                  .maybePop()
                  .then((value) => refreshTopBar(null)),
            });
  }

  void refreshTopBar(context) {
    if (context != null) {
      widget.navStack[widget.tabController.index] = context;
    }
    setState(() {});
  }

  _canPopTravelPage() {
    if (widget.travelNavKeys[widget.tabController.index] != null &&
        widget.travelNavKeys[widget.tabController.index].currentState != null) {
      return widget.travelNavKeys[widget.tabController.index].currentState
          .canPop();
    } else
      return false;
  }
}
