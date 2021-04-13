import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

/// A basic card and section header to be used on the international details
/// screen. This widget will render the [title] as a blue header followed by
/// a floating card containing the [child].
class InternationalDetailsCard extends StatefulWidget {
  final String title;
  final Widget child;

  /// A blank card with external title text. Style matches the international
  /// check-in layout. No internal padding is provided out of the box. The
  /// [child] must have a key for animated layout changes to function.
  InternationalDetailsCard({this.title, this.child});

  /// A card containing a list of given widgets and external title text that
  /// matches the international check-in layout. Individual list items
  /// are separated by dividers.
  ///
  /// See also [InternationalDetailsReadOnlyTile], designed to work with
  /// this widget.
  InternationalDetailsCard.listLayout({title, List<Widget> children})
      : this(
          title: title,
          child: Padding(
            key: ValueKey<String>("listLayout"),
            padding: const EdgeInsets.symmetric(horizontal: AaeDimens.baseUnit / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // build dividers to separate our individual list items.
                ...ListTile.divideTiles(
                  color: AaeColors.halfwayLightGray,
                  tiles: children,
                ),
              ],
            ),
          ),
        );

  /// A card containing a widget and external title text that
  /// matches the international check-in layout. This implementation
  /// is designed to accommodate the edit layout of International Check-in.
  ///
  /// The [child] should normally be composed of [Row]s, [Column]s and
  /// a number of [InternationalDetailsEditableTile]s.
  InternationalDetailsCard.editLayout({title, child}) : this(
    title: title,
    child: Padding(
      key: ValueKey<String>("editLayout"),
      padding: const EdgeInsets.symmetric(
        horizontal: AaeDimens.baseUnit * (3/4),
        vertical: AaeDimens.baseUnit / 2,
      ),
      child: child,
    ),
  );

  @override
  _InternationalDetailsCardState createState() => _InternationalDetailsCardState();

  /// A layout builder for an AnimatedSwitcher that will allow for a simultaneous cross fade
  /// and resize when it is nested inside a AnimatedSize widget.
  static Widget clippedLayoutBuilder(Widget currentChild, List<Widget> previousChildren) {
    List<Widget> children = previousChildren;
    if (currentChild != null) {
      if (previousChildren.isEmpty)
        children = [currentChild];
      else {
        children = [
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Container(
              child: previousChildren[0],
            ),
          ),
          Container(
            child: currentChild,
          ),
        ];
      }
    }
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: children,
      alignment: Alignment.center,
    );
  }
}

class _InternationalDetailsCardState
    extends State<InternationalDetailsCard>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AaeDimens.baseUnit,
        left: AaeDimens.baseUnit / 2,
        right: AaeDimens.baseUnit / 2,
        bottom: AaeDimens.baseUnit / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AaeTextStyles.subtitle15BlueBold,
          ),
          Container(
            margin: const EdgeInsets.only(top: AaeDimens.baseUnit / 2),
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
            child: AnimatedSize(
              curve: Curves.easeInOut,
              vsync: this,
              duration: Duration(milliseconds: 500),
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                duration: Duration(milliseconds: 500),
                child: this.widget.child,
                layoutBuilder: InternationalDetailsCard.clippedLayoutBuilder,
              ),
            ),
          )
        ],
      ),
    );
  }
}
