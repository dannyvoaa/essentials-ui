part of rx;

typedef void DisposeFunction();

/// Disposable is used to cancel computation progress or stop a subscription.
/// See the 'unsubscribing' section in ReactiveX:
/// http://reactivex.io/documentation/observable.html
/// See:
/// http://www.introtorx.com/Content/v1.0.10621.0/03_LifetimeManagement.html#IDisposable
class Disposable {
  /// Gets the singleton noop instance.
  static final Disposable noop = Disposable._().._disposed = true;
  bool _disposed = false;

  Disposable._();

  /// Creates a Disposable instance using the [dispose] function.
  ///
  /// CONTRACT:
  /// The [dispose] function will be called exactly once when the returned
  /// disposable is disposed.
  factory Disposable([DisposeFunction dispose]) => _FunctionDisposable(dispose);

  /// Calls the [dispose] method.
  void call() {
    dispose();
  }

  /// Cancel computation progress or stop a subscription.
  ///
  /// CONTRACT:
  /// This method is reentrant. It can be safely called multiple times.
  void dispose() {
    if (!_disposed) {
      _disposed = true;
      _disposeInternally();
    }
  }

  /// The implementation of dispose. Subclass can override this method.
  ///
  /// This method will only be called one time when the first time the
  /// dispose method is called.
  void _disposeInternally() {}
}

/// A disposable which can be used to check the whether it is disposed.
abstract class CheckableDisposable implements Disposable {
  /// Creates a new CheckableDisposable instance.
  factory CheckableDisposable() => _CheckableDisposable._();

  /// Returns whether this is disposed.
  ///
  /// Be aware, ideally the [dispose] method should do clean up immediately once
  /// it is called. Check this property only if you can not control the
  /// process.
  ///
  /// Good example:
  ///
  ///    var disposable = new CheckableDisposable();
  ///    scheduleMicrotask(() {
  ///       if (!disposable.disposed) doSomething();
  ///    });
  ///    return disposable;
  ///
  /// Bad example:
  ///
  ///    var disposable = new CheckableDisposable();
  ///    var timer = new Timer(2s, () {
  ///      if (!disposable.disposed) doSomething();
  ///    });
  ///    return disposable;
  ///
  ///    For this case, you have controller on timer, so you should use the
  ///    normal disposable:
  ///
  ///    return new Disposable(new Timer(2s, doSomething).cancel);
  bool get disposed => _disposed;
}

/// Implementation of CheckableDisposable.
/// We need this class since CheckableDisposable is a mixin
/// which can not have constructor.
class _CheckableDisposable = Disposable with CheckableDisposable;

/// Disposable implementation which uses DisposeFunction.
class _FunctionDisposable extends Disposable {
  DisposeFunction _disposeFunction;

  _FunctionDisposable(DisposeFunction disposeFunction) : super._() {
    _disposeFunction = disposeFunction;
  }

  @override
  void _disposeInternally() {
    if (_disposeFunction != null) {
      _disposeFunction();
      _disposeFunction = null;
    }
  }
}

/// Base implementation which can set real disposable later.
/// This class is not intended to be used directly.
/// Using SingleAssignmentDisposable or SerialDisposable instead.
abstract class DelegatingDisposable extends Disposable {
  Disposable _disposable;

  DelegatingDisposable._() : super._();

  /// Returns the hold disposable.
  Disposable get disposable => _disposable;

  /// Sets the hold disposable to the given [disposable].
  ///
  /// The setter has more meaning for different subclasses, see
  /// the SingleAssignmentDisposable and SerialDisposable for more details.
  set disposable(Disposable disposable);

  void _checkOrSetDisposable(Disposable disposable) {
    if (!_disposed) {
      _disposable = disposable;
    } else {
      disposable?.dispose();
    }
  }

  void _disposeAndResetDisposable() {
    var local = _disposable;
    _disposable = null;
    local?.dispose();
  }

  @override
  void _disposeInternally() {
    _disposeAndResetDisposable();
  }
}

