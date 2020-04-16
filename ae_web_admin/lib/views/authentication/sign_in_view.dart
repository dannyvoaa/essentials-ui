import 'package:american_essentials_web_admin/api/api_sign_in.dart';
import 'package:american_essentials_web_admin/common/alerts.dart';
import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/images.dart';
import 'package:american_essentials_web_admin/views/home_view.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/processing.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  static String routeId = 'SignInView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  SignInView({this.payload});

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // Setup any required variables
  LocalStorage _localStorage = LocalStorage();
  String _stringUsername = '';
  String _stringPassword = '';

  @override
  void initState() {
    super.initState();

    // Initialize local storage
    _localStorage.initialize().then((value) {
      // Update the application's state
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Material(
          child: Container(
            child: Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Hero(
                      child: Image(
                        image: Images.imageFlightSymbol,
                        height: Dimensions.size128px,
                      ),
                      tag: 'flightSymbol',
                    ),
                    SizedBox(
                      height: Dimensions.size64px,
                    ),
                    TextField(
                      controller: TextEditingController(text: _stringUsername),
                      decoration: InputDecoration(
                        labelText: 'AA ID',
                      ),
                      onChanged: (String string) {
                        // Save the entered value to a local variables
                        _stringUsername = string;
                      },
                    ),
                    SizedBox(
                      height: Dimensions.size16px,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onChanged: (String string) {
                        // Save the entered value to a local variables
                        _stringPassword = string;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: Dimensions.size16px,
                    ),
                    RoundedButton(
                      child: Text('Sign In'),
                      onPressed: () async {
                        // Show the Processing view
                        Processing.showProcessingView(buildContext: context);

                        // Attempt to authenticate the user
                        this._processSignIn();
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                width: Dimensions.size256px,
              ),
            ),
          ),
        ),
      ),
      color: BrandColors.white,
    );
  }

  // MARK: - General Functions

  void _processSignIn() async {
    // API: Attempt to sign the user in
    ApiSignInResult apiSignInResult = await ApiSignIn.sendRequest(
        stringUsername: _stringUsername, stringPassword: _stringPassword);

    // Hide the processing view
    Processing.dismiss(buildContext: context);

    // Check to see what result was returned from the API
    if (apiSignInResult.status == ApiSignInStatus.Success) {
      // Save the authentication data to local storage
      _localStorage.sharedPreferences.setBool('auth.loggedIn', true);
      _localStorage.sharedPreferences
          .setInt('auth.expiration', DateUtilities.secondsSinceEpoch(dateTime: apiSignInResult.expiration));
      _localStorage.sharedPreferences
          .setString('auth.token', apiSignInResult.accessToken);
      _localStorage.sharedPreferences
          .setString('auth.username', _stringUsername);

      // Push to a new view with the fade animation
      Transitions.pushReplacementWithFade(
        buildContext: context,
        stringRouteId: HomeView.routeId,
      );
    } else if (apiSignInResult.status ==
        ApiSignInStatus.InvalidUsernamePassword) {
      // Alert: Bad username or password
      await Alerts.generic(
          buildContext: context,
          stringTitle: 'Authentication Error',
          stringMessage:
              'We were unable to sign you in. Please check your username and password and try again.');
    } else {
      // Alert: Unknown error
      await Alerts.generic(
          buildContext: context,
          stringTitle: 'Authentication Error',
          stringMessage:
              'An unknown error occured during the sign in process. Please try again later.');
    }
  }
}
