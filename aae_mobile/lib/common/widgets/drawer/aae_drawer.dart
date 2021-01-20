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
import 'package:link/link.dart';
import 'package:linkable/linkable.dart';

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

    if (location == null) {
      location = "";
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[AaeColors.blue, AaeColors.lightBlue])),
        ),
        elevation: 1,
        leading: new Container(),
        actions: <Widget>[
          CloseButton(color: AaeColors.white),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AaeColors.gray),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        username.titleCase,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AaeColors.cadetGray),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        location.toUpperCase(),
                        maxLines: 1,
                        style: TextStyle(color: AaeColors.cadetGray),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                alignment: Alignment.centerLeft,
                child: FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(AaeIconsv4.setting,
                      color: AaeColors.cadetGray, size: 20),
                  label: Text('Preferences',
                      style: TextStyle(
                          color: AaeColors.cadetGray,
                          fontSize: 18,
                          height: 1.5)),
                  onPressed: () {
                    navigateCommand(routes.buildSettingsPageRoute())(context);
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(AaeIconsv4.info,
                      color: AaeColors.cadetGray, size: 20),
                  label: Text('About      ',
                      style: TextStyle(
                          color: AaeColors.cadetGray,
                          fontSize: 18,
                          height: 1.5)),
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
                  icon: Icon(AaeIconsv4.lock,
                      color: AaeColors.cadetGray, size: 20),
                  label: Text('Logout     ',
                      style: TextStyle(
                          color: AaeColors.cadetGray,
                          fontSize: 18,
                          height: 1.5)),
                  onPressed: () async {
                    SharedPreferences _sharedPref =
                        await SharedPreferences.getInstance();
                    _sharedPref.clear();
                    _logoutfromSM();
                    ServiceProvider.serviceOf<AaeNavigator>(context).pushNamed(
                        context, routes.buildSignInRoute(),
                        fromRoot: true);
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[AaeColors.blue, AaeColors.lightBlue])),
        ),
        // backgroundColor: AaeColors.blue,
        elevation: 1,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                  stringTitle: 'Terms & conditions',
                  //  stringValue: 'Manage',
                  txt: 'Read more',
                  onTapAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsRoute()),
                    );
                  },
                ),
                Row(children: [
                  SizedBox(width: 18),
                  Text("Version",
                      style: TextStyle(
                          color: AaeColors.cadetGray,
                          fontSize: 18,
                          height: 2.2)),
                  SizedBox(width: 162),
                  Text("9.9.9",
                      style: TextStyle(
                          color: AaeColors.cadetGray,
                          fontSize: 18,
                          height: 2.2))
                ]),
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[AaeColors.blue, AaeColors.lightBlue])),
        ),
        //  backgroundColor: AaeColors.blue,
        elevation: 1,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 40),
        children: <Widget>[
          Container(
            child: Text(
              "Privacy policy\n",
              style: TextStyle(
                  color: AaeColors.darkGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Purpose",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'This Privacy Policy is applicable to all former and current team members (together, “employees” or “you”) of American Airlines, Inc. (“we”, “us”, “our”, or “American”) and certain of its affiliates.  This Privacy Policy applies to our employees globally and therefore provides a global overview of how and why American will use employees’ personal information. It will be supplemented from time to time by more detailed information which will be provided to employees locally, for example at the point of collection of their data for a specific purpose.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

          Container(
                   padding: EdgeInsets.only(bottom: 8),
                      child: Text('We take your privacy seriously because we know you do.  This Privacy Policy will help answer your questions about how we collect, use, share, and maintain the confidentiality, availability, integrity and security of our employees’ personal information.',
                        style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                      ),
                    ),
                Container(
                                   padding: EdgeInsets.only(bottom: 8),
                                      child: Text('This Privacy Policy applies to employees’ personal information and to the management of that personal information in any form, whether oral, electronic, or written. This Privacy Policy is not a contract and American reserves the right to change it at any time and will notify employees of any material changes.',
                                      style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                              ),
                                            ),

                       Container(
                                                       padding: EdgeInsets.only(bottom: 20),
                                                          child: Text('We are providing this Privacy Policy to help you better understand the following:',
                                                          style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                                  ),
                                                                ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Collection of Your Personal Information",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'The types of personal information that American may, where applicable and where permitted in accordance with applicable laws and regulations, collect and maintain as part of your employment with American, include:',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Contact and personal information - including name, gender, ethnicity (if volunteered or where necessary to comply with legal obligations, such as for diversity purposes), nationality/citizenship, home address and telephone number and other contact details, date of birth, disability status, marital status and dependents, emergency contacts;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
          Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Recruitment/separation information  - including any information shared in the application process - residency and work permit status, military status, national identification, drivers’ license and passport information, references and other curriculum vitae information, date of resignation or termination, reason for resignation or termination, information relating to administering termination of employment;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
          Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Financial information - taxpayer identification number(s) such as a social security number, banking details including credit and debit card information;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
          Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Benefits distribution information - sick pay, pensions, insurance and other incentives and benefits information (including the gender, age, marital status, nationality and passport information for any spouse, guest travelers, minor children or other eligible dependents and beneficiaries);',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
           Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Career and job performance information - employee ID number, job title, job grade and function, date of hire, date(s) of promotions(s), work history, hours worked, work location, direct manager/supervisor information, technical skills, educational background, professional certifications and registrations, language capabilities, training courses attended and training assessment, records of work absences, vacation entitlement and requests, salary information (history and expectations), performance appraisals/evaluations, letters of appreciation and commendation, disciplinary and grievance procedures (including monitoring compliance with and enforcing American policies), employee complaints;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
             Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Health-related information - height, weight, clothing sizes, photographs, symptoms, physical limitations and special needs;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
             Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Background check information where permitted by law and proportionate in view of the function to be carried out by an employee or prospective employee - the results of credit and criminal background checks, the results of drug and alcohol testing, screening, health certifications, medical records and reports, information on accidents at work, vehicle registration, driving history;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
             Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Compliance information as required to comply with laws, including the requests and directions of law enforcement authorities or court orders (child support and debt payment information) and acknowledgements regarding American policies; and',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
             Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Automatically collected information – information captured on security systems, including CCTV and key card entry systems, video recordings of company events and activities, voicemails, e-mails, correspondence and other work product and communications created, stored or transmitted by an employee using American’s computer or communications equipment, use of American’s computer equipment and company issued mobile devices, including Internet browsing history, mobile app usage, and precise geo-location.\n',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Sources",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
           padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Most of the personal information we collect and process is information that you knowingly provide to us, for example during the onboarding process or during your employment.  It may also include information about you that we may receive from a third party, such as references from former employers, recruiters, personal references, and benefit providers.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Sensitive Personal Information",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
             padding: EdgeInsets.only(bottom: 8),
            child: Text(
              '"Sensitive personal information” includes any information about an employee that reveals racial or ethnic origin, political opinions, religious or philosophical beliefs, trade union membership, sexual orientation or information concerning a person’s sex life, genetic and biometric data, and health information.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),
                Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text('To the extent that any of the personal information we collect constitutes special categories of personal information, American will collect and process this information within the limits provided for relevant, applicable law, and only after establishing appropriate security safeguards for it. Where required by law, American will seek the explicit written consent of employees before processing special categories of personal information.  We may process special categories of personal information in the following additional circumstances:',
                style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                              ),
                                                            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Where we need to in order to carry out our legal obligations;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Where it is needed in the public interest, such as for equal opportunities monitoring or in relation to our occupational pension scheme; or',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Where it is needed to assess your working capacity on health grounds, subject to appropriate confidentiality safeguards.',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'We may use this type of data, where it is necessary in relation to legal claims, where it is necessary to protect your interests (or someone else’s) and where you are not capable of giving consent, or where you have already made the information public.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

        Container(
        padding: EdgeInsets.only(bottom: 8),
        child: Text('We will also use sensitive personal data to carry out our obligations in connection with your employment as set out below:',
        style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                      ),
                                                    ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Information relating to leaves of absence, which may include sickness absence or family related leaves, to comply with employment and other laws;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
    Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Information about your physical or mental health or disability status, to ensure your health and safety in the workplace and to assess your fitness to work, to provide appropriate workplace adjustments, to monitor and manage sickness absence and to administer benefits;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Information about your race or national or ethnic origin, religious, philosophical or moral beliefs, or your sex life or sexual orientation, to ensure meaningful equal opportunity monitoring and reporting;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Trade union membership information to pay trade union premiums, register the status of a protected employee and to comply with employment law obligations.\n',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Information about Criminal Convictions",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'We may only use information relating to criminal convictions where the law allows us to do so. This will usually be where such processing is necessary to carry out our obligations and in accordance with our policies.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

          Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Text('We may use information relating to criminal convictions where it is necessary in relation to legal claims, where it is necessary to protect your interests (or someone else’s) and you are not capable of giving your consent, or where you have already made the information public.',
          style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                        ),
                                                      ),


          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Use of Your Personal Information",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
           padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'We need all of the categories of information in the list above (Collection of Your Personal Information) primarily to allow us to perform our contract with you (designated by “*”) or to enable us to comply with our legal obligations (designated by “**”).  In some cases, we may use your personal information to pursue legitimate interests of our own or those of third parties (designated by “***”), provided your interests and fundamental rights do not override those interests.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

            Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text('The purposes for which American may process your personal information include, without limitation, those set out in the list below. For those employees based in the European Union, Switzerland and any other jurisdiction which legally requires us to specify the purposes for which we process personal information, we have used asterisks to indicate the purpose or purposes (referred to in the preceding paragraph) for which we may process your personal information.',
            style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                          ),
                                                        ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Facilitate internal applications: evaluate applications for employment opportunities within American*** - visa status/right to work in the jurisdiction** and background checks, where appropriate***;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Internal employee management: manage all aspects of an employee’s employment relationship - including without limitation payroll, benefits, incentives, compensation, corporate travel and other reimbursable expenses, development and training, absence monitoring, timekeeping, performance appraisal, disciplinary and grievance processes, administration of termination of employment, resource planning and allocation, talent management, succession planning and other general administrative and human resource related processes*;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Career planning: resource planning and allocation, talent management, succession planning***;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Business travel, relocation, transfers and cross-border programs: coordinate global employee programs, international moves and cross-border team work and project management*;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Compensation and benefits management: coordinate compensation and maintain medical and sickness records and occupational health programs - emergency contact and beneficiary details (which involves American holding information of those you nominate in this respect)*;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
        Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Security management: protect the safety and security of American customers, staff and property (including controlling and facilitating access to and monitoring activity in secured premises and activity using American computers, communications and other resources), investigate and respond to claims against American and its customers and employees, including any internal complaints**;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Corporate communications: to communicate with internal and external audiences (e.g., conduct employee surveys, administer employee recognition programs and promotions and diversity programs)*; and',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Compliance requirements: comply with applicable laws (e.g., health and safety), including judicial or administrative orders regarding individual employees (e.g., garnishments, child support payments)**.',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),

          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Some of the grounds for processing will overlap and there may be several grounds which justify our use of your personal information.',

              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

         Container(
         padding: EdgeInsets.only(bottom: 8),
         child: Text('There are Closed Circuit Television (CCTV) cameras in operation within and around our stations and other premises, which are used for the following purposes:',
         style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                       ),
                                                     ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'to prevent and detect crime**;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
        Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'to protect the health and safety of American customers and employees**;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  ' to manage and protect American’s property and the property of American’s guests and other visitors***; and',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'for quality assurance purposes***.\n',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Monitoring",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
           padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'To the extent permitted by law, we also monitor employees’ use of American information technology (IT) systems, the use of American’s resources, and communications, including without limitation internet use, in accordance with the Security Policy (available on Jetnet), and any other applicable policies that may replace, amend or supplement those policies from time to time ***.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

          Container(
          padding: EdgeInsets.only(bottom:20),
          child: Text('As a result, within the limits provided for by relevant, applicable law employees should not have an expectation of complete privacy while at work or while using or accessing company equipment, information, computer, or communication systems, as those systems may be accessed at any time in accordance with our monitoring policies.',
          style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                        ),
                                                      ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Change of Purpose",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
             padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'We will only use your personal information for the purposes for which we collected it, unless we reasonably consider that we need to use it for another reason and that reason is compatible with the original purpose. If we need to use your personal information for an unrelated purpose, we will notify you and we will explain the legal basis which allows us to do so.',

              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),
           Container(
           padding: EdgeInsets.only(bottom: 20),
           child: Text('Please note that we may process your personal information without your knowledge or consent, in compliance with the above rules, where this is required or permitted by law.',
           style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                         ),
                                                       ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "How Your Information Will Be Secured",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),


           Container( padding: EdgeInsets.only(bottom: 8), child: Wrap(  children: [
                               Linkable(text:"American is committed to protecting the security of your personal information. Whenever and wherever we collect, process or use personal information, we apply appropriate technical, physical and administrative safeguards and access restrictions to secure that information in accordance with this Privacy Policy in order to prevent unauthorized access and use, unlawful processing, unauthorized or accidental loss, destruction, or damage to that information.  For further information, contact the Information Security Officer aa.it.security@aa.com.",textColor: AaeColors.cadetGray, style: TextStyle( fontFamily: 'AmericanSans',fontSize: 16, height: 1.3), )
                               ] ),  ),

          Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Text('American will generally retain personal data in accordance with our data retention and schedules (available on Jetnet).',
          style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                        ),
                                                      ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "With Whom Your Information Will Be Shared",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1.3),
            ),
          ),
          Container(
             padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'In order to carry out the purposes set forth above, your information will be disclosed to the appropriate personnel within American, including without limitation human resources and payroll/accounting staff, and managers as well as American’s affiliates, consultants and other advisers or persons when necessary.  This includes disclosure of personal information to or for:',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'In order to carry out the purposes set forth above, your information will be disclosed to the appropriate personnel within American, including without limitation human resources and payroll/accounting staff, and managers as well as American’s affiliates, consultants and other advisers or persons when necessary.  This includes disclosure of personal information to or for:',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Our Agents, Services Providers and Suppliers: From time to time, we outsource the processing of certain functions and/or information to third parties. For example, we use an employee management platform called Success Factors which is hosted by SAP in the US as a platform to store employee data and manage your employee profile so when you apply online for an internal employment position with American for example, you will be directed to Success Factors. Further information will be provided about service providers who have access to your personal data locally from time to time.',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'When we outsource the processing of your personal information to third parties or provide your personal information to third party service providers, we take reasonable measures, such as implementing contractual controls, to endeavor to provide that those third parties safeguard your personal information with appropriate security measures and prohibit them from using your personal information for their own purposes or from disclosing your personal information to other third parties.',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Business Transitions: In the event we undergo a business transition involving another company, such as a merger, corporate reorganization, acquisition, the sale of all or a portion of our assets, or in the event of bankruptcy, information that we have collected from or about you may be disclosed to such other entities as part of the due diligence or business integration process and will be transferred to such entity as one of the transferred assets.*** For internationally based employees, the personal information disclosed will vary based on local labor laws.  Please contact your local human resources representative for country specifics.',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Legal and Regulatory Requirements: To the extent required by relevant, applicable law or regulation, we may be obligated to disclose personal information to government authorities, or to third parties pursuant to a subpoena or other legal process.**  Such information may be disclosed to:',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Protect your or American’s legal claims and interests',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Defend against potential or actual litigation',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Abide by applicable law, regulation or contracts',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Respond to a court order, governmental administrative or judicial process, including but not limited to, a subpoena or search warrant',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Comply with American’s obligations where it is registered with any governmental agency\n',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "International Data Transfers",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Please note that personal information submitted to us may be transferred to, stored and processed on servers located in various countries around the world, including when it is used as set out in this Privacy Policy by American in the United States of America, in accordance with applicable laws and regulations.',          style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),



           Container(  padding: EdgeInsets.only(bottom: 20), child: Wrap(  children: [
                                Linkable(text:"This may include transfers to American’s affiliates and to third parties with whom we share personal information, as described in this Privacy Policy.  The laws of those countries might not be equivalent to those in your country of residence, but please be assured that we take reasonable steps to protect your privacy, such as by implementing contractual controls such as American’s EU Standard Contractual Clauses which American has entered into with all of its branches located in the EU (a copy of which can be requested by contacting American at Privacy@aa.com) or seeking employee consent, where required by law.",textColor: AaeColors.cadetGray, style: TextStyle( fontFamily: 'AmericanSans',fontSize: 16, height: 1.3), )
                                ] ),  ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Application of Local Laws",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'This Privacy Policy provides global principles, which set out the minimum data protection requirements that American will apply to employees’ personal information. American recognizes that local, national or regional laws and regulations in certain jurisdictions may require stricter legal standards than those described in this Privacy Policy.  American will process employee personal information in accordance with applicable local law in those cases. Please contact your local human resources representative for country specifics.\n',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Voluntary or Mandatory Provision?",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
           padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'When collecting personal information from you, American will, where required by applicable law, inform you whether your provision of the requested information is voluntary or whether provision of it is mandatory and if so the consequences of not providing it. The provision of certain personal information is necessary for us to enter into an employment contract with you and/or for us to perform our obligations under that contract and without it we will be unable to do so, such as the provision of your bank details in order for us to pay you for your services via direct deposit.',
                style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

          Container(
          padding: EdgeInsets.only(bottom:20),
          child: Text( 'If you choose not to provide certain information, this may impact your use of certain resources (e.g., if you refuse to provide information about your spouse, you may not be eligible for spousal coverage under employer-sponsored health insurance).',
          style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                        ),
                                                      ),
          Container(

            child: Text(
              "Your Rights with Respect to Your Personal Information\n",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Right to Object",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(

            child: Text(
              'If you are located in the European Union or Switzerland you have the right to object to our use of your personal data, on grounds relating to your particular situation, to the extent the processing is based on our legitimate interests.  If we receive an objection, then we will stop processing the personal data unless we demonstrate compelling legitimate grounds for the processing which override your interests, rights and freedoms or if the processing is necessary for the establishment, exercise or defense of legal claims.\n',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Additional Rights",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'If you are located in the European Union or Switzerland, you have the following rights under applicable data privacy laws (unless exemptions apply), which can be exercised by contacting your local employer or American using the details provided below.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request access to your personal information. This enables you to receive a copy of the personal information we hold about you and to check that we are lawfully processing it.',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request correction of the personal information that we hold about you. This enables you to have any incomplete or inaccurate information we hold about you corrected.',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request erasure of your personal information. This enables you to ask us to delete or remove personal information where there is no good reason for us continuing to process it. You also have the right to ask us to delete or remove your personal information where you have exercised your right to object to processing (see above).',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request the restriction of processing of your personal information. This enables you to ask us to suspend the processing of personal information about you, for example if you want us to establish its accuracy or the reason for processing it;',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request the transfer of your personal information to another party; and',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
            Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The right to withdraw consent at any time where we have relied on it to process your personal data.',
                  style: TextStyle(
                      color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),
                Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),
          Container(
            child: Text(
              'Similar rights may exist under local data protection laws of other countries outside of the EU and the US. For further details please use the contact details below.\n',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),

          Container(
           padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Contact Details",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),

        //  Container(
        //   padding: EdgeInsets.only(bottom: 8),
        //    child: Text( 'If you wish to exercise your rights, issue a request, or if you have other questions, comments or concerns about our privacy practices, please contact the Privacy Office at Privacy@aa.com.  Please provide your name and contact information along with the request. Alternatively, inquiries may be mailed to the following address:',
         //     style: TextStyle( color: AaeColors.lightGray, fontSize: 16, height: 1.3),   ), ),



          Container(  child: Wrap(  children: [
                     Linkable(text:"If you wish to exercise your rights, issue a request, or if you have other questions, comments or concerns about our privacy practices, please contact the Privacy Office at Privacy@aa.com. Please provide your name and contact information along with the request. Alternatively, inquiries may be mailed to the following address:",textColor: AaeColors.cadetGray, style: TextStyle( fontFamily: 'AmericanSans',fontSize: 16, height: 1.3), )
                     ] ),  ),


            Container(
            child: Text('American Airlines\nc/o Privacy Office\n1 Skyview Drive, MD 8B503\nFort Worth, Texas 76155\n',
            style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                                          ),
                                                        ),
          Container(
             padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Data Protection Officer",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),

       //   Container(
        //    child: Text( 'American has assigned a data protection officer, Russell Hubbard, who is responsible for overseeing American’s compliance with EU data protection law, whom you may contact at Privacy@aa.com or via the postal address above in case of any questions or concerns regarding the processing of your personal data.\n',
       //       style: TextStyle( color: AaeColors.lightGray, fontSize: 16, height: 1.3), ), ),


          Container(  child: Wrap(  children: [
                     Linkable(text:"American has assigned a data protection officer, Russell Hubbard, who is responsible for overseeing American’s compliance with EU data protection law, whom you may contact at Privacy@aa.com or via the postal address above in case of any questions or concerns regarding the processing of your personal data.\n",textColor: AaeColors.cadetGray, style: TextStyle( fontFamily: 'AmericanSans',fontSize: 16, height: 1.3), )
                     ] ),  ),


          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "EU Representative",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(
          padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'American in the US has appointed the following representative in the EU:',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),


           Container(  child: Wrap(  children: [
           Linkable(text:"American Airlines, Inc.\nOrient House (HAA3),\nPo Box 365, Waterside,\nHarmondsworth,\nUB7 0GB\nUnited Kingdom\nContact:  Lisa.Banks@aa.com\n",textColor: AaeColors.cadetGray, style: TextStyle( fontFamily: 'AmericanSans',fontSize: 16, height: 1.3), )
           ] ),  ),


          Container(
           padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Complaints",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),



            Container(  child: Wrap(  children: [
                      Linkable(text:"If American’s processing of your personal data is covered by EU law or Swiss Law you may also contact or lodge a complaint with the corresponding data protection supervisory authority in your country of residence. You can find the relevant EU supervisory authority name and contact details under http://ec.europa.eu/justice/data-protection/bodies/authorities/index_en\n",textColor: AaeColors.cadetGray, style: TextStyle( fontFamily: 'AmericanSans',fontSize: 16, height: 1.3), )
                      ] ),  ),

    // webview link
      //    Container(  child: Wrap(  children: [  Text('If American’s processing of your personal data is covered by EU law or Swiss Law you may also contact or lodge a complaint with the corresponding data protection supervisory authority in your country of residence. You can find the relevant EU supervisory authority name and contact details under',style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3), ), Link( child: Text('http://ec.europa.eu/justice/data-protection/bodies/authorities/index_en.htm.\n',style: TextStyle(color: AaeColors.blue, fontSize: 16, height: 1.3),), url: 'http://ec.europa.eu/justice/data-protection/bodies/authorities/index_en.htm.\n', ),  ] ),  ),


          Container(
           padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Effective Date",
              style: TextStyle(
                  color: AaeColors.cadetGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'This Privacy Policy is effective on and was last reviewed in June 18, 2020.',
              style: TextStyle(
                  color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
            ),
          ),
          //
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[AaeColors.blue, AaeColors.lightBlue])),
        ),
        // backgroundColor: AaeColors.blue,
        elevation: 1,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 40),
        children: <Widget>[
          Container(
            child: Text(
              "Terms and conditions\n",
              style: TextStyle(
                  color: AaeColors.darkGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                       "Introduction",
                       style: TextStyle( color: AaeColors.cadetGray, fontWeight: FontWeight.bold,  fontSize: 18,height: 1),  ), ),
                        Container( padding: EdgeInsets.only(bottom: 20), child: Text(
                         'By using this application, you agree you will use it in a professional, ethical, and lawful manner. With each login, you agree to be bound by these terms and conditions without limitation or qualification. By proceeding, you represent and warrant that you have the legal right to enter into this Agreement on your behalf.',
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                         'Who has access?',
                         style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "This application is for use by American Airlines employees. As an authorized user, you've been provided with a user ID and password to access this application. Keep in mind that this app contains confidential American information as well as personalized services for you.",
                        style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Confidential information',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "Computer access codes and associated passwords that allow access to American's information technology assets are confidential information. Except as required by law or with American's prior written consent, you agree to keep confidential and not discuss with or disclose to any person (including your friends or family) your computer access code and password and to not access this app with another person's access code. Except as required by law or with American's prior written, you will keep confidential and will not sell, transfer, publish, display, discuss with, disclose, or other make available to any person, other than employees of American, on a need to know basis, any confidential or competitive information processed as a consequence of your computer access code and password. You will immediately report to American any inadvertent or intentional violation or breach of any commitment and agreement you make under this Section. You agree to abide by the commitments and agreements made in this Section until American releases you from these commitments, but in no event before the termination of your employment or contract with American.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),


                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Security',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "You agree to observe all security features of this application and to not disable or bypass any security protocols. You may not use this app to gain unauthorized access to other devices or computer networks, or for malicious or destructive purposes (such as the development or transmission of computer viruses). You are responsible for all usage or activity on your account.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),


                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Using this app for your personal matters',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "This application offers many features for your own personal use. Your personal use of this application must be consistent with American's policies and this Agreement.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),



                          Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'A few reminders when accessing this application from your mobile device',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 8), child: Text(
                        "You may not use this application in any disruptive, offensive, unprofessional, unethical, or illegal manner. For example, you may not use this app to link to, search for, download, upload, store, send, distribute, or display material that may (or does):",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '1.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Interfere with any American employee's job performance (including your own);",
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),

                                    Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '2.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Cause undue expense for American;',
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),

                                    Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '3.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Compromise American's reputation;",
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),

                                    Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '4.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Constitute indecent, obscene, or pornographic material;',
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '5.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Harass, threaten, embarrass, deceive, or degrade any person; or',
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),

                                    Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '6.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Discriminate or harass any employee based on a characteristic protected by law or American’s policies. ',
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),

                                    Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '7.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Access, copy, distribute, or use confidential, proprietary, copyrighted, patented, trademarked, or trade secret material without authorization;',
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),


                                     Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '8.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Engage in a private, commercial business; or',
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:.5), ), ]),

                                    Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '9.',
                                        style: TextStyle(
                                            color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Modify, encrypt, or destroy Company property.',
                                          style: TextStyle(
                                              color: AaeColors.cadetGray, fontSize: 16, height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row( children: [ Text('\u0020',style: TextStyle(color: AaeColors.cadetGray, fontSize: 16, height:1.5), ), ]),


                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Accessing this application from an American company-issued mobile device',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "American may monitor your use of this application, without notice, to ensure compliance with this Agreement and American's policies.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),


                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Accessing this application from a personal mobile device',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "Outside your use of this application, American does not monitor your use of non-Company devices. When you use this application from a personal device, however, American may monitor your use of this application, including Internet links through this application, without notice, to ensure compliance with this Agreement and American's policies.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),


                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Cookie use',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "To help you find and receive information easily, this application uses small session cookies files, which are erased when you close your browser. This app does not examine other cookies or information stored on your computer. If you choose to not accept the session cookie, you will not be able to use this app. However, this app does not control the use of cookies or other tracking devices from other web sites you may link to from this application.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),


                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'E-mail address use',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "If you send us an e-mail or provide your e-mail address through any of the sites contained within this application, we may use e-mail to communicate with you. American will not share your e-mail address with outside parties except to companies contracted for employee services to provide those services. As an American employee, adding your e-mail address to the employee directory signifies your willingness to have your e-mail address available to any American employee. The e-mail directory is American's sole property. You may not give to any person not employed by American any e-mail address from the e-mail directory. You may not use the e-mail directory to solicit employees to participate in, to join, or to purchase from any organization outside American, or to disseminate, unsolicited, your personal views or opinions.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),


                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Linking to other applications and web sites',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "This application provides you with the convenience of additional links to other applications and web sites that we think you'll find useful. These sites may operate under different use and privacy guidelines. American has no control over information gathered or submitted by these other sites. Be sure to read and understand their guidelines. Be aware that you are responsible for familiarizing yourself with the guidelines of these other sites.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Intellectual property',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "Information contained in this application is American's exclusive property. Unless otherwise noted, all information, text, articles, data, images, screens, Web pages, logos, trademarks and service marks, and other material on this application are American's exclusive property or used by permission. You do not, by virtue of downloading any material from this app, obtain title to, or any other ownership interest in, those materials. American retains full and complete title to this material, and all related intellectual property rights, and is licensing you to use the material subject to this Agreement and any other terms connected to the material. Modification of the material or use of the material for any other purpose violates American's copyright and other proprietary rights.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Responsibility for misuse',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "Every user of this application is responsible for any misuse of the system or use of the system in violation of this Agreement.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Violations',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "Any person who violates this Agreement may be subject to the loss of access to this application, disciplinary employment action up to and including termination, and civil and criminal liability.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Reporting concerns',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                    //    Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                     //   "If you think another person is using this application in violation of this Agreement, report your concerns. In North America, report concerns to the EthicsPoint helpline online at www.aa.ethicspoint.com or to 877-422-3844. This number is toll-free, 24 hours a day, 7 days a week. If you are calling from outside North America, go to www.aa.ethicspoint.com for international, toll-free dialing instructions.",
                     //    style: TextStyle( color: AaeColors.lightGray, fontSize: 16, height: 1.3),  ),  ),

                         Container(  padding: EdgeInsets.only(bottom: 20), child: Wrap(  children: [
                          Linkable(text:"If you think another person is using this application in violation of this Agreement, report your concerns. In North America, report concerns to the EthicsPoint helpline online at www.aa.ethicspoint.com or to 877-422-3844. This number is toll-free, 24 hours a day, 7 days a week. If you are calling from outside North America, go to www.aa.ethicspoint.com for international, toll-free dialing instructions.\n",textColor: AaeColors.cadetGray, style: TextStyle( fontFamily: 'AmericanSans',fontSize: 16, height: 1.3), )
                           ] ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Importance of logout',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "You must always log out to protect your privacy. It is your responsibility. We also use a timeout feature to protect you. So after a period of inactivity on this application, you will be logged out automatically.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Disclaimers',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 8), child: Text(
                        "The content of this application may contain inaccuracies or typographical errors. American may alter, change, or improve the content at any time and without notice. American makes no representations or warranties as to the Content's completeness or accuracy, and makes no commitment to update the content or application. American makes no representations about the content's or application's suitability for any purpose.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),
                         Container(  padding: EdgeInsets.only(bottom: 8), child: Text(
                         'YOU USE THIS APPLICATION AT YOUR OWN RISK. THE APPLICATION AND ALL CONTENT FOUND THEREIN IS PROVIDED "AS IS" AND WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED WARRANTIES OF EXPECTATION OF PRIVACY, FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, NON-INFRINGEMENT, OR TITLE. AMERICAN DOES NOT WARRANT THAT THIS APPLICATION OR APPLICATIONS LINKED TO THIS APPLICATION WILL BE UNINTERRUPTED, FREE FROM DEFECTS, RELIABLE, OR FREE FROM ERRORS; THAT DEFECTS WILL BE CORRECTED; OR THAT THIS APPLICATION OR APPLICATIONS LINKED TO THIS APPLICATION ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS.',
                          style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),
                         Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                         "IN NO EVENT WILL AMERICAN BE LIABLE FOR ANY DAMAGES (WHETHER CONSEQUENTIAL, DIRECT, INCIDENTAL, INDIRECT, PUNITIVE, SPECIAL, OR OTHERWISE) ARISING OUT OF, OR IN ANY WAY CONNECTED WITH, THE USE OF OR INABILITY TO USE THE APPLICATION OR FOR ANY OF THE CONTENT OBTAINED THROUGH OR OTHERWISE IN CONNECTION WITH THE APPLICATION, IN EACH CASE REGARDLESS OF WHETHER THE DAMAGES ARE BASED ON CONTRACT, STRICT LIABILITY, TORT, OR OTHER THEORIES OF LIABILITY, AND ALSO REGARDLESS OF WHETHER AMERICAN WAS GIVEN ACTUAL OR CONSTRUCTIVE NOTICE THAT DAMAGES WERE POSSIBLE.",
                          style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Applicable law',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 20), child: Text(
                        "This application is created and controlled by American in the State of Texas, USA. As such, the laws of the State of Texas will govern these disclaimers, terms, and conditions, without giving effect to any principles of conflicts of laws. You agree to bring any claims against American exclusively in the state or federal courts of Texas. In addition, you hereby irrevocably and unconditionally consent to submit to the exclusive jurisdiction of the courts of the State of Texas for any litigation arising out of or relating to use of or purchases made through this application. If any provision of this Agreement is held by a court or arbitrator of competent jurisdiction to be invalid, unenforceable, or void, then that provision will be deemed severable from this agreement and will not affect the validity and enforceability of any remaining provisions. You agree that you will comply with all applicable laws in connection with your use of this application.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),

                        Container( padding: EdgeInsets.only(bottom: 8), child: Text(
                        'Legal terms',
                        style: TextStyle(color: AaeColors.cadetGray, fontWeight: FontWeight.bold, fontSize: 18, height: 1),    ), ),
                        Container(  padding: EdgeInsets.only(bottom: 8), child: Text(
                        "This application is restricted solely to authorized users for legitimate business purposes. Unauthorized users are subject to disciplinary action, civil liability, and criminal penalties. In accordance with published security policies, individuals accessing this system consent to having their activities monitored and recorded. Any evidence of unauthorized activity may be provided to law enforcement officials.",
                         style: TextStyle( color: AaeColors.cadetGray, fontSize: 16, height: 1.3),  ),  ),



            //    Container(  child: Wrap(  children: [ Linkable(text:"Hi!\nI'm Anup.\n\nYou can email me at 1anuppanwar@gmail.com.\nOr just whatsapp me @ +91-8968894728.\n", )    ] ),  ),
             //          Container(  child: Link( child: Text('link'), url: 'https://flutter.dev', )  ),
  //     Container(padding: EdgeInsets.only(bottom: 10),
       //     child: Text( 'Thank you for choosing American Airlines, Inc. Flight Status Notification text messaging service for your mobile device. Your use of the Service, as hereafter defined, constitutes your agreement to these terms and conditions. We may amend these terms, or modify or cancel the Service or any of its features without notice. Message and Data Rates may apply. Check with your mobile service provider for details on specific fees and charges that may apply for you. Click to view aa.com Privacy Policy. American Airlines offers its customers mobile access to flight information (e.g., for tracking flight status, gate, time, and baggage claim) over Short Message Service ("SMS") or SMS text messages (the "Service"). The Service will be ongoing but may be cancelled by us at any time. Customers may opt out of the Service at any time (see "To Stop the Service" below).',
        //      style: TextStyle(  color: AaeColors.lightGray, fontSize: 16, height: 1.3), ),  ),

        //  Container(  child: Text('United States of America:',style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),),   ),

       //   Container( padding: EdgeInsets.only(bottom: 8), child: Wrap( children: [
        //   Text('Web site - ',style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),),
       //     Link( child: Text('www.aa.com/FLYAA',style: TextStyle(color: AaeColors.blue, fontSize: 16, height: 1.3),), url: 'https://www.aa.com/FLYAA', ),
       //    Text('Mobile Phone - (35922)\nTo get help, you can contact us at any time from your mobile phone by sending a text message with the word "HELP" to FLYAA (35922).\nTo Stop the Service: To stop the messages coming to your mobile phone, you can opt out of the Service via SMS. Just send a text message with the word "STOP" to FLYAA (35922). You will receive a one-time opt-out confirmation text message. After that, you will not receive any future messages.',style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),), ],  ), ),

                       //         Container(   padding: EdgeInsets.only(bottom: 8), child: Wrap(  children: [
                       //         Linkable(text:'Web site - www.aa.com/FLYAA\nMobile Phone - (35922)\nTo get help, you can contact us at any time from your mobile phone by sending a text message with the word "HELP" to FLYAA (35922).\nTo Stop the Service: To stop the messages coming to your mobile phone, you can opt out of the Service via SMS. Just send a text message with the word "STOP" to FLYAA (35922). You will receive a one-time opt-out confirmation text message. After that, you will not receive any future messages.',textColor: AaeColors.lightGray, style: TextStyle( fontFamily: 'AmericanSans',fontSize: 16, height: 1.3), )
                        //                             ] ),  ),



       //     Container(padding: EdgeInsets.only(bottom: 8),
       //              child: Text('Spain or United Kingdom:\nMobile Phone - (447950080989)\nTo get help, you can contact us at any time from your mobile phone by sending a text message with the word "HELP" to (447950080989).\nTo Stop the Service: To stop the messages coming to your mobile phone, you can opt out of the Service via SMS. Just send a text message with the word "STOP" to (447950080989). You will receive a one-time opt-out confirmation text message. After that, you will not receive any future messages.',
       //              style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),    ),  ),

      //     Container( padding: EdgeInsets.only(bottom: 8),
       //             child: Text('Agreement to Terms & Conditions: Your use of the Service constitutes your agreement to these terms and conditions and to the aa.com Site Usage terms.',
       //             style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),   ),  ),

        //   Container( padding: EdgeInsets.only(bottom: 8),
           //         child: Text('You agree to provide American Airlines with a valid mobile number. You agree that we may send you text messages through your wireless provider. We do not charge for the Service, but you are responsible for all charges and fees associated with text messaging imposed by your wireless provider.',
            //        style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),   ),  ),

         //    Container(  padding: EdgeInsets.only(bottom: 8),
           //           child: Text('Notify us immediately of any changes to your registered device. In case of unauthorized access to your device or Service, you agree to cancel enrollment associated with such device immediately.',
          //            style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),    ),   ),
          //    Container(             padding: EdgeInsets.only(bottom: 8),
            //           child: Text('You agree to indemnify, defend, and hold harmless American Airlines and its affiliates from and against any and all third party claims, demands, proceedings, suits, actions, liabilities, obligations, losses,, damages, penalties, taxes, levies, fines, judgments, settlements or costs (collectively, "Claims") based on, arising or resulting from your use of the Service, including without limitation any Claims alleging facts that if true would constitute your breach of these terms, or from you providing us with a phone number that is not your own.',
            //           style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),    ), ),
           //    Container( padding: EdgeInsets.only(bottom: 8),
            //            child: Text('You agree that we will not be liable for failed, delayed, or misdirected delivery of, any information sent through the Service; any errors in such information; any action you may or may not take in reliance on the information of Service. AMERICAN AIRLINES WILL NOT UNDER ANY CIRCUMSTANCE BE LIABLE TO YOU FOR SPECIAL, INDIRECT, PUNITIVE, EXEMPLARY OR CONSQUENTIAL DAMAGES.',
            //            style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),  ),      ),
          //      Container( padding: EdgeInsets.only(bottom: 8),
            //             child: Text('Our participating carriers include, but are not limited to AT&T, Sprint, Verizon Wireless, U.S. Cellular®, T-Mobile® and MetroPCS®. The mobile carriers are not liable for delayed or undelivered messages.',
            //             style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),  ),),
            //     Container(  padding: EdgeInsets.only(bottom: 8),
             //             child: Text('Any failure of American Airlines to assert any rights it may have hereunder does not constitute a waiver of its right to assert the same or any other right at any other time or against any other person or entity. If any provision of these terms and conditions is found to be invalid or unenforceable, then the invalid or unenforceable provision will be stricken without affecting the validity or enforceability of any other provision.',
              //            style: TextStyle(color: AaeColors.lightGray, fontSize: 16, height: 1.3),   ),    ),

        ],
      ),
    );
  }
}
