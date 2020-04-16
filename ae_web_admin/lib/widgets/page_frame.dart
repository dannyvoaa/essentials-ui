import 'dart:async';
import 'package:american_essentials_web_admin/common/alerts.dart';
import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/images.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/views/calendar/calendar_view.dart';
import 'package:american_essentials_web_admin/views/home_view.dart';
import 'package:american_essentials_web_admin/views/locations/locations_view.dart';
import 'package:american_essentials_web_admin/views/notifications/notifications_view.dart';
import 'package:american_essentials_web_admin/views/startup.dart';
import 'package:american_essentials_web_admin/views/topics/topics_view.dart';
import 'package:american_essentials_web_admin/views/users/users_view.dart';
import 'package:american_essentials_web_admin/views/workgroups/workgroups_view.dart';
import 'package:american_essentials_web_admin/widgets/general/page_header.dart';
import 'package:flutter/material.dart';

class PageFrame extends StatefulWidget {
  @override
  _PageFrameState createState() => _PageFrameState();

  // Setup any required variables
  final bool boolBodyBottomPadding;
  final bool boolBodyTopPadding;
  final String stringHeaderTitle;
  final Widget widgetBody;
  final Widget widgetHeaderActions;

  // Initialize the view
  PageFrame({
    this.boolBodyBottomPadding = true,
    this.boolBodyTopPadding = true,
    this.stringHeaderTitle,
    @required this.widgetBody,
    this.widgetHeaderActions,
  });
}

class _PageFrameState extends State<PageFrame> {
  // Setup any required variables
  LocalStorage _localStorage = LocalStorage();
  Timer timerLogOut;
  Timer timerWarning;

  @override
  void initState() {
    super.initState();

    // Initialize local storage
    _localStorage.initialize().then((value) {
      // Retreive the session expiration epoch
      int intEpochExpiration =
          _localStorage.sharedPreferences.getInt('auth.expiration');
      int intEpochNow =
          DateUtilities.secondsSinceEpoch(dateTime: DateTime.now().toUtc());

      // Calculate how long (in seconds) until the session expires and the session expiration warning occurs
      int intSecondsUntilExpiration = intEpochExpiration - intEpochNow;
      int intSecondsUntilWarning = intSecondsUntilExpiration - (2 * 60);

      print('Session will expire in $intSecondsUntilExpiration seconds');
      print('Session expiration warning will display in $intSecondsUntilExpiration seconds');

      // Check to see if the user's session token is still valid
      if (intSecondsUntilExpiration > 0) {
        // The session is still active

        // Setup the timer to warn the user prior to the session's expiration
        timerWarning =
            Timer(Duration(seconds: intSecondsUntilWarning), () async {
          // Alert: Session expiration warning
          var dialogResult = await Alerts.sessionExpiration(
            buildContext: this.context,
          );

          // Check to see what action was selected
          if (dialogResult.toString().toLowerCase() == 'log out') {
            // Log the user out
            this._logOut(buildContext: this.context);
          }
        });

        // Setup a timer to log the user out
        timerLogOut = Timer(Duration(seconds: intSecondsUntilExpiration), () {
          // Log the user out
          this._logOut(buildContext: this.context);
        });
      } else {
        // The session is no longer active; log the user out
        this._logOut(buildContext: this.context);
      }

      // Update the application's state
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Cancel the timers, otherwise they might attempt to fire after the page has been disposed of (don't ask me how as this shouldn't be possible) which will crash the app since this.context will now be nil
    timerLogOut.cancel();
    timerWarning.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: <Widget>[
            this._header(),
            this._bodyHeader(),
            this._body(),
            this._footer(),
          ],
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
      ),
    );
  }

  // MARK: - Views

