import 'package:aae/rxdart/rx.dart';

import '../_core.dart';

/// Applies an [accumulator] function over the source Observable where
/// the [accumulator] function itself returns an Observable. Then, each
/// intermediate Observable returned is concated into the output Observable.
/// If the source observable send an event during the time the currentValue
/// accumulated observable is emitting, that event will be hold until
/// current accumulated observable completed.
/// [seed] is used to define the initial accumulation value. This won't be
/// passed to the output observable.
/// # Example
/// src: --------1--------2--------3--------4--------|----------
/// [     src.concatScan((x, y) => just(x + y).delay(2s))      ]
/// out: -----------1--------3--------6--------10----|----------
/// # Example to implement paged data loader and cache
/// ```dart
/// final loadMore = new Subject();
/// final pagedData = loadMore.concatScan((current, _) {
///   final startIndex = current.length;
///   return new Observable.fromFuture(requestData(startIndex))
///       .map((response) => []..addAll(current)..addAll(response));
/// }, seed: <Row>[]);
/// ```
/// This is similar as the [mergeScan][rxjs-mergescan] operator with
/// concurrent equals 1.
/// [rxjs-mergescan]: http://reactivex.io/rxjs/class/es6/Observable.js~Observable.html#instance-method-mergeScan.
OperatorFunction<T, S> concatScan<T, S>(
        Observable<S> accumulator(S currentValue, T operand),
        {S seed}) =>
    NamedOperatorFunction<T, S>(
        'concatScan($accumulator, seed: $seed)',
        (Observable<T> source) => Observable((Observer<S> observer) {
              final bufferedSourceData = <T>[];
              final accumulatedSd = SerialDisposable();
              final sourceSad = SingleAssignmentDisposable();
              var accumulatedCompleted = false;
              var accumulatedActive = false;
              var currentValue = seed;
              void maySendCompleted() {
                if (accumulatedCompleted && !accumulatedActive) {
                  currentValue = null;
                  observer.sendCompleted();
                }
              }

              void onNextSource(sourceData) {
                if (!accumulatedActive) {
                  final accumulatedObservable =
                      accumulator(currentValue, sourceData);
                  final sad = SingleAssignmentDisposable();
                  accumulatedActive = true;
                  accumulatedSd.disposable = sad;
                  sad.disposable = accumulatedObservable.subscribe(
                      onNext: (accumulatedData) {
                        currentValue = accumulatedData;
                        observer.sendNext(currentValue);
                      },
                      onError: sendErrorAndDispose(observer, () {
                        accumulatedActive = false;
                        accumulatedSd.disposable = null;
                        sourceSad.dispose();
                        currentValue = null;
                      }),
                      onCompleted: () {
                        accumulatedActive = false;
                        accumulatedSd.disposable = null;
                        if (bufferedSourceData.isNotEmpty) {
                          onNextSource(bufferedSourceData.removeAt(0));
                        } else {
                          maySendCompleted();
                        }
                      });
                } else {
                  bufferedSourceData.add(sourceData);
                }
              }

              sourceSad.disposable = source.subscribe(
                  onNext: onNextSource,
                  onError: sendErrorAndDispose(observer, () {
                    accumulatedSd.dispose();
                    currentValue = null;
                  }),
                  onCompleted: () {
                    accumulatedCompleted = true;
                    maySendCompleted();
                  });
              return CompositeDisposable([sourceSad, accumulatedSd]);
            }));
