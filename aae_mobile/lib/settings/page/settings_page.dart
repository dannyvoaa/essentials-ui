import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/settings/settingslist/settings_list_component.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AaeColors.white,
        elevation: 1,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 16, color: AaeColors.darkGray),
        ),
        centerTitle: true,
        leading: CloseButton(color: AaeColors.darkGray),
      ),
      body: SettingsListComponent(),
    );
  }
}

class SettingsPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => SettingsPage();
  }
}
