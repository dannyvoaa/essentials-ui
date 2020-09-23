import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

/// A app bar for the news feed page.
class TravelListTile<T> extends StatelessWidget {
  TravelListTile({this.buttonContent});

  final Widget buttonContent;

  @override
  Widget build(BuildContext context) {
    return _buildTravelListTile(context);
  }

  _buildTravelListTile(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            bottom: AaeDimens.smallCardVerticalContentPadding),
        child: Container(
          child: ListTile(
            title: buttonContent,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29131313),
                offset: Offset(0, 2),
                blurRadius: 3,
              ),
            ],
          ),
        ));
  }
}
