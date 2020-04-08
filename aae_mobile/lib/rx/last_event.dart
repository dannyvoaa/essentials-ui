import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rxdart/rx.dart';

/// Gets the event most recently sent to [observable], or null if there is no
/// event.
///
/// [observable] must be implemented as a replay or behavior subject (in many
/// cases this means constructed with createBehaviorSubject,) or this will
/// always return null.
T lastEvent<T>(Observable<T> observable) {
  T lastEvent;
  observable.subscribe(onNext: (event) {
    lastEvent = event;
  }).dispose();
  return lastEvent;
}

/// Gets the event most recently sent to [Source], or null if there is no
/// event.
T lastEventFromSource<T>(Source<T> source) {
  T lastEvent;
  source.subscribe((event) {
    lastEvent = event;
  })();

  return lastEvent;
}
