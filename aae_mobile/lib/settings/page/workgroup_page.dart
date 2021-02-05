import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/settings/settingslist/workgroup_list_component.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/common/commands/navigate_command.dart';

class WorkgroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   endDrawer: AaeDrawer(),
      appBar: AppBar(
      flexibleSpace: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                            colors: <Color>[

                          AaeColors.blue,
                          AaeColors.lightBlue

                        ])
                     ),
                 ),
       // backgroundColor: AaeColors.blue,
        elevation: 1,
        //   title: Text(
        //     'Topics of interest',
        //     style: TextStyle(fontSize: 16, color: AaeColors.white),
        //   ),
        centerTitle: true,
        leading: new IconButton(icon: new Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.of(context).pop(),),
        //  leading:  CloseButton(color: AaeColors.white),//new IconButton(icon: new Icon(Icons.arrow_back), color: AaeColors.white),
        //CloseButton(color: AaeColors.white),
      ),
      body: WorkgroupListComponent(),
    );
  }
}

class WorkgroupPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => WorkgroupPage();
  }
}
