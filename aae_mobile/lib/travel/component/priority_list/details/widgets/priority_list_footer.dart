import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

class PriorityListFooter extends StatelessWidget {

  final void Function() onUpButtonClicked;

  PriorityListFooter({@required this.onUpButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(7),
            margin: EdgeInsets.only(top: 20, bottom: 16, right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: InkWell(
              child: Icon(
                  AaeIconsv4.upArrow,
                  size: 24,
                  color: const Color(0xff9da6ab),
              ),
              onTap: onUpButtonClicked,
            ),
          ),
        ],
      ),
    );
  }
}
