import '../permissions/app_permissisons.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';

part 'app_preferences_listener.g.dart';

abstract class AppPreferencesListener
    implements Built<AppPreferencesListener, AppPreferencesListenerBuilder> {
  Listenable get preferenceListener;
  AaePermissions get userPermission;

  AppPreferencesListener._();

  factory AppPreferencesListener([updates(AppPreferencesListenerBuilder b)]) =
      _$AppPreferencesListener;
}
