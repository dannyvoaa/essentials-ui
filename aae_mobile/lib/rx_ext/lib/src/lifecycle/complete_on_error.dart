import 'package:aae/rxdart/rx.dart';

import '../_core.dart';

/// Operator which changes the error handling logic to sending completed
/// instead of error to subscribers.
/// After sending completed, then [handleError] if specified.
OperatorFunction<T, T> completeOnError<T>(
        {void Function(Object, [StackTrace]) handleError}) =>
    NamedOperatorFunction<T, T>(
        'completeOnError($handleError: handleError)',
        (Observable<T> src) => Observable((Observer<T> observer) {
              return src.subscribe(
                  onNext: observer.sendNext,
                  onCompleted: observer.sendCompleted,
                  onError: (error, [stackTrace]) {
                    observer.sendCompleted();
                    if (handleError != null) handleError(error, stackTrace);
                  });
            }));
