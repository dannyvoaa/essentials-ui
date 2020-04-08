/// Encapsulation of the fields that represent a American Airlines user's identity.

class SSOIdentity {
  /// The user's display name (e.g., full name).
  ///
  /// This may be null if unavailable.
  String displayName = "Allen Iverson";

  /// The email address of the signed in user.
  /// we should not key users by email address since an
  ///  account's email address can change. Use [id] as a key instead.
  String email = 'AI@AA.com';

  /// The unique ID for the American Airlines User record
  String id = '8675309';
}
