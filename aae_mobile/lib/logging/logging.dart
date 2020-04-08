import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import 'log_buffer.dart';

const repositoryLogPrefix = 'Repository';
const _appNamePrefix = 'aae';
const _appNameLogPrefix = '[$_appNamePrefix]';

final _logDateFormat = DateFormat('MM-dd hh:mm:ss.SSS');

/// An internal Logger that we use in a tricky way to report uncaught errors
/// inside this file.
///
/// Uncaught errors are turned into [_UncaughtError] objects and sent to this
/// [Logger], which other methods will pick up because they're listening to
/// the global [Logger].
final _uncaughtErrorLogger = Logger('_uncaught_errors');

/// Calculate the max width of the [Level.LEVELS] strings so we can align our
/// log text nicely.
final _logLevelMaxWidth = Level.LEVELS
    .fold(0, (max, level) => level.name.length > max ? level.name.length : max);

/// Initialize our [Logger] so that it logs readable messages.
///
/// This should be called ASAP when we're creating the app so any logs get
/// recorded. This method should never have dependencies because of that.
///
/// If you need dependencies to be available, add code to
/// [setupAdditionalLogging] instead.
void setupLogging() {
  Logger.root
    ..level = Level.ALL
    ..onRecord.listen((LogRecord record) {
      // Don't log UncaughtErrors. Those are force logged in
      // _setUpFlutterErrorHandler.
      if (record.loggerName == _uncaughtErrorLogger.name) return;

      // Use debugPrint so we don't lose logs on Android.
      debugPrint(_createLogFromRecord(record), wrapWidth: 1024);
    });

  // Hierarchical Logging
  // Enable this so we can set the levels of higher-level Loggers
  // as defined in the lines following.
  hierarchicalLoggingEnabled = true;
}

/// Initialize any additional logging that requires dependencies to exist.
///
/// Print is handled in [setupLogging], and we don't use Report yet.
void setupAdditionalLogging(
  LogBuffer logBuffer,
) {
  Logger.root.onRecord.listen((record) {
    _addLogRecordToBuffer(logBuffer, record);
  });

  _setUpFlutterErrorHandler();
}

/// Add log records to a [LogBuffer] that will eventually be sent in the user feedback
/// entry.
///
/// The [LogBuffer] should be the same one we give to the 'Feedback Service'.
/// This should be handled for us by the dependency injector.
///
void _addLogRecordToBuffer(LogBuffer logBuffer, LogRecord record) {
  logBuffer.push(_createLogFromRecord(record));
}

/// Value type for metadata about an error that is not caught until the top-
/// level error handler in this file.
///
/// These objects are posted to the [_uncaughtErrorLogger] [Logger] so they
/// can be reported properly.
class _UncaughtError {
  final Object error;
  final StackTrace stackTrace;
  final bool isSilent;

  _UncaughtError({this.error, this.stackTrace, this.isSilent});
}

/// Sets up crash reporting for errors which occur within a Flutter framework
/// stack.
///
/// This is where [_UncaughtError]s are created, and force logged to the
/// Flutter console. This means our normal logger in [setupLogging] should
/// not log the [_UncaughtError]s.
void _setUpFlutterErrorHandler() {
  // This is where we'll catch "Uncaught Errors"
  // Immediately log them to the Flutter console.
  FlutterError.onError = (errorDetails) async {
    FlutterError.dumpErrorToConsole(errorDetails, forceReport: true);
    final uncaughtError = _UncaughtError(
      error: errorDetails.exception,
      stackTrace: errorDetails.stack,
      isSilent: errorDetails.silent,
    );

    if (errorDetails.silent) {
      // Silent errors are informational but not serious.
      _uncaughtErrorLogger.warning(
          'Uncaught silent exception: Not reported (silent)',
          uncaughtError,
          errorDetails.stack);
      return;
    }
    _uncaughtErrorLogger.severe(
        'Uncaught exception: Not Reported (exportErrors=false)',
        uncaughtError,
        errorDetails.stack);
  };
}

String _createLogFromRecord(LogRecord record) {
  final level = record.level.name.padRight(_logLevelMaxWidth);
  final timestamp = _logDateFormat.format(record.time);
  var error = record.error;
  var stackTrace = _traceFromStackTrace(record.stackTrace);
  var message = record.message;

  // If we're handling an UncaughtError, pull out the original error data from
  // it and use that instead.
  if (record.error is _UncaughtError) {
    final uncaughtError = record.error as _UncaughtError;
    error = uncaughtError.error;
    stackTrace = _traceFromStackTrace(uncaughtError.stackTrace);
    if (uncaughtError.isSilent) {
      message = 'Uncaught silent error: $message';
    } else {
      message = 'Uncaught error: $message';
    }
  }

  // Combine the App Name, log level, log time, and message on one line.
  // Then add the error and stack trace on new lines, if they exist.
  //
  // Every line is prefixed with the app name from [prefixLines].
  return prefixLines(
      ['$level: $timestamp: $message', error, stackTrace]
          .where((line) => line != null)
          .join('\n'),
      '$_appNameLogPrefix[${record.loggerName}] ');
}

Trace _traceFromStackTrace(StackTrace stackTrace) =>
    stackTrace != null ? Trace.from(stackTrace)?.terse : null;

/// Prefixes all lines in [message] with [prefix].
///
/// This lets our logs stand apart from native/other app logs.
String prefixLines(String message, String prefix) {
  if (message == null) return null;
  if (message.isEmpty) return prefix;
  return LineSplitter.split(message).map((line) => '$prefix$line').join('\n');
}
