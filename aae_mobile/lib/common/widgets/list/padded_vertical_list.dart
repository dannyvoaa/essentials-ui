import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

/// A padded list of items displayed in a column.
///
/// [padding] is added to each item in [children] except the last. Does not
/// scroll. If placed in a [ListView] with other elements, will scroll along
/// with those elements.
///
/// Example of a [Dropdown] and a [PaddedVerticalList] that scroll together:
/// ListView(
///   children: <Widget>[
///     Dropdown(...),
///     PaddedVerticalList(children: ...),
///   ],
/// );
class PaddedVerticalList extends StatelessWidget {
  /// The padding to apply between children.
  final double padding;

  /// The children to render in a column.
  final List<Widget> children;

  PaddedVerticalList({
    @required this.children,
    this.padding = AaeDimens.baseUnit3_4x,
  });

  @override
  Widget build(BuildContext context) {
    final columnChildren = <Widget>[];

    if (children.isNotEmpty) {
      // Add padding to all but the last element.
      columnChildren.addAll(
        children.takeWhile((child) => child != children.last).map(
              (child) => Padding(
                padding: EdgeInsets.only(bottom: padding),
                child: child,
              ),
            ),
      );

      columnChildren.add(children.last);
    }

    return Column(
      children: columnChildren,
    );
  }
}
