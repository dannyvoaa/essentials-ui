import 'package:aae/common/commands/aae_command.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

class AaeCard extends StatelessWidget {
  final String title;
  final String body;
  final String headingInformation;
  final String timeStamp;

  final String primaryActionTitle;
  final String secondaryActionTitle;

  final AaeContextCommand onPrimaryAction;
  final AaeContextCommand onSecondaryAction;

  AaeCard(
      {this.title,
      this.body,
      this.headingInformation = '',
      this.timeStamp,
      this.primaryActionTitle,
      this.secondaryActionTitle,
      this.onPrimaryAction,
      this.onSecondaryAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: AaeColors.white, boxShadow: [
          BoxShadow(
            color: Colors.black,
          ),
        ]),
        height: 125.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(timeStamp),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(title),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(body),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  FlatButton(
                    color: AaeColors.blue,
                    child: Text(
                      primaryActionTitle,
                      style: TextStyle(color: AaeColors.white),
                    ),
                    onPressed: () => onPrimaryAction(context),
                  ),
                  FlatButton(
                    child: Text(secondaryActionTitle),
                    onPressed: () => onSecondaryAction(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
