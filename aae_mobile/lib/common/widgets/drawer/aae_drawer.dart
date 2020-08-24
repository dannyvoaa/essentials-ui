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
                  colors: <Color>[AaeColors.blue, AaeColors.gradientTop])),
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
                    bottom: BorderSide(color: AaeColors.ultraLightGray),
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
                            color: AaeColors.lightGray),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        location.toUpperCase(),
                        maxLines: 1,
                        style: TextStyle(color: AaeColors.lightGray),
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
                      color: AaeColors.lightGray, size: 20),
                  label: Text('Preferences',
                      style: TextStyle(
                          color: AaeColors.lightGray,
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
                      color: AaeColors.lightGray, size: 20),
                  label: Text('About      ',
                      style: TextStyle(
                          color: AaeColors.lightGray,
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
                      color: AaeColors.lightGray, size: 20),
                  label: Text('Logout     ',
                      style: TextStyle(
                          color: AaeColors.lightGray,
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
                  colors: <Color>[AaeColors.blue, AaeColors.gradientTop])),
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
                          color: AaeColors.lightGray,
                          fontSize: 18,
                          height: 2.2)),
                  SizedBox(width: 160),
                  Text("1.0.2",
                      style: TextStyle(
                          color: AaeColors.lightGray,
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
                  colors: <Color>[AaeColors.blue, AaeColors.gradientTop])),
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
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'This Privacy Policy is applicable to all former and current team members (together, “employees” or “you”) of American Airlines, Inc. (“we”, “us”, “our”, or “American”) and certain of its affiliates.  This Privacy Policy applies to our employees globally and therefore provides a global overview of how and why American will use employees’ personal information. It will be supplemented from time to time by more detailed information which will be provided to employees locally, for example at the point of collection of their data for a specific purpose.\n\nWe take your privacy seriously because we know you do.  This Privacy Policy will help answer your questions about how we collect, use, share, and maintain the confidentiality, availability, integrity and security of our employees’ personal information.\n\nThis Privacy Policy applies to employees’ personal information and to the management of that personal information in any form, whether oral, electronic, or written. This Privacy Policy is not a contract and American reserves the right to change it at any time and will notify employees of any material changes.\n\n We are providing this Privacy Policy to help you better understand the following:\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Collection of Your Personal Information",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'The types of personal information that American may, where applicable and where permitted in accordance with applicable laws and regulations, collect and maintain as part of your employment with American, include:\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
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
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Contact and personal information - including name, gender, ethnicity (if volunteered or where necessary to comply with legal obligations, such as for diversity purposes), nationality/citizenship, home address and telephone number and other contact details, date of birth, disability status, marital status and dependents, emergency contacts;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Recruitment/separation information  - including any information shared in the application process - residency and work permit status, military status, national identification, drivers’ license and passport information, references and other curriculum vitae information, date of resignation or termination, reason for resignation or termination, information relating to administering termination of employment;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Financial information - taxpayer identification number(s) such as a social security number, banking details including credit and debit card information;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Benefits distribution information - sick pay, pensions, insurance and other incentives and benefits information (including the gender, age, marital status, nationality and passport information for any spouse, guest travelers, minor children or other eligible dependents and beneficiaries);\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Career and job performance information - employee ID number, job title, job grade and function, date of hire, date(s) of promotions(s), work history, hours worked, work location, direct manager/supervisor information, technical skills, educational background, professional certifications and registrations, language capabilities, training courses attended and training assessment, records of work absences, vacation entitlement and requests, salary information (history and expectations), performance appraisals/evaluations, letters of appreciation and commendation, disciplinary and grievance procedures (including monitoring compliance with and enforcing American policies), employee complaints;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Health-related information - height, weight, clothing sizes, photographs, symptoms, physical limitations and special needs;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Background check information where permitted by law and proportionate in view of the function to be carried out by an employee or prospective employee - the results of credit and criminal background checks, the results of drug and alcohol testing, screening, health certifications, medical records and reports, information on accidents at work, vehicle registration, driving history;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Compliance information as required to comply with laws, including the requests and directions of law enforcement authorities or court orders (child support and debt payment information) and acknowledgements regarding American policies; and\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Automatically collected information – information captured on security systems, including CCTV and key card entry systems, video recordings of company events and activities, voicemails, e-mails, correspondence and other work product and communications created, stored or transmitted by an employee using American’s computer or communications equipment, use of American’s computer equipment and company issued mobile devices, including Internet browsing history, mobile app usage, and precise geo-location.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Sources",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'Most of the personal information we collect and process is information that you knowingly provide to us, for example during the onboarding process or during your employment.  It may also include information about you that we may receive from a third party, such as references from former employers, recruiters, personal references, and benefit providers.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Sensitive Personal Information",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              '"Sensitive personal information” includes any information about an employee that reveals racial or ethnic origin, political opinions, religious or philosophical beliefs, trade union membership, sexual orientation or information concerning a person’s sex life, genetic and biometric data, and health information.\n\nTo the extent that any of the personal information we collect constitutes special categories of personal information, American will collect and process this information within the limits provided for relevant, applicable law, and only after establishing appropriate security safeguards for it. Where required by law, American will seek the explicit written consent of employees before processing special categories of personal information.  We may process special categories of personal information in the following additional circumstances:\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
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
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Where we need to in order to carry out our legal obligations;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Where it is needed in the public interest, such as for equal opportunities monitoring or in relation to our occupational pension scheme; or\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Where it is needed to assess your working capacity on health grounds, subject to appropriate confidentiality safeguards.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            child: Text(
              'We may use this type of data, where it is necessary in relation to legal claims, where it is necessary to protect your interests (or someone else’s) and where you are not capable of giving consent, or where you have already made the information public.\n\nWe will also use sensitive personal data to carry out our obligations in connection with your employment as set out below:\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
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
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Information relating to leaves of absence, which may include sickness absence or family related leaves, to comply with employment and other laws;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Information about your physical or mental health or disability status, to ensure your health and safety in the workplace and to assess your fitness to work, to provide appropriate workplace adjustments, to monitor and manage sickness absence and to administer benefits;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Information about your race or national or ethnic origin, religious, philosophical or moral beliefs, or your sex life or sexual orientation, to ensure meaningful equal opportunity monitoring and reporting;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Trade union membership information to pay trade union premiums, register the status of a protected employee and to comply with employment law obligations.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Information about Criminal Convictions",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'We may only use information relating to criminal convictions where the law allows us to do so. This will usually be where such processing is necessary to carry out our obligations and in accordance with our policies.\n\nWe may use information relating to criminal convictions where it is necessary in relation to legal claims, where it is necessary to protect your interests (or someone else’s) and you are not capable of giving your consent, or where you have already made the information public.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Use of Your Personal Information",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'We need all of the categories of information in the list above (Collection of Your Personal Information) primarily to allow us to perform our contract with you (designated by “*”) or to enable us to comply with our legal obligations (designated by “**”).  In some cases, we may use your personal information to pursue legitimate interests of our own or those of third parties (designated by “***”), provided your interests and fundamental rights do not override those interests.\n\nThe purposes for which American may process your personal information include, without limitation, those set out in the list below. For those employees based in the European Union, Switzerland and any other jurisdiction which legally requires us to specify the purposes for which we process personal information, we have used asterisks to indicate the purpose or purposes (referred to in the preceding paragraph) for which we may process your personal information.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
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
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Facilitate internal applications: evaluate applications for employment opportunities within American*** - visa status/right to work in the jurisdiction** and background checks, where appropriate***;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Internal employee management: manage all aspects of an employee’s employment relationship - including without limitation payroll, benefits, incentives, compensation, corporate travel and other reimbursable expenses, development and training, absence monitoring, timekeeping, performance appraisal, disciplinary and grievance processes, administration of termination of employment, resource planning and allocation, talent management, succession planning and other general administrative and human resource related processes*;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Career planning: resource planning and allocation, talent management, succession planning***;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Business travel, relocation, transfers and cross-border programs: coordinate global employee programs, international moves and cross-border team work and project management*;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Compensation and benefits management: coordinate compensation and maintain medical and sickness records and occupational health programs - emergency contact and beneficiary details (which involves American holding information of those you nominate in this respect)*;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Security management: protect the safety and security of American customers, staff and property (including controlling and facilitating access to and monitoring activity in secured premises and activity using American computers, communications and other resources), investigate and respond to claims against American and its customers and employees, including any internal complaints**;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Corporate communications: to communicate with internal and external audiences (e.g., conduct employee surveys, administer employee recognition programs and promotions and diversity programs)*; and\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Compliance requirements: comply with applicable laws (e.g., health and safety), including judicial or administrative orders regarding individual employees (e.g., garnishments, child support payments)**.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            child: Text(
              'Some of the grounds for processing will overlap and there may be several grounds which justify our use of your personal information.\n\nThere are Closed Circuit Television (CCTV) cameras in operation within and around our stations and other premises, which are used for the following purposes:\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
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
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'to prevent and detect crime**;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'to protect the health and safety of American customers and employees**;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  ' to manage and protect American’s property and the property of American’s guests and other visitors***; and\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'for quality assurance purposes***.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Monitoring",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'To the extent permitted by law, we also monitor employees’ use of American information technology (IT) systems, the use of American’s resources, and communications, including without limitation internet use, in accordance with the Security Policy (available on Jetnet), and any other applicable policies that may replace, amend or supplement those policies from time to time ***.\n\nAs a result, within the limits provided for by relevant, applicable law employees should not have an expectation of complete privacy while at work or while using or accessing company equipment, information, computer, or communication systems, as those systems may be accessed at any time in accordance with our monitoring policies.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Change of Purpose",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'We will only use your personal information for the purposes for which we collected it, unless we reasonably consider that we need to use it for another reason and that reason is compatible with the original purpose. If we need to use your personal information for an unrelated purpose, we will notify you and we will explain the legal basis which allows us to do so.\n\nPlease note that we may process your personal information without your knowledge or consent, in compliance with the above rules, where this is required or permitted by law.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "How Your Information Will Be Secured",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'American is committed to protecting the security of your personal information. Whenever and wherever we collect, process or use personal information, we apply appropriate technical, physical and administrative safeguards and access restrictions to secure that information in accordance with this Privacy Policy in order to prevent unauthorized access and use, unlawful processing, unauthorized or accidental loss, destruction, or damage to that information.  For further information, contact the Information Security Officer aa.it.security@aa.com.\n\nAmerican will generally retain personal data in accordance with our data retention and schedules (available on Jetnet).\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "With Whom Your Information Will Be Shared",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1.3),
            ),
          ),
          Container(
            child: Text(
              'In order to carry out the purposes set forth above, your information will be disclosed to the appropriate personnel within American, including without limitation human resources and payroll/accounting staff, and managers as well as American’s affiliates, consultants and other advisers or persons when necessary.  This includes disclosure of personal information to or for:\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
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
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'In order to carry out the purposes set forth above, your information will be disclosed to the appropriate personnel within American, including without limitation human resources and payroll/accounting staff, and managers as well as American’s affiliates, consultants and other advisers or persons when necessary.  This includes disclosure of personal information to or for:\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Our Agents, Services Providers and Suppliers: From time to time, we outsource the processing of certain functions and/or information to third parties. For example, we use an employee management platform called Success Factors which is hosted by SAP in the US as a platform to store employee data and manage your employee profile so when you apply online for an internal employment position with American for example, you will be directed to Success Factors. Further information will be provided about service providers who have access to your personal data locally from time to time.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'When we outsource the processing of your personal information to third parties or provide your personal information to third party service providers, we take reasonable measures, such as implementing contractual controls, to endeavor to provide that those third parties safeguard your personal information with appropriate security measures and prohibit them from using your personal information for their own purposes or from disclosing your personal information to other third parties.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Business Transitions: In the event we undergo a business transition involving another company, such as a merger, corporate reorganization, acquisition, the sale of all or a portion of our assets, or in the event of bankruptcy, information that we have collected from or about you may be disclosed to such other entities as part of the due diligence or business integration process and will be transferred to such entity as one of the transferred assets.*** For internationally based employees, the personal information disclosed will vary based on local labor laws.  Please contact your local human resources representative for country specifics.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Legal and Regulatory Requirements: To the extent required by relevant, applicable law or regulation, we may be obligated to disclose personal information to government authorities, or to third parties pursuant to a subpoena or other legal process.**  Such information may be disclosed to:\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Protect your or American’s legal claims and interests\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Defend against potential or actual litigation\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Abide by applicable law, regulation or contracts\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Respond to a court order, governmental administrative or judicial process, including but not limited to, a subpoena or search warrant\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '\u25AB',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Comply with American’s obligations where it is registered with any governmental agency\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "International Data Transfers",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'Please note that personal information submitted to us may be transferred to, stored and processed on servers located in various countries around the world, including when it is used as set out in this Privacy Policy by American in the United States of America, in accordance with applicable laws and regulations.\n\nThis may include transfers to American’s affiliates and to third parties with whom we share personal information, as described in this Privacy Policy.  The laws of those countries might not be equivalent to those in your country of residence, but please be assured that we take reasonable steps to protect your privacy, such as by implementing contractual controls such as American’s EU Standard Contractual Clauses which American has entered into with all of its branches located in the EU (a copy of which can be requested by contacting American at Privacy@aa.com) or seeking employee consent, where required by law.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Application of Local Laws",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'This Privacy Policy provides global principles, which set out the minimum data protection requirements that American will apply to employees’ personal information. American recognizes that local, national or regional laws and regulations in certain jurisdictions may require stricter legal standards than those described in this Privacy Policy.  American will process employee personal information in accordance with applicable local law in those cases. Please contact your local human resources representative for country specifics.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Voluntary or Mandatory Provision?",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'When collecting personal information from you, American will, where required by applicable law, inform you whether your provision of the requested information is voluntary or whether provision of it is mandatory and if so the consequences of not providing it. The provision of certain personal information is necessary for us to enter into an employment contract with you and/or for us to perform our obligations under that contract and without it we will be unable to do so, such as the provision of your bank details in order for us to pay you for your services via direct deposit.\n\nIf you choose not to provide certain information, this may impact your use of certain resources (e.g., if you refuse to provide information about your spouse, you may not be eligible for spousal coverage under employer-sponsored health insurance).\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Your Rights with Respect to Your Personal Information",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1.3),
            ),
          ),
          Container(
            child: Text(
              "Right to Object\n",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'If you are located in the European Union or Switzerland you have the right to object to our use of your personal data, on grounds relating to your particular situation, to the extent the processing is based on our legitimate interests.  If we receive an objection, then we will stop processing the personal data unless we demonstrate compelling legitimate grounds for the processing which override your interests, rights and freedoms or if the processing is necessary for the establishment, exercise or defense of legal claims.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            child: Text(
              "Additional Rights\n",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'If you are located in the European Union or Switzerland, you have the following rights under applicable data privacy laws (unless exemptions apply), which can be exercised by contacting your local employer or American using the details provided below.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
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
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request access to your personal information. This enables you to receive a copy of the personal information we hold about you and to check that we are lawfully processing it.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request correction of the personal information that we hold about you. This enables you to have any incomplete or inaccurate information we hold about you corrected.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request erasure of your personal information. This enables you to ask us to delete or remove personal information where there is no good reason for us continuing to process it. You also have the right to ask us to delete or remove your personal information where you have exercised your right to object to processing (see above).\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request the restriction of processing of your personal information. This enables you to ask us to suspend the processing of personal information about you, for example if you want us to establish its accuracy or the reason for processing it;\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Request the transfer of your personal information to another party; and\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                '\u25AA',
                style: TextStyle(
                    color: AaeColors.lightGray, fontSize: 16, height: 1.3),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The right to withdraw consent at any time where we have relied on it to process your personal data.\n',
                  style: TextStyle(
                      color: AaeColors.lightGray, fontSize: 16, height: 1.3),
                ),
              ),
            ],
          ),

          Container(
            child: Text(
              'Similar rights may exist under local data protection laws of other countries outside of the EU and the US. For further details please use the contact details below.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),

          Container(
            child: Text(
              "Contact Details\n",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'If you wish to exercise your rights, issue a request, or if you have other questions, comments or concerns about our privacy practices, please contact the Privacy Office at Privacy@aa.com.  Please provide your name and contact information along with the request. Alternatively, inquiries may be mailed to the following address:\n\nAmerican Airlines\nc/o Privacy Office\n1 Skyview Drive, MD 8B503\nFort Worth, Texas 76155\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            child: Text(
              "Data Protection Officer\n",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'American has assigned a data protection officer, Russell Hubbard, who is responsible for overseeing American’s compliance with EU data protection law, whom you may contact at Privacy@aa.com or via the postal address above in case of any questions or concerns regarding the processing of your personal data.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            child: Text(
              "EU Representative\n",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'American in the US has appointed the following representative in the EU:\n\nAmerican Airlines, Inc.Orient House (HAA3),\nPo Box 365, Waterside,\nHarmondsworth,\nUB7 0GB\nUnited Kingdom\nContact:  Lisa.Banks@aa.com\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            child: Text(
              "Complaints\n",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'If American’s processing of your personal data is covered by EU law or Swiss Law you may also contact or lodge a complaint with the corresponding data protection supervisory authority in your country of residence. You can find the relevant EU supervisory authority name and contact details under http://ec.europa.eu/justice/data-protection/bodies/authorities/index_en.htm.\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            child: Text(
              "Effective Date\n",
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1),
            ),
          ),
          Container(
            child: Text(
              'This Privacy Policy is effective on and was last reviewed in June 18, 2020.',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
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
                  colors: <Color>[AaeColors.blue, AaeColors.gradientTop])),
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
              "Terms and conditions\n\n",
              style: TextStyle(
                  color: AaeColors.darkGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
            child: Text(
              'Thank you for choosing American Airlines, Inc. Flight Status Notification text messaging service for your mobile device. Your use of the Service, as hereafter defined, constitutes your agreement to these terms and conditions. We may amend these terms, or modify or cancel the Service or any of its features without notice. Message and Data Rates may apply. Check with your mobile service provider for details on specific fees and charges that may apply for you. Click to view aa.com Privacy Policy. American Airlines offers its customers mobile access to flight information (e.g., for tracking flight status, gate, time, and baggage claim) over Short Message Service ("SMS") or SMS text messages (the "Service"). The Service will be ongoing but may be cancelled by us at any time. Customers may opt out of the Service at any time (see "To Stop the Service" below).\n',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
          Container(
            child: Text(
              'Questions and To Stop the Service:',
              style: TextStyle(
                  color: AaeColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              'If you have questions, please visit us via the options listed below.\n\nUnited States of America:\nWeb site - www.aa.com/FLYAA\nMobile Phone - (35922)\nTo get help, you can contact us at any time from your mobile phone by sending a text message with the word "HELP" to FLYAA (35922).\nTo Stop the Service: To stop the messages coming to your mobile phone, you can opt out of the Service via SMS. Just send a text message with the word "STOP" to FLYAA (35922). You will receive a one-time opt-out confirmation text message. After that, you will not receive any future messages.\n\nSpain or United Kingdom:\nMobile Phone - (447950080989)\nTo get help, you can contact us at any time from your mobile phone by sending a text message with the word "HELP" to (447950080989).\nTo Stop the Service: To stop the messages coming to your mobile phone, you can opt out of the Service via SMS. Just send a text message with the word "STOP" to (447950080989). You will receive a one-time opt-out confirmation text message. After that, you will not receive any future messages.\n\nAgreement to Terms & Conditions: Your use of the Service constitutes your agreement to these terms and conditions and to the aa.com Site Usage terms.\n\nYou agree to provide American Airlines with a valid mobile number. You agree that we may send you text messages through your wireless provider. We do not charge for the Service, but you are responsible for all charges and fees associated with text messaging imposed by your wireless provider.\n\nNotify us immediately of any changes to your registered device. In case of unauthorized access to your device or Service, you agree to cancel enrollment associated with such device immediately.\n\nYou agree to indemnify, defend, and hold harmless American Airlines and its affiliates from and against any and all third party claims, demands, proceedings, suits, actions, liabilities, obligations, losses,, damages, penalties, taxes, levies, fines, judgments, settlements or costs (collectively, "Claims") based on, arising or resulting from your use of the Service, including without limitation any Claims alleging facts that if true would constitute your breach of these terms, or from you providing us with a phone number that is not your own.\n\nYou agree that we will not be liable for failed, delayed, or misdirected delivery of, any information sent through the Service; any errors in such information; any action you may or may not take in reliance on the information of Service. AMERICAN AIRLINES WILL NOT UNDER ANY CIRCUMSTANCE BE LIABLE TO YOU FOR SPECIAL, INDIRECT, PUNITIVE, EXEMPLARY OR CONSQUENTIAL DAMAGES.\n\nOur participating carriers include, but are not limited to AT&T, Sprint, Verizon Wireless, U.S. Cellular®, T-Mobile® and MetroPCS®. The mobile carriers are not liable for delayed or undelivered messages.\n\nAny failure of American Airlines to assert any rights it may have hereunder does not constitute a waiver of its right to assert the same or any other right at any other time or against any other person or entity. If any provision of these terms and conditions is found to be invalid or unenforceable, then the invalid or unenforceable provision will be stricken without affecting the validity or enforceability of any other provision.',
              style: TextStyle(
                  color: AaeColors.lightGray, fontSize: 16, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
