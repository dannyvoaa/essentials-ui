import 'dart:async';

import 'package:inject/inject.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// forwards all calls to
/// [url_launcher/url_launcher.dart].
class UrlLauncher {
  static final _logger = Logger('UrlLauncher');

  @provide
  @singleton
  const UrlLauncher();

  /// Launches the given url.
  ///
  /// See [url_launcher.launch].
  Future<void> launch(String url) async {
    try {
      await url_launcher.launch(url, forceWebView: true);
    } catch (error, trace) {
      _logger.info('Failed to launch URL', error, trace);
    }
  }
}
