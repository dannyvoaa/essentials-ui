import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/navigation/navigation_helper.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/service_provider.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'drawer_button.dart';

class AaeDrawer extends StatelessWidget {
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

    return Container(
      width: 300,
      color: AaeColors.white,
      child: ConstrainedBox(
        child: IntrinsicHeight(
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: AaeDimens.drawerHeight,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image(
                                image: AssetImage(
                                    'assets/common/american-airlines-eaagle-logo.png')),
                            decoration: BoxDecoration(
                              color: AaeColors.lightGray,
                              shape: BoxShape.circle,
                            ),
                            height: AaeDimens.baseUnit3x,
                            width: AaeDimens.baseUnit3x,
                          ),
                          Flexible(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Employee Name',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: AaeTextStyles.description(),
                                  ),
                                  Text(
                                    'Location',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: AaeTextStyles.description(),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              margin: EdgeInsets.only(
                                left: AaeDimens.baseUnit,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AaeDimens.drawerHeight,
                    ),
                    Container(
                      color: AaeColors.darkGray,
                      height: AaeDimens.sizeDivider,
                    ),
                    SizedBox(
                      height: AaeDimens.drawerHeight,
                    ),
                    DrawerButton(
                      stringTitle: 'Home',
                      onTapAction: () {},
                    ),
                    DrawerButton(
                      stringTitle: 'Neighborhood',
                      onTapAction: () {},
                    ),
                    DrawerButton(
                      stringTitle: 'Recognition',
                      onTapAction: () {},
                    ),
                    DrawerButton(
                      stringTitle: 'To Do',
                      onTapAction: () {},
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    Container(
                      color: AaeColors.darkGray,
                      height: AaeDimens.sizeDivider,
                    ),
                    DrawerButton(
                      stringTitle: 'Settings',
                      onTapAction: () {
                        navigateCommand(routes.buildSettingsPageRoute())(
                            context);
                      },
                    ),
                    DrawerButton(
                      stringTitle: 'Help',
                      onTapAction: () {},
                    ),
                    DrawerButton(
                      stringTitle: 'Log Out',
                      onTapAction: () async {
                        SharedPreferences _sharedPref =
                            await SharedPreferences.getInstance();
                        _sharedPref.clear();
                        ServiceProvider.serviceOf<AaeNavigator>(context)
                            .pushNamed(context, routes.buildSignInRoute(),
                                fromRoot: true);
                      },
                    ),
                  ],
                ),
              ],
            ),
            margin: edgeInsets,
          ),
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
