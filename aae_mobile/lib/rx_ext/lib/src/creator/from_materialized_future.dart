import 'package:aae/rxdart/rx.dart';

/// Creates an observable of [Notification] from the given [future].
/// [Notification] wraps the events in a metadata to specify the event types.
/// For both success and error future events the observable fires next events
/// of type [NotificationType.OnNext] and [NotificationType.OnError],
/// respectively.
/// This is useful for chained observables to get the [future] error
/// and consume it at a later stage in the chain.
Observable<Notification<T>> observableFromMaterializedFuture<T>(
        Future<T> future) =>
    Observable((Observer<Notification<T>> observer) {
      // Note, we need the CheckableDisposable since we are not able to stop
      // the computation in the closure of 'Future.then', so we need to check
      // the status of disposable to decide whether we should feed the observer.
      final disposable = CheckableDisposable();
      future.then((T data) {
        if (!disposable.disposed) {
          observer
            ..sendNext(Notification.onNext(data))
            ..sendNext(Notification.onCompleted())
            ..sendCompleted();
        }
      }, onError: (error, [stackTrace]) {
        if (!disposable.disposed) {
          observer
            ..sendNext(Notification.onError(error, stackTrace))
            ..sendCompleted();
        }
      });
      return disposable;
    })
      ..name = 'observableFromMaterializedFuture($future)';
