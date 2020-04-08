import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

const _headerBottomPadding = AaeDimens.baseUnit3_4x;

/// A section header with a label and optional action in a row.
class SectionHeader extends StatelessWidget {
  @visibleForTesting
  static const titleKey = Key('title');
  @visibleForTesting
  static const actionKey = Key('action');

  /// The title text to display in this header.
  ///
  /// Aligned to the start of this row and expands to fill empty space.
  final String title;

  /// The action text to display in this header.
  ///
  /// Aligned to the end of this row.
  final String action;

  /// The callback to invoke when the [action] button is tapped.
  final GestureTapCallback onActionTapped;

  SectionHeader({
    @required this.title,
    this.action,
    this.onActionTapped,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Expanded(
        key: titleKey,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            height: 1.33,
            fontWeight: FontWeight.w500,
            fontFamily: 'AmericanSans',
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];

    if (action != null) {
      children.add(
        GestureDetector(
          key: actionKey,
          child: Text(
            action,
            style: TextStyle(
              fontSize: 16.0,
              height: 1.50,
              fontWeight: FontWeight.w500,
              fontFamily: 'AmericanSans',
            ),
          ),
          onTap: onActionTapped,
        ),
      );
    }

    return Padding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: children,
      ),
      padding: EdgeInsets.only(bottom: _headerBottomPadding),
    );
  }
}
