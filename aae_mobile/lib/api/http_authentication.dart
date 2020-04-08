import 'dart:async';

/// Interface for token-based HTTP authentication.
abstract class HttpAuthentication {
  /// Retrieves the current, non-expired token or fetches a new one.
  Future<String> token();
}

/// An [HttpAuthentication] implementation for when you absolutely
/// don't care about authentication.
class NoAuth implements HttpAuthentication {
  final String _token;

  const NoAuth({String token}) : _token = token;

  DateTime get expiration => null;

  bool get isExpired => false;

  /// Returns a fauxken, a fake oauth token.
  Future<String> token() => Future.value(_token);
}
