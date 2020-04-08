import 'package:aae/rxdart/rx.dart';

/// Creates an observable of [Notification] from the given [stream].
/// [Notification] wraps the events in a metadata to specify the event types.
/// For all event types the observable fires next events of [NotificationType]
/// corresponding to the stream event types.
/// The [stream] is changed to [stream].asBroadcastStream() if it is not
/// since Observables are multicasted.
/// The [completeOnError] signal is set by default which completes the
/// observable after an error is reported.
/// This is useful for chained observables to get the [stream] error
/// and consume it at a later stage in the chain.
Observable<Notification<T>> observableFromMaterializedStream<T>(
    Stream<T> stream,
    {bool completeOnError = true}) {
  final broadcastStream =
      stream.isBroadcast ? stream : stream.asBroadcastStream();
  return Observable((Observer<Notification<T>> observer) => Disposable(
          broadcastStream
              .listen((T data) => observer.sendNext(Notification.onNext(data)),
                  onError: (error, [stackTrace]) {
        observer.sendNext(Notification.onError(error, stackTrace));
        if (completeOnError) observer.sendCompleted();
      }, onDone: () {
        observer
          ..sendNext(Notification.onCompleted())
          ..sendCompleted();
      }).cancel))
    ..name = 'observableFromMaterializedStream($stream)';
}
