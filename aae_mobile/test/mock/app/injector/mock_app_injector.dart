import 'package:aae/inject/mobile_module.dart';
import 'package:mockito/mockito.dart';

class MockAppInjector extends Mock implements AppInjector {
  static final create = AppInjector.create(MobileModule());
}
