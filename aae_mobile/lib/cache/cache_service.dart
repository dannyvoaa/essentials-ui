import 'package:inject/inject.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/core.dart';
import 'dart:async';
import 'dart:convert';

/// A service for reading and writing to a persistent cache.
class CacheService {
  static final _log = Logger('CacheService');

  final SharedPreferences _sharedPreferences;

  @provide
  @singleton
  CacheService(this._sharedPreferences);

  /// Clears all user data for the app.
  Future<void> clear() {
    return _sharedPreferences.clear();
  }

  /// Writes a [bool] with the specified [key].
  ///
  /// Throws a [CacheError] if the write fails for any reason.
  Future<void> writeBool(String key, bool value) async {
    bool result;
    try {
      result = await _sharedPreferences.setBool(key, value);
    } catch (e, s) {
      final message = _formatWriteBoolErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }

    if (!result) {
      throw CacheError(
        _formatWriteBoolErrorMessage(
          key: key,
          reason: 'platform returned false',
        ),
      );
    }
  }

  /// Reads a [bool] stored with the specified [key].
  ///
  /// Returns an empty [Optional] if no [bool] is stored for [key].
  ///
  /// Throws a [CacheError] if the read fails for any reason.
  Optional<bool> readBool(String key) {
    try {
      final value = _sharedPreferences.getBool(key);
      return Optional.fromNullable(value);
    } catch (e, s) {
      final message = _formatReadErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }
  }

  /// Writes a [int] with the specified [key].
  ///
  /// Throws a [CacheError] if the write fails for any reason.
  Future<void> writeInt(String key, int value) async {
    bool result;
    try {
      result = await _sharedPreferences.setInt(key, value);
    } catch (e, s) {
      final message = _formatWriteIntErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }

    if (!result) {
      throw CacheError(
        _formatWriteIntErrorMessage(
          key: key,
          reason: 'platform returned false',
        ),
      );
    }
  }

  /// Reads a [int] stored with the specified [key].
  ///
  /// Returns an empty [Optional] if no [int] is stored for [key].
  ///
  /// Throws a [CacheError] if the read fails for any reason.
  Optional<int> readInt(String key) {
    try {
      final value = _sharedPreferences.getInt(key);
      return Optional.fromNullable(value);
    } catch (e, s) {
      final message = _formatReadErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }
  }

  /// Writes a [String] with the specified [key].
  ///
  /// Throws a [CacheError] if the write fails for any reason.
  Future<void> writeString(String key, String value) async {
    bool result;
    try {
      result = await _sharedPreferences.setString(key, value);
    } catch (e, s) {
      final message = _formatWriteStringErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }

    if (!result) {
      throw CacheError(
        _formatWriteStringErrorMessage(
          key: key,
          reason: 'platform returned false',
        ),
      );
    }
  }

  /// Reads a [String] stored with the specified [key].
  ///
  /// Returns an empty [Optional] if no [String] is stored for [key].
  ///
  /// Throws a [CacheError] if the read fails for any reason.
  Optional<String> readString(String key) {
    try {
      final value = _sharedPreferences.getString(key);
      return Optional.fromNullable(value);
    } catch (e, s) {
      final message = _formatReadErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }
  }

  /// Writes [bytes] with the specified [key].
  ///
  /// Throws a [CacheError] if the write fails for any reason.
  Future<void> writeBytes(String key, List<int> bytes) async {
    final encoded = base64Encode(bytes);

    bool result;
    try {
      result = await _sharedPreferences.setString(key, encoded);
    } catch (e, s) {
      final message = _formatWriteBytesErrorMessage(
        key: key,
        bytes: bytes,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }

    if (!result) {
      throw CacheError(
        _formatWriteBytesErrorMessage(
          key: key,
          bytes: bytes,
          reason: 'platform returned false',
        ),
      );
    }
  }

  /// Reads bytes stored with the specified [key].
  ///
  /// Returns an empty [Optional] if no bytes are stored for [key].
  ///
  /// Throws a [CacheError] if the read fails for any reason.
  Optional<List<int>> readBytes(String key) {
    try {
      final encoded = _sharedPreferences.getString(key);
      return Optional.fromNullable(encoded).transform(base64Decode);
    } catch (e, s) {
      final message = _formatReadErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }
  }

  /// Writes a list of bytes with the specified [key].
  ///
  /// Throws a [CacheError] if the write fails for any reason.
  Future<void> writeBytesList(String key, Iterable<List<int>> bytesList) async {
    final encoded = bytesList.map(base64Encode).toList();

    bool result;
    try {
      result = await _sharedPreferences.setStringList(key, encoded);
    } catch (e, s) {
      final message = _formatWriteListErrorMessage(
        key: key,
        bytesList: bytesList,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }

    if (!result) {
      throw CacheError(
        _formatWriteListErrorMessage(
          key: key,
          bytesList: bytesList,
          reason: 'platform returned false',
        ),
      );
    }
  }

  /// Reads a list of bytes store with the specified [key].
  ///
  /// Returns an empty [Optional] if no bytes are stored for [key].
  ///
  /// Throws a [CacheError] if the read fails for any reason.
  Optional<List<List<int>>> readBytesList(String key) {
    try {
      final encoded = _sharedPreferences.getStringList(key);
      return Optional.fromNullable(encoded)
          .transform((list) => list.map(base64Decode).toList());
    } catch (e, s) {
      final message = _formatReadErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }
  }

  /// Removes the entry stored with the specified [key].
  ///
  /// Throws a [CacheError] if the remove fails for any reason.
  Future<void> remove(String key) async {
    bool result;
    try {
      result = await _sharedPreferences.remove(key);
    } catch (e, s) {
      final message = _formatRemoveErrorMessage(
        key: key,
        reason: 'platform threw an instance of ${e.runtimeType}',
      );
      _log.shout(message, e, s);
      throw CacheError(message);
    }

    if (!result) {
      throw CacheError(
        _formatRemoveErrorMessage(
          key: key,
          reason: 'platform returned false',
        ),
      );
    }
  }

  static String _formatWriteBoolErrorMessage({
    String key,
    String reason,
  }) =>
      'Failed to write bool for $key: $reason';

  static String _formatWriteIntErrorMessage({
    String key,
    String reason,
  }) =>
      'Failed to write int for $key: $reason';

  static String _formatWriteStringErrorMessage({
    String key,
    String reason,
  }) =>
      'Failed to write String for $key: $reason';

  static String _formatWriteBytesErrorMessage({
    String key,
    List<int> bytes,
    String reason,
  }) =>
      'Failed to write ${bytes.length} bytes for $key: $reason';

  static String _formatWriteListErrorMessage({
    String key,
    Iterable<List<int>> bytesList,
    String reason,
  }) =>
      'Failed to write ${_totalBytes(bytesList)} bytes for $key: $reason';

  static String _formatReadErrorMessage({
    String key,
    String reason,
  }) =>
      'Failed to read key $key: $reason';

  static String _formatRemoveErrorMessage({
    String key,
    String reason,
  }) =>
      'Failed to remove key $key: $reason';

  static int _totalBytes(Iterable<List<int>> bytesList) =>
      bytesList.fold(0, (accumulator, bytes) => bytes.length + accumulator);
}

/// An error that represents some failure while reading or writing to the
/// persistent cache.
class CacheError extends Error {
  final String message;

  CacheError(this.message);
}
