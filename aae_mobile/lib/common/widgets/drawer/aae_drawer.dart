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
import 'package:recase/recase.dart';
import 'package:aae/common/widgets/tables/table_components.dart';

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
                      child:  Text(username.titleCase,maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, color: AaeColors.lightGray),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only (bottom:16.0),
                      child:  Text( location.toUpperCase(), maxLines: 1, style: TextStyle( color: AaeColors.lightGray), ),
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
                                                              onPressed: () {
                                                                                        Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(builder: (context) => SecondRoute()),
                                                                                        );
                                                                                      },
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


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: AaeColors.blue,
              elevation: 1,
        leading: new IconButton(icon: new Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.of(context).pop(),),
      ),
      body: Container(
            margin: EdgeInsets.all(20),
        child: ListView(
                       children: [
                         Column(
                           children: <Widget>[
                             TableCellTitleValue(
                               boolBorderTop: false,
                               boolEnabled: true,
                               boolShowDisclosureIndicator: true,
                               stringTitle: 'Privacy policy',
                             //  stringValue: 'test',
                                txt: 'Read more',
                                onTapAction: () {
                                                                                                         Navigator.push(
                                                                                                                      context,
                                                                                                                         MaterialPageRoute(builder: (context) => PolicyRoute()),
                                                                                                                                         );
                                                                                                                                   },
                             ),
                             TableCellTitleValue(
                               boolBorderTop: false,
                               boolEnabled: true,
                               boolShowDisclosureIndicator: true,
                               stringTitle: 'Terms & condition',
                             //  stringValue: 'Manage',
                                txt: 'Read more',
                               onTapAction: () {
                                                                           Navigator.push(
                                                                                        context,
                                                                                           MaterialPageRoute(builder: (context) => TermsRoute()),
                                                                                                           );
                                                                                                     },
                             ),
                             //_buildTopics(context),
                             TableCellTitleValue(
                               boolBorderBottom: false,
                               boolBorderTop: false,
                               boolEnabled: false,
                               boolShowDisclosureIndicator: false,
                               stringTitle: 'Version',
                               //  stringValue: 'Manage',
                               txt: '1.0    ',
                               //onTapAction: () {
                              //   navigateCommand(routes.buildWorkgroupPageRoute())(context);
                              // },
                             ),
                           ],
                           crossAxisAlignment: CrossAxisAlignment.start,
                         ),
                       ],
                     ),
      ),
    );
  }
}



class PolicyRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                     backgroundColor: AaeColors.blue,
                            elevation: 1,
                      leading: new IconButton(icon: new Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.of(context).pop(),),
                    ),
      body: ListView(
                     padding: EdgeInsets.only(left:30,top:40,right:30),
                                children: <Widget>[
                                 Container(child: Text("Privacy policy\n\n", style: TextStyle(color: AaeColors.darkGray,fontWeight:FontWeight.bold, fontSize:18), ), ),
                                 Container(child: Text("Purpose\n", style: TextStyle(color: AaeColors.darkGray,fontWeight:FontWeight.bold, fontSize:16,height:1), ), ),
                                 Container(child: Text('This Privacy Policy is applicable to all former and current team members (together, “employees” or “you”) of American Airlines, Inc. (“we”, “us”, “our”, or “American”) and certain of its affiliates.  This Privacy Policy applies to our employees globally and therefore provides a global overview of how and why American will use employees’ personal information. It will be supplemented from time to time by more detailed information which will be provided to employees locally, for example at the point of collection of their data for a specific purpose.\n\nWe take your privacy seriously because we know you do.  This Privacy Policy will help answer your questions about how we collect, use, share, and maintain the confidentiality, availability, integrity and security of our employees’ personal information.\n\nThis Privacy Policy applies to employees’ personal information and to the management of that personal information in any form, whether oral, electronic, or written. This Privacy Policy is not a contract and American reserves the right to change it at any time and will notify employees of any material changes.\n', style: TextStyle(color: AaeColors.lightGray, fontSize:16, height:1.3), ), ),
                                 Container(child: Text("Collection of Your Personal Information\n", style: TextStyle(color: AaeColors.darkGray,fontWeight:FontWeight.bold, fontSize:16,height:1), ), ),
                                 Container(child: Text('The types of personal information that American may, where applicable and where permitted in accordance with applicable laws and regulations, collect and maintain as part of your employment with American, include:\n\n\u25CF  Contact and personal information - including name, gender, ethnicity (if volunteered or where necessary to comply with legal obligations, such as for diversity purposes), nationality/citizenship, home address and telephone number and other contact details, date of birth, disability status, marital status and dependents, emergency contacts;\n\n\u25CF  Recruitment/separation information  - including any information shared in the application process - residency and work permit status, military status, national identification, drivers’ license and passport information, references and other curriculum vitae information, date of resignation or termination, reason for resignation or termination, information relating to administering termination of employment;\n\n\u25CF  Financial information - taxpayer identification number(s) such as a social security number, banking details including credit and debit card information;\n\n\u25CF  Benefits distribution information - sick pay, pensions, insurance and other incentives and benefits information (including the gender, age, marital status, nationality and passport information for any spouse, guest travelers, minor children or other eligible dependents and beneficiaries);\n\n\u25CF  Career and job performance information - employee ID number, job title, job grade and function, date of hire, date(s) of promotions(s), work history, hours worked, work location, direct manager/supervisor information, technical skills, educational background, professional certifications and registrations, language capabilities, training courses attended and training assessment, records of work absences, vacation entitlement and requests, salary information (history and expectations), performance appraisals/evaluations, letters of appreciation and commendation, disciplinary and grievance procedures (including monitoring compliance with and enforcing American policies), employee complaints;\n\n\u25CF  Health-related information - height, weight, clothing sizes, photographs, symptoms, physical limitations and special needs;\n\n\u25CF  Background check information where permitted by law and proportionate in view of the function to be carried out by an employee or prospective employee - the results of credit and criminal background checks, the results of drug and alcohol testing, screening, health certifications, medical records and reports, information on accidents at work, vehicle registration, driving history;\n\n\u25CF  Compliance information as required to comply with laws, including the requests and directions of law enforcement authorities or court orders (child support and debt payment information) and acknowledgements regarding American policies; and\n\n\u25CF  Automatically collected information – information captured on security systems, including CCTV and key card entry systems, video recordings of company events and activities, voicemails, e-mails, correspondence and other work product and communications created, stored or transmitted by an employee using American’s computer or communications equipment, use of American’s computer equipment and company issued mobile devices, including Internet browsing history, mobile app usage, and precise geo-location.', style: TextStyle(color: AaeColors.lightGray, fontSize:16, height:1.3), ), ),
                                  ],
                                  ),
    );
  }
}


class TermsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                     backgroundColor: AaeColors.blue,
                            elevation: 1,
                      leading: new IconButton(icon: new Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.of(context).pop(),),
                    ),
      body: ListView(
         padding: EdgeInsets.only(left:30,top:40,right:30),
                    children: <Widget>[
                     Container(child: Text("Terms and conditions\n\n", style: TextStyle(color: AaeColors.darkGray,fontWeight:FontWeight.bold, fontSize:16), ),
                                                     ),
                                                     Container(child: Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\n\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\n\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", style: TextStyle(color: AaeColors.lightGray, fontSize:16), ),
                                                             ),
                      ],
                      ),
    );
  }
}



