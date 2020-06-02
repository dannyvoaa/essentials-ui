import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/settings/settingslist/settings_list_component.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AaeColors.blue,
        elevation: 1,
//        title: Text(
//          'Settings',
//          style: TextStyle(fontSize: 16, color: AaeColors.white),
//        ),
        centerTitle: true,
        leading:  CloseButton(color: AaeColors.white),//new IconButton(icon: new Icon(Icons.arrow_back), color: AaeColors.white),
    //CloseButton(color: AaeColors.white),
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
