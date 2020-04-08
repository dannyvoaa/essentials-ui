import 'package:aae/rxdart/rx.dart';

/// Drains any values that are replayed (e.g., from [shareReplay]) from the
/// current [Observable].
/// If the replayed observable has emitted an error or has completed, the
/// returned observable will still replay that state.
/// # Example
/// src1: ----1--------2---------------------3----------|-------
/// [                src1.shareReplay()                     ]
/// out:                         2-----------3----------|-------
/// [         src1.shareReplay().drainReplay(src2)          ]
/// out:                         ------------3----------|-------
OperatorFunction<T, T> drainReplay<T>() =>
    OperatorFunction<T, T>((observable) => Observable((observer) {
          final subject = Subject<T>();
          final terminatingSubject = Subject<T>.replay();
          // Drain all replayed events.
          final sourceDisposable = observable.subscribe(
              onNext: subject.sendNext,
              onCompleted: terminatingSubject.sendCompleted,
              onError: terminatingSubject.sendError);
          // Pass later events and preexisting failures.
          final subjectDisposable = subject.subscribeByObserver(observer);
          terminatingSubject.subscribe(
              onError: (_, [__]) => subjectDisposable.dispose(),
              onCompleted: subjectDisposable.dispose);
          final terminatingSubjectDisposable =
              terminatingSubject.subscribeByObserver(observer);
          return CompositeDisposable([
            sourceDisposable,
            subjectDisposable,
            terminatingSubjectDisposable
          ]);
        }));
