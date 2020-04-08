import 'package:flutter_test/flutter_test.dart';

/// This is the unit test file for [Profile] creation, loading, and updating
void main() {
  setUpAll(() {});
  group('Profile creataion', () {
    // TODO (rpaglinawan): create a new [Profile] with test data and save in cache
    test('write to cache', () {});
  });
  group('Profile loading', () {
    // TODO (rpaglinawan): load a [Profile] from the cache read values
    test('read from cache', () {});
  });
  group('Profile updating', () {
    //TODO (rpaglinawan): update the [Profile] settings, write to cache then read from it
    group('update topics', () {
      // TODO (rpaglinawan): write topics change to cache
      test('write to cache', () {});
    });
    group('update workgroups', () {
      // TODO (rpaglinawan): write workgroups change to cache
      test('write to cache', () {});
    });

    group('read the values changed from cache', () {
      // TODO (rpaglinawan): read profile from cache
      test('validate topics', () {});
      test('validate workgroups', () {});
    });
  });
}