  /// The body for the page
  Widget _body() {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: widget.widgetBody,
          padding: EdgeInsets.only(
            top: widget.boolBodyTopPadding ? Dimensions.size16px : 0,
            bottom: widget.boolBodyBottomPadding ? Dimensions.size16px : 0,
          ),
        ),
        padding: EdgeInsets.only(
          left: Dimensions.safeArea(buildContext: this.context).left +
              Dimensions.size16px,
          right: Dimensions.safeArea(buildContext: this.context).right +
              Dimensions.size16px,
        ),
        width: double.infinity,
      ),
    );
  }

  /// The header shown above the page body
  Widget _bodyHeader() {
    return widget.stringHeaderTitle != null
        ? Container(
            child: PageHeader(
              stringTitle: widget.stringHeaderTitle,
              widgetActions: widget.widgetHeaderActions,
            ),
            padding: EdgeInsets.only(
              left: Dimensions.safeArea(buildContext: this.context).left +
                  Dimensions.size16px,
              top: Dimensions.size16px,
              right: Dimensions.safeArea(buildContext: this.context).right +
                  Dimensions.size16px,
            ),
            width: double.infinity,
          )
        : Container();
  }

  /// The footer for the page
  Widget _footer() {
    return Container(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            _localStorage.sharedPreferences != null
                ? Text('Logged In')
                : Text('You shouldn\'t be here...'),
          ],
        ),
        height: Dimensions.size32px,
      ),
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: CustomColors.separator,
              width: Dimensions.sizeDivider,
            ),
          ),
          color: CustomColors.footer),
      padding: EdgeInsets.only(
        left: Dimensions.safeArea(buildContext: this.context).left +
            Dimensions.size16px,
        right: Dimensions.safeArea(buildContext: this.context).right +
            Dimensions.size16px,
        bottom: Dimensions.safeArea(buildContext: this.context).bottom,
      ),
      width: double.infinity,
    );
  }

  /// The header for the page
  Widget _header() {
    return Container(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Material(
              child: InkWell(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    alignment: Alignment.center,
                    child: Image(
                      image: Images.imageFlightSymbol,
                    ),
                    padding: EdgeInsets.all(
                      Dimensions.size16px,
                    ),
                  ),
                ),
                highlightColor: CustomColors.transparent,
                onTap: () {
                  // Push to a new view with the fade animation
                  Transitions.pushReplacementWithFade(
                    buildContext: this.context,
                    stringRouteId: HomeView.routeId,
                  );
                },
              ),
              color: CustomColors.transparent,
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    this._headerButton(
                      stringTitle: 'Calendar',
                      onTapAction: () {
                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: this.context,
                          stringRouteId: CalendarView.routeId,
                        );
                      },
                    ),
                    this._headerButton(
                      stringTitle: 'Locations',
                      boolRightBorder: true,
                      onTapAction: () {
                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: this.context,
                          stringRouteId: LocationsView.routeId,
                        );
                      },
                    ),
                    this._headerButton(
                      stringTitle: 'Notifications',
                      boolRightBorder: true,
                      onTapAction: () {
                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: this.context,
                          stringRouteId: NotificationsView.routeId,
                        );
                      },
                    ),
                    this._headerButton(
                      stringTitle: 'Topics',
                      boolRightBorder: true,
                      onTapAction: () {
                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: this.context,
                          stringRouteId: TopicsView.routeId,
                        );
                      },
                    ),
                    this._headerButton(
                      stringTitle: 'Users',
                      boolRightBorder: true,
                      onTapAction: () {
                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: this.context,
                          stringRouteId: UsersView.routeId,
                        );
                      },
                    ),
                    this._headerButton(
                      stringTitle: 'Workgroups',
                      boolRightBorder: true,
                      onTapAction: () {
                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: this.context,
                          stringRouteId: WorkgroupsView.routeId,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                child: PopupMenuButton(
                  shape: Border(
                    left: BorderSide(
                      color: CustomColors.separator,
                      width: 1.0,
                    ),
                    right: BorderSide(
                      color: CustomColors.separator,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: CustomColors.separator,
                      width: 1.0,
                    ),
                  ),
                  elevation: 0,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: BrandColors.white,
                  ),
                  itemBuilder: (BuildContext buildContext) {
                    // Create an array of popup menu entries
                    List<PopupMenuEntry> _listPopupMenu =
                        List<PopupMenuEntry>();

                    // Add a button to the menu
                    _listPopupMenu.add(
                      PopupMenuItem(
                        child: Text('Log Out'),
                        value: 'logout',
                      ),
                    );

                    return _listPopupMenu;
                  },
                  offset: Offset(0, Dimensions.size64px),
                  onSelected: (var selected) {
                    // Check to see which item was selected
                    if (selected == 'logout') {
                      // Log the user out
                      this._logOut(buildContext: this.context);
                    }
                  },
                ),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: BrandColors.white,
                        width: Dimensions.sizeDivider),
                  ),
                ),
              ),
            ),
          ],
        ),
        height: Dimensions.size64px,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.separator,
            width: Dimensions.sizeDivider,
          ),
        ),
        color: BrandColors.blue,
      ),
      padding: EdgeInsets.only(
        left: Dimensions.safeArea(buildContext: this.context).left +
            Dimensions.size16px,
        top: Dimensions.safeArea(buildContext: this.context).top,
        right: Dimensions.safeArea(buildContext: this.context).right +
            Dimensions.size16px,
      ),
      width: double.infinity,
    );
  }

  // MARK: - General Functions

  /// Log the user out
  void _logOut({
    @required BuildContext buildContext,
  }) async {
    // Clear the local storage
    await _localStorage.sharedPreferences.clear();

    // Push to a new view with the fade animation
    Transitions.pushReplacementWithFade(
      buildContext: buildContext,
      stringRouteId: Startup.routeId,
    );
  }

  // MARK: - Widgets

  /// Creates a button that is used in the frame's header
  Widget _headerButton({
    @required String stringTitle,
    bool boolRightBorder = false,
    @required Function() onTapAction,
  }) {
    return Material(
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            stringTitle,
            style: TextStyles.bodyLarge(
              colorVariant: ColorVariant.Light,
            ),
          ),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: BrandColors.white.withOpacity(0.5),
                width: Dimensions.sizeDivider,
              ),
              right: BorderSide(
                color: boolRightBorder
                    ? BrandColors.white.withOpacity(0.5)
                    : CustomColors.transparent,
                width: Dimensions.sizeDivider,
              ),
            ),
          ),
          height: double.infinity,
          padding: EdgeInsets.only(
            left: Dimensions.size16px,
            right: Dimensions.size16px,
          ),
          width: Dimensions.size128px,
        ),
        highlightColor: CustomColors.transparent,
        onTap: onTapAction,
      ),
      color: CustomColors.transparent,
    );
  }
}
