import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';

/// [MockAppWrapper] is designed and built to be solely for testing components
/// and their behavior in app

class MockAppWraper extends StatefulWidget {
  @nullable
  Scaffold toTestScaffold;

  @nullable
  Widget toTestWidget;
  BuildContext context;

  MockAppWraper({this.toTestWidget});

  MockAppWraper.scaffold({this.toTestScaffold});

  @override
  State<StatefulWidget> createState() => _MockAppWrapper();

  void triggerDrawer() {
    toTestScaffold?.createState().hasEndDrawer &&
            !(toTestScaffold.createState().isDrawerOpen ||
                toTestScaffold.createState().isEndDrawerOpen)
        ? toTestScaffold.createState().openEndDrawer()
        : () => debugPrint('No known End Drawer exists');
    toTestScaffold?.createState().hasDrawer &&
            !(toTestScaffold.createState().isDrawerOpen ||
                toTestScaffold.createState().isEndDrawerOpen)
        ? toTestScaffold.createState().openDrawer()
        : () => debugPrint('No known Drawer exists');
  }

  void debugDumpTree() {
    context.visitChildElements(
        (element) => debugPrint('element in stack: $element'));
  }
}

class _MockAppWrapper extends State<MockAppWraper> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, _) {
          widget.context = context;
          return widget.toTestScaffold != null
              ? widget.toTestScaffold
              : widget.toTestWidget;
        },
      );
}
