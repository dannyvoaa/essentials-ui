/// Rx lib aimed to implement ReactiveX (http://reactivex.io/) equivalent
/// data structures in dart for reactive functional programming.
library rx;

import 'dart:async';
import 'dart:collection';
import 'dart:core';
import 'dart:math';
import "package:collection/collection.dart";
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:quiver/check.dart';

part 'src/disposable.dart';

part 'src/notification.dart';

part 'src/observable.dart';

part 'src/observer.dart';

part 'src/scheduler.dart';

part 'src/subject.dart';

Logger _defaultLogger = Logger('rx');
Logger _logger = _defaultLogger;

/// Sets the global logger in the rx lib to the [logger].
/// If the [logger] is null, it will use a default logger named 'rx'.
/// The [logger] will be used to log Observable running progress and errors
/// using levels:
/// - FINE: progress for debugging;
/// - INFO: information and expected (eaten) errors;
/// - WARNING: unexpected exception.
void setRxLogger(Logger logger) {
  _logger = logger ?? _defaultLogger;
}
