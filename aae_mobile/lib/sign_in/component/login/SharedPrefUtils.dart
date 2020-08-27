
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {

  static saveStr(String key, String message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  static readPrefStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static getKeyValue(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("tokenvalue");
    if (token == null) return "";
    final parts = token.split('.');
    if (parts.length != 3) {
      return "";
    }
    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var jwt = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(jwt);
    if (payloadMap is! Map<String, dynamic>) {
      return "";
    }
    return payloadMap[key];
  }
}