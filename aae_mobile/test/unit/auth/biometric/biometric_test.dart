import 'package:flutter_test/flutter_test.dart';
import 'package:platform/platform.dart';

import '../../../mock/mock_repository.dart';


void main() {
  FakePlatform mockPlatform;
  Platform targetPlatform;

  setUpAll((){

    targetPlatform = LocalPlatform();
    
  });

  test('validate setup', (){});
  group('cupertino bundle', (){
    test('', (){});
    testWidgets('trigger Cupertino biometric system', (WidgetTester tester) async {});
    test('', (){});
  });

  group('android bundle', (){
    test('', (){});
    testWidgets('trigger Mountain View biometric system', (WidgetTester tester) async {});
    test('', (){});
  });
}