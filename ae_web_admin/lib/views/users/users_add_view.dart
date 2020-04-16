import 'package:american_essentials_web_admin/models/users_model.dart';
import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:flutter/material.dart';

class UsersAddView extends StatefulWidget {
  static String routeId = 'UsersAddView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  UsersAddView({this.payload});

  @override
  _UsersAddViewState createState() => _UsersAddViewState();
}

class _UsersAddViewState extends State<UsersAddView> {
  // Setup any required variables
  UsersModel _usersModel = UsersModel();

  @override
  void initState() {
    super.initState();

    // Check to see if a payload was supplied
    if (widget.payload != null) {
      // Save the model payload to a local variable
      _usersModel = widget.payload['usersModel'];
    }
  }

  // TODO: This is where you'll start back up again once the project resumes. We need to build out a page to allow an admin to view all of the preferences that a user has selected. While we have a model (in AEWA) and in IBM Cloudant, AA might change this once they take over the database.

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      stringHeaderTitle: 'View User',
      widgetBody: Container(),
    );
  }
}