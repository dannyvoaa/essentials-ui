import 'package:aae/home/repository/news_feed_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mock/mock_repository.dart';

void main() {
  group('check if setup valid', () {
    MockAppInjector _appinjector;
    setUpAll(() async {
      _appinjector = MockAppInjector();
    });
    test('spin up mobile module', () {
      expect(_appinjector, isA<MockAppInjector>());
      expect(_appinjector, isNotNull);
    });

    test('spin up a module', () {
      final newsFeedRepo = NewsFeedRepository(
        _appinjector.apiClient(),
        _appinjector.cacheService(),
      );
      expect(newsFeedRepo, isA<NewsFeedRepository>());
      expect(newsFeedRepo, isNotNull);
    });
  });
}
