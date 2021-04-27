import 'package:flutter/material.dart';
import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';

class TravelSnackBar extends StatefulWidget {
  TravelSnackBar(
      {this.context, this.label, this.color, this.shouldPop, Key key})
      : super(key: key);
  final BuildContext context;

  final String label;
  final Color color;
  final bool shouldPop;

  @override
  State<StatefulWidget> createState() => TravelSnackBarState();

  showSnackBar(
      BuildContext context, String label, Color color, bool shouldPop) {
    OverlayEntry entry;
    entry = OverlayEntry(builder: (BuildContext context) {
      return TravelSnackBar(
          context: context, label: label, color: color, shouldPop: shouldPop);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).overlay.insert(entry);
      Future.delayed(Duration(seconds: 3), () {
        entry.remove();
      });
    });
  }
}

class TravelSnackBarState extends State<TravelSnackBar>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> position;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    position = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldPop) {
      Navigator.maybePop(context, '/');
    }
    return Positioned(
        width: MediaQuery.of(context).size.width,
        height: 65,
        child: Dismissible(
          key: ValueKey('SnackBarKey'),
          child: SafeArea(
            child: Material(
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: SlideTransition(
                    position: position,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: widget.color,
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            child: Text(
                          widget.label,
                          textAlign: TextAlign.center,
                          style: AaeTextStyles.btn18,
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
