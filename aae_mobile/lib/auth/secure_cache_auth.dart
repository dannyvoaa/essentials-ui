import 'dart:io';

import 'package:inject/inject.dart';
import 'package:aae/model/auth_credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

class SecureCacheAuth {
  final FlutterSecureStorage _secureStorage;

  static final _log = Logger('SecureCacheAuth');

  @provide
  @singleton
  SecureCacheAuth(this._secureStorage);

  // MARK: (rpaglinawan): based on the discussion with kishe we need this for one auth flow but need to consider for onResume states

  // TODO (rpaglinawan): Implement encrypt and decrypt of:
  // ° aaID
  // ° password

  Future<void> writeCredentials(
      {@required AuthCredentials authorizedUser,
      IOSOptions cupertinoOption,
      AndroidOptions materialOptions}) async {
    await _secureStorage.write(
        key: "credentials",
        value: authorizedUser.toString(),
        aOptions: materialOptions,
        iOptions: cupertinoOption);
  }

  Future<String> readCredentials(
      {IOSOptions cupertinoOption, AndroidOptions materialOptions}) async {
    final response = await _secureStorage.read(
        key: "credentials",
        iOptions: cupertinoOption,
        aOptions: materialOptions);
    debugPrint('${response.isNotEmpty ? response : "NoData"}');
    return response;
  }

  Future<void> updateCredentials(
      {@required AuthCredentials authorizedUser,
      IOSOptions cupertinoOptions,
      AndroidOptions materialOptions}) {
    _secureStorage.delete(
        key: "credentials",
        iOptions: cupertinoOptions,
        aOptions: materialOptions);
    writeCredentials(
        authorizedUser: authorizedUser,
        cupertinoOption: cupertinoOptions,
        materialOptions: materialOptions);
  }
}
