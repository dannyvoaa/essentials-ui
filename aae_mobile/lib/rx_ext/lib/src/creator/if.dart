import 'package:aae/rxdart/rx.dart';
import 'package:quiver/check.dart';
import '../_core.dart';

/// Creates an observable which [condition]ally subscribes to [then] [orElse].
/// # Example
/// cond: --T----------F--------F---T------|---------------------
/// then: --S--1--2----D------------S---3--4--5--6----|----------
/// else: -------------S---a--b--c--D----------------------------
/// [        observableIf(cond, then: then, orElse: else)       ]
/// out : -----1--2--------a--b--c------3--4--5--6----|----------
/// S: subscribe
/// D: dispose
/// T/F: true and false
/// |: completed
/// The subscriptions on [then] [orElse] will be terminated once the [condition]
/// is changed. And the result observable will be completed once the [condition]
/// is completed and last subscribed statement observable is completed.
Observable<T> observableIf<T>(Observable<bool> condition,
    {Observable<T> then, Observable<T> orElse}) {
  checkArgument(condition != null, message: 'The condition can not be null');
  checkArgument(then != null || orElse != null,
      message: 'Then and OrElse can not be both null');
  then = then ?? Observable.empty();
  orElse = orElse ?? Observable.empty();
  return Observable((Observer<T> observer) {
    var conditionCompleted = false;
    var lastStatementCompleted = false;
    void sendCompletedIfPossible() {
      if (conditionCompleted && lastStatementCompleted) {
        observer.sendCompleted();
      }
    }

    final statementSD = SerialDisposable();
    Disposable conditionDisposable;
    conditionDisposable = condition.distinctUntilChanged().subscribe(
        onNext: (condition) {
          final next = condition ? then : orElse;
          lastStatementCompleted = false;
          statementSD.disposable = next.subscribe(
              onNext: observer.sendNext,
              onError: sendErrorAndDispose(observer, conditionDisposable),
              onCompleted: () {
                lastStatementCompleted = true;
                sendCompletedIfPossible();
              });
        },
        onError: sendErrorAndDispose(observer, statementSD),
        onCompleted: () {
          conditionCompleted = true;
          sendCompletedIfPossible();
        });
    return CompositeDisposable([conditionDisposable, statementSD]);
  })
    ..name = 'if($condition, then: $then, else: $orElse)';
}
