import 'package:aae/common/widgets/workflow_page/workflow_page_template.dart';
import 'package:flutter/material.dart';

class ModifySettingsView extends StatelessWidget {
  final Widget body;

  Widget builtWidget() {}

  ///[ModifySettingsView.single] creates a preference changing view that the user can
  ///pass custom single component widgets
  ModifySettingsView.single({this.body});

  ///[ModifySettingsView.multi] creates a scrollable view of widgets for
  ///changing preferences
  ModifySettingsView.multi({this.body});

  ModifySettingsView({this.body});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(child: body),
      );
}
