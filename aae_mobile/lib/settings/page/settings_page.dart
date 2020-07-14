import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/settings/settingslist/settings_list_component.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/common/commands/navigate_command.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   endDrawer: AaeDrawer(),
      appBar: AppBar(
        backgroundColor: AaeColors.blue,
        elevation: 1,
//        title: Text(
//          'Settings',
//          style: TextStyle(fontSize: 16, color: AaeColors.white),
//        ),
        leading: new IconButton(icon: new Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.of(context).pop(),),
        //  centerTitle: true,
        //  leading:  CloseButton(color: AaeColors.white),


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