/// Single assignment disposable wraps another disposable and will dispose
/// that disposable once this disposable is disposed.
/// Unlike [SerialDisposable], once the wrapped disposable is not null, you can
/// not change it later.
class SingleAssignmentDisposable extends DelegatingDisposable {
  /// Creates a new single assignment disposable with given [disposable].
  SingleAssignmentDisposable() : super._();

  /// Sets the hold disposable to the new [disposable] instance.
  ///
  /// CONTRACT:
  /// - If this disposable is disposed or disposing, the [disposable] will be
  /// disposing immediately and won't be hold.
  /// - If existing hold disposable is not null, this method will throw
  /// exception in dev mode, but not in production mode.
  @override
  set disposable(Disposable disposable) {
    checkState(_disposable == null,
        message: 'The non-null hold disposable can not be changed');
    _checkOrSetDisposable(disposable);
  }
}

/// A SingleAssignmentDisposable which is also a CheckableDisposable
@visibleForTesting
class CheckableSingleAssignmentDisposable = SingleAssignmentDisposable
    with CheckableDisposable;

/// Serial disposable wraps another disposable and will dispose that disposable
/// once this disposable is disposed.
/// Unlike the [SingleAssignmentDisposable], you can change the wrapped
/// disposable any time.
class SerialDisposable extends DelegatingDisposable {
  /// Non optional parameter constructor is required for mixin base class.
  ///
  /// Protected
  SerialDisposable._() : super._();

  /// Creates a new serial disposable with given [disposable].
  factory SerialDisposable([Disposable disposable]) =>
      _SerialDisposable(disposable);

  /// Sets the hold disposable to the new [disposable] instance.
  ///
  /// CONTRACT:
  /// - If this disposable is disposed or disposing, the [disposable] will be
  /// disposed immediately and won't be wrapped.
  /// - If the currently wrapped disposable is not null, it will
  /// be disposed.
  @override
  set disposable(Disposable disposable) {
    if (!_disposed) _disposeAndResetDisposable();
    _checkOrSetDisposable(disposable);
  }
}

/// Implementation of SerialDisposable;
class _SerialDisposable extends SerialDisposable {
  _SerialDisposable(Disposable initialDisposable) : super._() {
    disposable = initialDisposable;
  }
}

/// A SerialDisposable which is also a CheckableDisposable
@visibleForTesting
class CheckableSerialDisposable = _SerialDisposable with CheckableDisposable;

/// A disposable which is composited by many disposables.
class CompositeDisposable extends Disposable {
  List<Disposable> _disposables;

  /// Non optional parameter constructor is required for mixin base class.
  ///
  /// Protected
  CompositeDisposable._(this._disposables) : super._();

  /// Creates a new CompositeDisposable with given [disposables].
  factory CompositeDisposable(
          [List<Disposable> disposables = const <Disposable>[]]) =>
      _CompositeDisposable(disposables);

  @override
  void _disposeInternally() {
    var disposables = _disposables;
    _disposables = <Disposable>[];
    for (var disposable in disposables) {
      disposable.dispose();
    }
  }

  /// Adds a [disposable] to be managed by current composite disposable.
  ///
  /// Returns whether the [disposable] is added.
  ///
  /// CONTRACT:
  /// If current composite disposable is disposed or disposing, the
  /// [disposable]  will be disposing immediately.
  bool add(Disposable disposable) {
    checkState(disposable != null, message: 'Can not add a null disposable');
    if (!_disposed) {
      _disposables.add(disposable);
      return true;
    } else {
      disposable.dispose();
      return false;
    }
  }

  /// Removes the [disposable].
  ///
  /// Returns whether the [disposable] is successfully removed.
  bool remove(Disposable disposable) => _disposables.remove(disposable);
}

/// Implementation of _CompositeDisposable.
class _CompositeDisposable extends CompositeDisposable {
  _CompositeDisposable(List<Disposable> disposables)
      : super._(List.from(disposables));
}

/// A CompositeDisposable which is also a CheckableDisposable
@visibleForTesting
class CheckableCompositeDisposable = _CompositeDisposable
    with CheckableDisposable;
