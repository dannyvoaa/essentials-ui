part of rx;

typedef void OnNextFunction<T>(T data);
typedef void OnCompletedFunction();

void noopNext(ignore) {}

void noopError(ignoreError, [ignoreStackTrace]) {}

void noopCompleted() {}

/// The observer in ReactiveX.
/// See
/// http://reactivex.io/documentation/observable.html
abstract class Observer<T> {
  /// Lib private/protected constructor.
  const Observer._();

  /// Creates an Observer using [onNext], [onError] and [onCompleted] function.
  factory Observer(
          {OnNextFunction<T> onNext,
          Function onError,
          OnCompletedFunction onCompleted}) =>
      _FunctionObserver(onNext, onError, onCompleted);

  /// Creates a safe observer using [onNext], [onError] and [onCompleted].
  ///
  /// A safe observer is an Observer and follows the contracts.
  ///
  /// CONTRACT:
  /// - If sendError or sendCompleted is called, future send* method won't do
  ///   anything.
  ///   See http://reactivex.io/documentation/contract.html
  /// - If any error occurs in sendNext, the Observer is also terminated
  ///   and won't send more new events.
  factory Observer.safe(
          {OnNextFunction<T> onNext,
          Function onError,
          OnCompletedFunction onCompleted}) =>
      _SafeFunctionObserver(onNext, onError, onCompleted);

  /// Returns a safe observer (see Observer.safe) using the given [observer].
  static Observer<E> makeSafe<E>(Observer<E> observer) {
    assert(observer != null);
    return observer is _SafeObserver
        ? observer
        : _SafeDelegatingObserver<E>(observer);
  }

  /// Emits the [data] event to this observer.
  void sendNext(T data) {
    _sendNextInternal(data);
  }

  /// The internal implementation of sendNext.
  ///
  /// Required to be overridden.
  void _sendNextInternal(T data);

  /// Emits the [error] and [stackTrace] event to this observer.
  ///
  /// CONTRACT:
  /// Implementation should assert that the [error] is not null.
  void sendError(Object error, [StackTrace stackTrace]) {
    assert(error != null);
    _sendErrorInternal(error, stackTrace);
  }

  /// The internal implementation of sendError.
  ///
  /// Required to be overridden.
  void _sendErrorInternal(Object error, [StackTrace stackTrace]);

  /// Emits completed event to this observer.
  void sendCompleted() {
    _sendCompletedInternal();
  }

  /// The internal implementation of sendCompleted.
  ///
  /// Required to be overridden.
  void _sendCompletedInternal();
}

/// An implementation of Observer which calls [onNext], [onError] and
/// [onCompleted] function for each send* method.
class _FunctionObserver<T> extends Observer<T> {
  OnNextFunction<T> _onNext;
  Function _onError;
  OnCompletedFunction _onCompleted;

  _FunctionObserver(OnNextFunction<T> onNext, Function onError,
      OnCompletedFunction onCompleted)
      : _onNext = onNext ?? noopNext,
        _onError = onError ?? noopError,
        _onCompleted = onCompleted ?? noopCompleted,
        super._();

  @override
  void _sendNextInternal(T data) {
    _onNext(data);
  }

  @override
  void _sendErrorInternal(Object error, [StackTrace stackTrace]) {
    _onError(error, stackTrace);
  }

  @override
  void _sendCompletedInternal() {
    _onCompleted();
  }
}

/// Delegating observer will wrap another observer and pass all calls
/// to the wrapped instance.
class _DelegatingObserver<T> extends Observer<T> {
  final Observer<T> _observer;

  const _DelegatingObserver(Observer<T> observer)
      : _observer = observer,
        super._();

  @override
  void _sendNextInternal(T data) {
    _observer?.sendNext(data);
  }

  @override
  void _sendErrorInternal(Object error, [StackTrace stackTrace]) {
    _observer?.sendError(error, stackTrace);
  }

  @override
  void _sendCompletedInternal() {
    _observer?.sendCompleted();
  }
}

/// Safe observer is the base mixin implementation follows the contracts of
/// Observer.safe factory.
abstract class _SafeObserver<T> implements Observer<T> {
  bool _done = false;

  @override
  void sendNext(T data) {
    if (_done) return;
    try {
      _sendNextInternal(data);
    } catch (e, st) {
      _logger.info(() => 'SafeObserver sendNext($data) catch error: $e - $st');
      _done = true;
      rethrow;
    }
  }

  @override
  void sendError(Object error, [StackTrace stackTrace]) {
    if (_done) return;
    try {
      _sendErrorInternal(error, stackTrace);
    } finally {
      _done = true;
    }
  }

  @override
  void sendCompleted() {
    if (_done) return;
    try {
      _sendCompletedInternal();
    } finally {
      _done = true;
    }
  }
}

/// Safe observer implementation uses function observer.
class _SafeFunctionObserver<T> = _FunctionObserver<T> with _SafeObserver<T>;

/// Safe observer implementation uses the delegating observer.
class _SafeDelegatingObserver<T> = _DelegatingObserver<T> with _SafeObserver<T>;
