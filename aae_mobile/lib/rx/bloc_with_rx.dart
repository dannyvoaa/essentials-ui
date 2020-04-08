import 'package:aae/rxdart/rx.dart';

typedef void SourceDisposeFunction();
typedef void SourceOnDataFunction<T>(T data);

/// Source is the producer/source of data.
/// A source is expected to produce a sequence of data over time.
abstract class Source<T> {
  /// Subscribes to the source using the [onData] handler function.
  ///
  /// Contract:
  /// - Source can be subscribed any number of times.
  /// - Source keeps track of all [onData] functions subscribed to
  ///   it, until one of [onData]'s corresponding SourceDisposeFunction is
  ///   called, in such event the source will stop tracking that
  ///   particular [onData].
  /// - Every time when a source emits a datum, it will immediately call
  ///   every tracked [onData] function with the datum emitted. There is
  ///   NO ordering guarantee of which [onData] will be called first.
  /// - Source will always 'replay' the last emitted datum to
  ///   [onData] upon each subscription (synchronously or in the
  ///   immediately next microtask queue), but all other previously emitted data
  ///   will not be passed to [onData].
  ///
  /// Note, there is no `onError` handler. If the error will be displayed, it
  /// should be treated as a kind of data.
  /// If an error happens inside the business logic and it should be displayed
  /// in the UI, the *BLOC* need to expose an error source separately to let
  /// UI bind on the source.
  SourceDisposeFunction subscribe(SourceOnDataFunction<T> onData);
}

/// Converts the [observable] to a Source.
/// The [observable] will be [shareReplay]ed to meet the contracts
/// of Source.
Source<T> toSource<T>(Observable<T> observable) =>
    _ObservableSource(observable);

/// A Source that wraps an observable.
class _ObservableSource<T> implements Source<T> {
  final Observable<T> _replayed;

  _ObservableSource(Observable<T> observable)
      : _replayed = observable.shareReplay();

  @override
  SourceDisposeFunction subscribe(SourceOnDataFunction<T> onData) =>
      _replayed.subscribe(onNext: onData);
}
