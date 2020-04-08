import 'package:aae/common/commands/aae_command.dart';
import 'package:aae/common/widgets/button/aee_button.dart';
import 'package:flutter/material.dart';

class AaeDrawerComponent extends StatelessWidget {
  final String menuTitle;
  final AaeCommand onPressedMenuSetting;

  AaeDrawerComponent({this.menuTitle, this.onPressedMenuSetting});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AaeButton.primaryRegular(
        text: menuTitle,
        onTapped: onPressedMenuSetting,
      ),
    );
  }
}
