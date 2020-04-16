import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/images.dart';
import 'package:american_essentials_web_admin/views/authentication/sign_in_view.dart';
import 'package:american_essentials_web_admin/views/home_view.dart';
import 'package:flutter/material.dart';

class Startup extends StatelessWidget {
  static String routeId = 'Startup';

  @override
  Widget build(BuildContext context) {
    // Delay execution so that the splash screen stays visible for a specified amount of time
    Future.delayed(Duration(milliseconds: 500), () async {
      // Initialize local storage
      LocalStorage _localStorage = LocalStorage();
      await _localStorage.initialize().then((value) {
        // Setup access to the current date
        DateTime _dateTime = DateTime.now();

        // Set the initial calendar filters
        // - A similar function exists in calendar_filters_view.dart:145
        _localStorage.sharedPreferences.setString('calendar.filters.dateFrom', DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day, 00, 00).toUtc().toIso8601String());
        _localStorage.sharedPreferences.setString('calendar.filters.dateTo', DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day, 23, 59).toUtc().add(Duration(days: 7)).toIso8601String());
        // - A similar function exists in users_filters_view.dart:72
        _localStorage.sharedPreferences.setString('users.filters.aaId', '');
      });

      // Retreive the session expiration epoch and calculate the number of seconds until session expiration
      int intEpochExpiration =
          (_localStorage.sharedPreferences.getInt('auth.expiration') ?? 0);
      int intEpochNow =
          DateUtilities.secondsSinceEpoch(dateTime: DateTime.now().toUtc());
      int intSecondsUntilExpiration = intEpochExpiration - intEpochNow;
      
      // Retreive the logged in state of the user
      bool _boolLoggedIn =
          _localStorage.sharedPreferences.getBool('auth.loggedIn') ?? false;

      // Check to see if the user is logged in and that their session is still active
      if (_boolLoggedIn && intSecondsUntilExpiration > 0) {
        // Push to a new view with the fade animation
        Transitions.pushReplacementWithFade(
          buildContext: context,
          stringRouteId: HomeView.routeId,
          payload: null,
        );
      } else {
        // Push to a new view with the fade animation
        Transitions.pushReplacementWithFade(
          buildContext: context,
          stringRouteId: SignInView.routeId,
          payload: null,
        );
      }
    });

    return Material(
      child: SafeArea(
        child: Container(
          child: Center(
            child: Hero(
              child: Image(
                image: Images.imageFlightSymbol,
                height: Dimensions.size128px,
              ),
              tag: 'flightSymbol',
            ),
          ),
          color: BrandColors.white,
        ),
      ),
      color: BrandColors.white,
    );
  }
}
