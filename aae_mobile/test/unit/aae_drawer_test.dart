import 'package:aae/common/widgets/menu/page/aae_menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/app/mock_app_wrapper.dart';

void main() {
  AaeDrawer drawer;
  MockAppWraper testWidget;
  Scaffold testScaffold;

  setUpAll(() {
    drawer = AaeDrawer();
    testScaffold = Scaffold(
      body: Text('test'),
      drawer: drawer,
    );
    testWidget = MockAppWraper.scaffold(
      toTestScaffold: testScaffold,
    );
  });

  /// Runs first check to make sure there are non-null values
  group('check setup scheme is valid', () {
    test('validate build', () {
      expect(testWidget, isNotNull);
    });

    // Validates that a widget with a scaffold exists in memory
    testWidgets('validate widget test', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.text('test'), findsOneWidget);
    });

    test('check for values in menu', () {
      // TODO: Parse the widget to find children
    });
  });
}
