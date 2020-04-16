import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // Setup any required variables
  SharedPreferences sharedPreferences;

  /// Initialize local storage and retreive the shared preferences
  Future<void> initialize() async {
    // Retreive the shared preferences
    sharedPreferences = await SharedPreferences.getInstance();
  }
}