import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/navigation/navigation_helper.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/profile/profile_details.dart';
import 'package:aae/service_provider.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aae/sign_in/component/login/login_view.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:aae/assets/aae_icons.dart';

class AaeDrawer extends StatelessWidget {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  _logoutfromSM() {
    String logouturl = logoutEndpoint + "?originalTarget=" + redirectUri;
    flutterWebviewPlugin.launch(logouturl, hidden: true);
    /*
    Map<String, dynamic> bodyparams = Map<String, dynamic>();
    bodyparams['originalTarget'] = redirectUri;
    NetUtils.get(logoutEndpoint, bodyparams).then((data) {
      print('$data');
    });
     */
  }
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets = EdgeInsets.only(
      left: AaeDimens.safeArea(buildContext: context).left > 0
          ? AaeDimens.safeArea(buildContext: context).left
          : AaeDimens.pageMarginLarge.left,
      top: AaeDimens.safeArea(buildContext: context).top > 0
          ? AaeDimens.safeArea(buildContext: context).top
          : 0,
      right: AaeDimens.safeArea(buildContext: context).right > 0
          ? AaeDimens.safeArea(buildContext: context).right
          : AaeDimens.pageMarginLarge.right,
      bottom: AaeDimens.safeArea(buildContext: context).bottom > 0
          ? AaeDimens.safeArea(buildContext: context).bottom
          : AaeDimens.drawerHeight,
    );
    ProfileDetails profiledetails = ProfileDetails.getInstance();
    String username = profiledetails.userfullname;
    String location = profiledetails.userlocation;

    return Scaffold(
      //   endDrawer: AaeDrawer(),


      appBar: AppBar(

        backgroundColor: AaeColors.blue,
        elevation: 1,
        //   title: Text(
        //     'Topics of interest',
        //     style: TextStyle(fontSize: 16, color: AaeColors.white),
        //   ),
        centerTitle: true,
        //leading: new IconButton(icon: new Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.of(context).pop(),),
        leading: new Container(),
        actions: <Widget>[CloseButton(color: AaeColors.white), ],
        //new IconButton(icon: new Icon(Icons.arrow_back), color: AaeColors.white),
        // CloseButton(color: AaeColors.white),
      ),
      body:   Center(
        //  height : MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,

        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[

              Container(
                decoration: const BoxDecoration(border: Border(bottom: BorderSide( color: AaeColors.ultraLightGray),),),
                alignment: Alignment.centerLeft,
                child:  Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only (bottom:12.0),
                      child:  Text(username,maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, color: AaeColors.lightGray),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only (bottom:16.0),
                      child:  Text( location, maxLines: 1, style: TextStyle( color: AaeColors.lightGray), ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top:16),
                alignment: Alignment.centerLeft,
                child: FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(  AaeIconsv4.setting,color: AaeColors.lightGray,size: 20),
                  label: Text('Preferences', style: TextStyle(color: AaeColors.lightGray, fontSize:16,height:1.5) ),
                  onPressed: () {
                    navigateCommand(routes.buildSettingsPageRoute())(context);
                  },
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                child: FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(  AaeIconsv4.info, color: AaeColors.lightGray,size: 20 ),
                  label: Text('About      ', style: TextStyle(color: AaeColors.lightGray, fontSize:16,height:1.5) ),
                    onPressed: (){},
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                child: FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(  AaeIconsv4.lock, color: AaeColors.lightGray,size: 20),
                  label: Text('Logout     ', style: TextStyle(color: AaeColors.lightGray, fontSize:16,height:1.5) ),
                  onPressed: ()
                  async {
                    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
                    _sharedPref.clear();
                    _logoutfromSM();
                    ServiceProvider.serviceOf<AaeNavigator>(context).pushNamed(context, routes.buildSignInRoute(), fromRoot: true);
                  },
                ),
              ),
            ],
          ),
          margin: edgeInsets,
        ),

      ),
    );
  }
}