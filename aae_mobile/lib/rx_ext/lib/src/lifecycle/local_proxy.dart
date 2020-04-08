import 'package:aae/rxdart/rx.dart';

/// Returns a [OperatorFunction] which creates a local proxy of the source
/// Observable.
/// Subscription to an observable which has longer lifecycle than current scope
/// may cause memory leak if the subscription is not disposed at the end of
/// current component's lifecycle. For example:
/// ```dart
/// class FooBloc extends Bloc {
///   Source foo;
///   FooBloc() {
///     foo = externalObservable
///         .map()
///         .convertAs(toSource);
///   }
///   @override
///   void dispose () {
///     // Subscription to externalObservable may NOT be disposed.
///   }
/// }
/// ```
/// Applying this operator before subscribing to a global observable provides
/// a way to bound the subscription to the component's lifecycle. For example:
/// ```dart
/// class FooBloc extends Bloc {
///   final _cd = new CompositeDisposable();
///   Source foo;
///   FooBloc() {
///     foo = externalObservable
///         .apply(localProxy(_cd))
///         .map()
///         .convertAs(toSource);
///   }
///   @override
///   void dispose () {
///     // Subscription to externalObservable is guaranteed to be disposed.
///     _cd.dispose();
///   }
/// }
/// ```
OperatorFunction<T, T> localProxy<T>(CompositeDisposable localDisposable) =>
    OperatorFunction<T, T>((Observable<T> src) =>
        Observable((Observer<T> observer) {
          final subscriptionDisposable = src.subscribeByObserver(observer);
          localDisposable.add(subscriptionDisposable);
          final completeObserverDisposable =
              Disposable(() => observer.sendCompleted());
          localDisposable.add(completeObserverDisposable);
          return CompositeDisposable([
            subscriptionDisposable,
            Disposable(() => localDisposable.remove(subscriptionDisposable)),
            Disposable(
                () => localDisposable.remove(completeObserverDisposable)),
          ]);
        }));
