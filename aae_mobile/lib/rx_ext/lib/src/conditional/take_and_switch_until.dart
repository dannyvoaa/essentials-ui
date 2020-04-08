import 'package:aae/rxdart/rx.dart';

import '../_core.dart';

/// Returns an operator which returns an observable that takes in events
/// from source observable and then switches to the [until] observable
/// when the latter starts firing events
/// # Timeline
/// src  : --1---2----3-D-----------------------------------------
/// until: -------------a-----b----c----d--------------|----------
/// [            src.apply(takeAndSwitchUntil(until))            ]
/// out  : --1---2----3-a-----b----c----d--------------|----------
/// D: dispose
/// |: completed
/// Any error from source or [until] will be passed to the result directly.
/// Completes the source will not complete the result, but completes the [until]
/// will immediately complete the result.
/// # Example usage
/// Considering a display text which comes from both initial value and
/// user input. But the initial value may be async or there may have no initial
/// value, and once user have any input the display text should not be overriden
/// by initial value (if async loading)
/// ```dart
/// var displayText = initText.apply(takeAndSwitchUntil(userInputText));
/// ```
/// This operator is a variant and combination of [amb operator][rx-amb] and
/// [takeUntil operator][rx-take-until], please check these operators for
/// better understanding.
/// [rx-amb]: http://reactivex.io/documentation/operators/amb.html
/// [rx-take-until]: http://reactivex.io/documentation/operators/takeuntil.html
OperatorFunction<T, T> takeAndSwitchUntil<T>(Observable<T> until) =>
    NamedOperatorFunction<T, T>(
        'takeAndSwitchUntil(${until.name})',
        (Observable<T> source) => Observable((Observer<T> observer) {
              final sourceSad = SingleAssignmentDisposable();
              final untilSad = SingleAssignmentDisposable();
              sourceSad.disposable = source.subscribe(
                  onNext: observer.sendNext,
                  onError: sendErrorAndDispose(observer, untilSad));
              untilSad.disposable = until.subscribe(
                  onNext: (data) {
                    sourceSad.disposable();
                    observer.sendNext(data);
                  },
                  onError: sendErrorAndDispose(observer, sourceSad),
                  onCompleted: () {
                    sourceSad.disposable();
                    observer.sendCompleted();
                  });
              return CompositeDisposable([sourceSad, untilSad]);
            }));
