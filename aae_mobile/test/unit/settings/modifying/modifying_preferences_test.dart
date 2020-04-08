import 'package:aae/settings/modify/bloc/modify_preference_bloc.dart';
import 'package:aae/settings/page/component/preference_section/preference_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../mock/mock_repository.dart';

void main() {
  MockModifyPreferenceBloc preferenceBloc;
  MockAppWraper testAppWraper;
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    preferenceBloc = MockModifyPreferenceBloc();
    testAppWraper = MockAppWraper(
      toTestWidget: PreferenceComponent(),
    );
  });

  test('validate setup', () {
    expect(preferenceBloc, isA<ModifyPreferenceBloc>());
  });
  group('AA server settings', () {
    PreferenceComponent preferenceComponent;
    setUp(() {
      preferenceComponent = testAppWraper.toTestWidget;
    });
    test('validate view model', () {
      expect(testAppWraper.toTestWidget, isA<PreferenceComponent>());
      expect(preferenceComponent, isNotNull);
    });
    test('load from device cache', () async {
      //TODO (rpaglinwawn) load data into view model
    });
    test('modify AA server settings', () {
      //TODO (rpaglinawan) change value of a settings option
    });
    test('save AA server settings', () {});
    //TODO (rpaglinawan) test cache until network is reachable function
  });
}
