/// [AccessType] is a static enum that represents values for permissions
/// the user will grant
enum AccessType {
  full,
  limited,
  no_access,
}

typedef Map<String, AccessType> AaePermissions(String key, AccessType value);
