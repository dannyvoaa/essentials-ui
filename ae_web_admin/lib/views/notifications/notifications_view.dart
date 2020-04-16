import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatefulWidget {
  static String routeId = 'NotificationsView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  NotificationsView({this.payload});

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return PageFrame(
      stringHeaderTitle: 'Notifications',
      widgetBody: Center(
        child: Container(
          child: Text('This view has not yet been implemented.'),
        ),
      ),
    );
  }
}
