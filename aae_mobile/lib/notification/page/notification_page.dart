import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:aae/notification/component/notification_component.dart';

class NotificationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AaeColors.white,
        elevation: 1,
        title: Text(
          'Notifications',
          style: TextStyle(fontSize:16, color: AaeColors.darkGray),
        ),
        centerTitle: true,
        leading: CloseButton(color: AaeColors.darkGray),
      ),
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