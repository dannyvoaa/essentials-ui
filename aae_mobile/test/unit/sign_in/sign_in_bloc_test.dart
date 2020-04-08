import 'package:aae/sign_in/workflow/sign_in_workflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/mock_repository.dart';

void main() {
  MockAppWraper testAppWrapper;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    testAppWrapper = MockAppWraper(
      toTestWidget: SignInWorkflow(),
    );
  });

  group('validate setup', () {
    test('check if values are present', () {
      expect(testAppWrapper.toTestWidget, isNotNull);
    });
  });

  group('modify bloc', () {
    test('description', () {});
  });
}
