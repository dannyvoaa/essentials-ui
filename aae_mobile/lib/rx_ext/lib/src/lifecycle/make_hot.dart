import 'package:aae/rxdart/rx.dart';

/// Returns an [OperatorFunction] which makes [src] observable hot.
/// Hot observable is a connected [Connetable] (transformed
/// using [toConnectable]) which keeps observable logic graph running untile
/// the [cd] is disposed.
/// Compares with [shareReplay] function, [shareReplay] will shutdown the graph
/// if there is no any observer and will restart the graph if a new observer
/// starts observe. But this function will start the graph immediately and then
/// holds the graph regardless if there is any observer or not,
/// only caller can stop it via the [cd].
/// # Example
/// ```dart
/// final cd = new CompositeDisposable();
/// final graph = new Observable(...).map(...).filter(...)
///     .apply(hotify((ob) => ob.publishReplay(), cd));
/// final disposable = src.subscribe(...);
/// ...
/// disposable.dispose(); // No subscriber, but graph can still produce events.
/// ...
/// cd.dispose(); // graph shuts down.
/// ```
/// The the [hot v.s. cold observable][hot-vs-cold-observable] topic for more
/// details.
/// [hot-vs-cold-observable]: https://github.com/Reactive-Extensions/RxJS/blob/master/doc/gettingstarted/creating.md#cold-vs-hot-observables
OperatorFunction<T, T> _makeHot<T>(
        Connectable<T> toConnectable(Observable<T> observable),
        CompositeDisposable cd) =>
    OperatorFunction<T, T>((Observable<T> src) {
      final connectable = toConnectable(src);
      cd.add(connectable.connect());
      return connectable.observable;
    });

/// Returns an [OperatorFunction] which makes [src] to be a hot share replayed
/// observable.
/// The the [hot v.s. cold observable][hot-vs-cold-observable] topic for more
/// details.
/// [hot-vs-cold-observable]: https://github.com/Reactive-Extensions/RxJS/blob/master/doc/gettingstarted/creating.md#cold-vs-hot-observables
OperatorFunction<T, T> hotShareReplay<T>(CompositeDisposable cd) =>
    _makeHot<T>((ob) => ob.publishReplay(), cd);
