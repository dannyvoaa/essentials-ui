import 'package:aae/rxdart/rx.dart';
import 'package:meta/meta.dart';
import '../_core.dart';

/// Takes the latest events from this and [thatObservable] and delete the
/// previous cached events with [resetWhen].
/// If one of the source [Observable] is completed, the new source will be
/// completed when [resetWhen] emits data.
/// If no [CombineFunction] is provided, returns a list of this observable's
/// latest value and that observable's latest value.
/// # Example 1 (src1/src2/reset does not depend on a common source)
/// src1:  ----1----------2--------3--------4--------5-----|------------
/// src2:  -------a----b-----c-----d-----e--------------f---g------h--|-
/// reset: ----------X----------------X----------X---------------X----|-
/// [    src1.apply(combineLatestWithAndReset(src2, resetWhen: reset)) ]
/// out:   -------1a------2b-2c----3d-------4e----------5f--5g---|------
/// Compared to:
/// [    src1.apply(combineLatestWith(src2))                           ]
/// out:   -------1a---1b-2b-2c----3d----3e-4e-------5e-5f--5g-----5h-|-
/// If one of the source [Observable] and [resetWhen] depend on the same
/// source, the output observable behavior is *undefined* at the time reset o
/// bservable fires.
/// To prevent the undetermination, the source observable can
/// be scheduled to the next run loop to ensure that previous data is reset
/// before sending events.
/// # Example 2 (src1/src2/reset depends on a common source)
/// src1 = new Observable.merge([reset.map((_) => 0), x]).schedule(nextLoop);
/// src2 = new Observable.merge([reset.map((_) => 'z'), y]).schedule(nextLoop);
/// x:     ----1-----------2--------------3-----------4------------|-----
/// y:     -------a---------------b---------------c-------d-----f------|-
/// reset: ------------X----------------------X-------X-------------|----
/// [     src1.apply(combineLatestWithAndReset(src2, resetWhen: reset)) ]
/// out:   -------1a---0z--2z-----2b------3b--0z--0c--0z--0d----0f-----|-
/// Compared to:
/// [     src1.apply(combineLatestWith(src2))                           ]
/// out:   -------1a---%%--2z-----2b------3b--%%--0c--%%--0d----0f-----|-
/// (% represents underterministic behaviors.)
/// See [combineLatest operator in ReactiveX][rx-combinelatest]
/// for more details.
/// [rx-combinelatest]: http://reactivex.io/documentation/operators/combinelatest.html
OperatorFunction<T, O> combineLatestWithAndReset<T, S, O>(
        Observable<S> thatObservable,
        {@required Observable<Object> resetWhen,
        CombineFunction<T, S, O> combiner}) =>
    OperatorFunction<T, O>(
        (Observable<T> source) => Observable((Observer<O> observer) {
              T capturedThisValue;
              var didCaptureThisValue = false;
              var didThisComplete = false;
              S capturedThatValue;
              var didCaptureThatValue = false;
              var didThatComplete = false;
              var thisSad = SingleAssignmentDisposable();
              var thatSad = SingleAssignmentDisposable();
              var resetSad = SingleAssignmentDisposable();
              void maySendNext() {
                if (didCaptureThisValue && didCaptureThatValue) {
                  observer.sendNext(combiner == null
                      ? [capturedThisValue, capturedThatValue]
                      : combiner(capturedThisValue, capturedThatValue));
                }
              }

              void maySendCompleted() {
                if (didThisComplete && didThatComplete) {
                  observer.sendCompleted();
                  resetSad.dispose();
                }
              }

              resetSad.disposable = resetWhen.subscribe(
                  onNext: (_) {
                    didCaptureThisValue = false;
                    didCaptureThatValue = false;
                    // If one of the source [Observable] is completed, the new
                    // observable will not emit any new data after [resetWhen]
                    // emits data.
                    // Thus, [combineLatestWithAndReset] will complete the new
                    // source and dispose current listening subscriptions for
                    // better resource management.
                    if (didThisComplete) {
                      observer.sendCompleted();
                      thatSad.dispose();
                      resetSad.dispose();
                    } else if (didThatComplete) {
                      observer.sendCompleted();
                      thisSad.dispose();
                      resetSad.dispose();
                    }
                  },
                  onError: sendErrorAndDispose(
                      observer, CompositeDisposable([thisSad, thatSad])));
              thisSad.disposable = source.subscribe(
                  onNext: (T data) {
                    capturedThisValue = data;
                    didCaptureThisValue = true;
                    maySendNext();
                  },
                  onError: sendErrorAndDispose(
                      observer, CompositeDisposable([thatSad, resetSad])),
                  onCompleted: () {
                    didThisComplete = true;
                    maySendCompleted();
                  });
              thatSad.disposable = thatObservable.subscribe(
                  onNext: (S data) {
                    capturedThatValue = data;
                    didCaptureThatValue = true;
                    maySendNext();
                  },
                  onError: sendErrorAndDispose(
                      observer, CompositeDisposable([thisSad, resetSad])),
                  onCompleted: () {
                    didThatComplete = true;
                    maySendCompleted();
                  });
              return CompositeDisposable([thisSad, thatSad]);
            }));

/// Combines the latest events from all [observables] and reset the previous
/// events with [resetWhen].
/// If any source observable [ob] and [resetWhen] depend on the same
/// source, [ob] should be scheduled to the next run loop to ensure that
/// previous data in [ob] is reset before sending new events.
/// # Example
/// ob1 = a.map(mapper1);
/// ob2 = a.map(mapper2);
/// out = combineLatestAndReset([ob1.schedule(nextLoop),
///       ob2.schedule(nextLoop)], a);
/// see [combineLatestWithAndReset] for more details.
/// See [combineLatest operator in ReactiveX][rx-combinelatest]
/// for more details.
/// [rx-combinelatest]: http://reactivex.io/documentation/operators/combinelatest.html
Observable<List<T>> combineLatestAndReset<T>(
    Iterable<Observable<T>> observables, Observable<Object> resetWhen) {
  // [reset] has to be multicast so that each pair of sources could reset
  // when reset emits an event.
  final reset = resetWhen.shareReplay();
  return observables.skip(1).fold(
        observables.isEmpty
            ? Observable<List<T>>.just([])
            : observables.first.map((item) => [item]),
        (Observable<List<T>> prevValue, Observable<T> element) =>
            prevValue.apply(combineLatestWithAndReset<List<T>, T, List<T>>(
          element,
          combiner: (combined, element) => List<T>.from(combined)..add(element),
          resetWhen: reset,
        )),
      )..name = 'combineLatestAndReset($observables, $resetWhen)';
}
