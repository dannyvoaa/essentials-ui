import 'dart:async';
export 'blocking_latest.dart';
import 'package:aae/rxdart/rx.dart';

/// [subscribe]s the [observable] at the time of this method is called and
/// returns a [Future] of the latest emission of the [Observable].
/// # Example (src has no emission at the time of subscription)
/// src: ---------------------------1---------------------------
/// [                  blockingLatest(src)                     ]
/// out:        S-------------------1X--------------------------
/// S: the time of this method is called (aka subscription created).
/// X: subscripiont is closed.
/// # Example (src will replay 2 emissions at the time of subscription)
/// src: ---1---2--------------------3--------------------------
/// [                  blockingLatest(src)                     ]
/// out:             S2X----------------------------------------
Future<T> blockingLatest<T>(Observable<T> observable, {bool sync = true}) {
  final completer = sync ? Completer<T>.sync() : Completer<T>();
  final sad = SingleAssignmentDisposable();
  var hasData = false;
  var hasError = false;
  var drainReplayed = false;
  T capturedData;
  sad.disposable = observable.subscribe(onNext: (data) {
    if (drainReplayed && !hasData) {
      completer.complete(data);
      sad.dispose();
    } else {
      capturedData = data;
    }
    hasData = true;
  }, onError: (error, [stackTrace]) {
    hasError = true;
    capturedData = null;
    completer.completeError(error, stackTrace);
    sad.dispose();
  }, onCompleted: () {
    if (!hasData) {
      completer.completeError(
          StateError('Observable [$observable] completes without emission'));
    }
    sad.dispose();
  });
  drainReplayed = true;
  if (hasData && !hasError) {
    completer.complete(capturedData);
    sad.dispose();
  }
  return completer.future;
}
