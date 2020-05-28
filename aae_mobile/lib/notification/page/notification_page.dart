import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:aae/notification/component/notification_component.dart';
import 'package:aae/common/widgets/nav/aae_top_nav.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';

class NotificationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AaeDrawer(),
      appBar: AaeTopNavBar(),
//      appBar: AppBar(
//        backgroundColor: AaeColors.white,
//        elevation: 1,
//        title: Text(
//          'Notifications',
//          style: TextStyle(fontSize:16, color: AaeColors.darkGray),
//        ),
//        centerTitle: true,
//        leading: CloseButton(color: AaeColors.darkGray),
//      ),
      body: NotificationPageComponent(),
    );
  }
}

class NotificationPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => NotificationPage();
  }
}