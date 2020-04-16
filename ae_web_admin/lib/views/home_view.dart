import 'package:american_essentials_web_admin/common/strings.dart';
import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static String routeId = 'HomeView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  HomeView({this.payload});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return PageFrame(
      widgetBody: this._body(),
    );
  }

  // MARK: - Views

  Widget _body() {
    return Container(
      child: Text(Strings.lipsumParagraphs),
    );
  }
}
