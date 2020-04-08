part of rx;

typedef Disposable OnSubscribeFunction<T>(Observer<T> observer);
typedef T ConvertFunction<S, T>(Observable<S> observable);

/// Representation of an operation that may be performed on an `Observable<S>`
/// to yield an `Observable<T>`.
class OperatorFunction<S, T> {
  final Observable<T> Function(Observable<S>) _operator;

  OperatorFunction(this._operator);

  Observable<T> call(Observable<S> source) => _operator(source);
}

/// Typedef for combining the value [T] from the current observable with the
/// value from another observable [S] to return a new value [O].
typedef O CombineFunction<T, S, O>(T thisValue, S thatValue);

/// The ReactiveX Observable which emits events of type [T].
/// In ReactiveX an observer subscribes to an Observable.
/// Then that observer reacts to whatever item or sequence of items
/// the Observable emits.
/// This pattern facilitates concurrent operations because it does not need
/// to block while waiting for the Observable to emit objects,
/// but instead it creates a sentry in the form of an observer
/// that stands ready to react appropriately at whatever future time
/// the Observable does so.
/// See:
/// http://reactivex.io/documentation/observable.html
abstract class Observable<T> {
  /// The name of current Observable instance.
  ///
  /// For best practice, caller should name a new created observable properly,
  /// and the operators will name the derived observable using this name.
  ///
  /// E.g.
  ///     var myOb = (...create observable...)..name = 'mouseMove';
  ///     var mousePosition = myOb.map(...convert event to offset...);
  ///     // mousePosition.name == 'mouseMove.map(dynamic closure)'
  ///     // you can also rename the mousePosition, like:
  ///     mousePosition.name = 'mousePosition';
  ///
  /// This will be used to trace the observable derivation chain.
  String name;

  /// Protected constructor for subclassing.
  @protected
  Observable.protected();

  @override
  String toString() => name;

  // -------------------------------------------------------------------
  // Core apis.
  // -------------------------------------------------------------------
  /// Creates an Observable from the [onSubscribe] function.
  ///
  /// Note, the [onSubscribe] function will be called every time once the
  /// returned observable is subscribed.
  factory Observable(OnSubscribeFunction<T> onSubscribe) =>
      OnSubscribeObservableFactory.currentFactory.create(onSubscribe);

  /// Subscribes this observable using [observer].
  ///
  /// CONTRACTS:
  /// Implementation should follow the contracts of
  /// http://reactivex.io/documentation/contract.html
  /// A good practice is to wrap the [observer] using [Observer.makeSafe].
  Disposable subscribeByObserver(Observer<T> observer);

  /// Subscribes this observable using [onNext], [onError] and [onCompleted]
  /// functions.
  ///
  /// Should follow the contracts of subscribeByObserver.
  Disposable subscribe(
          {OnNextFunction<T> onNext,
          Function onError,
          OnCompletedFunction onCompleted}) =>
      subscribeByObserver(Observer.safe(
          onNext: onNext, onError: onError, onCompleted: onCompleted));

  /// Applies the [op]erator to this observable to create a new observable.
  ///
  /// This function is desired to be used to let caller create its own operator.
  ///
  /// * If your operator is designed to originate an Observable,
  /// * you can either use this method or [new Observable] directly.
  ///
  /// Best practice:
  /// 1. Before creating a new operator, try to use composition of existing
  ///    operators.
  /// 2. Do *NOT* do heavy logic in the function body of [op]erator, instead
  ///    do them in the onSubscribe side effect. Ideally, after the parameter
  ///    checking, the first statement of your [op]erator should be
  ///    'return new Observable<S>(...));'.
  ///    E.g. define a map like operator
  ///        var srcObservable = ...;
  ///        var convert = (T data) => ... as S;
  ///        var op = (Observable<T> src) =>
  ///            new Observable((Observer<S> observer) => src.subscribe(
  ///               onNext: (T data) {
  ///                 observer.sendNext(convert(data));
  ///               },
  ///               onError: observer.sendError,
  ///               onCompleted: observer.sendCompleted));
  ///        var myMappedObservable = srcObservable.apply(op);
  /// 3. It is suggested that once the returned instance of
  ///    Observable<S> is subscribed, this observable is also subscribed.
  ///    See the example in previous rule.
  /// 4. It is suggested that name the [op]erator by subclassing the Function
  ///    and overriding the toString() method.
  ///    Or rename the entire mapped observable directly.
  ///    E.g. the example in rule 2
  ///        var myMappedObservable = srcObservable.apply(op)
  ///            ..name = '${srcObservable.name}.myOperator()';
  ///
  /// Related articles:
  /// http://reactivex.io/documentation/implement-operator.html
  /// http://xgrommx.github.io/rx-book/content/getting_started_with_rxjs/implementing_your_own_operators.html
  /// http://akarnokd.blogspot.hu/2015/05/pitfalls-of-operator-implementations.html
  /// http://akarnokd.blogspot.hu/2015/05/pitfalls-of-operator-implementations_14.html
  Observable<S> apply<S>(OperatorFunction<T, S> op) =>
      op(this)..name = '$name.apply($op)';

  // -------------------------------------------------------------------
  // Glue api for other dart core libs.
  // -------------------------------------------------------------------
  /// Presents this observable as another data structure using the [convert]
  /// function.
  ///
  /// Compares with the [convertTo] function, every time this observable
  /// is pushed in new data, the converted data structure should be changed.
  ///
  /// # Example
  /// ```dart
  /// stream(Observable<T> observable) {
  ///   var sad = new SingleAssignmentDisposable();
  ///   StreamController<T> streamController;
  ///   streamController = new StreamController<T>(
  ///       onListen: () {
  ///         sad.disposable = observable.subscribe(
  ///             onNext: streamController.add,
  ///             onError: streamController.addError,
  ///             onCompleted: () {
  ///               streamController.close();
  ///             });
  ///       },
  ///       onCancel: sad.dispose);
  ///   return streamController.stream;
  /// }
  /// final myObservable = ...create observable...;
  /// final myStream = myObservable.convertAs(stream);
  /// ```
  /// This equals
  /// ```dart
  /// final myStream = myObservable.asStream();
  /// ```
  S convertAs<S>(ConvertFunction<T, S> convert) => convert(this);

  /// Subscribes to this observable using the [sink].
  ///
  /// Normally, event from onNext will be forwarded to [sink]'s add;
  /// the [sink] will be closed if any event comes from onError or onCompleted.
  ///
  /// If the [sink] is an instance of Dart EventSink, event from onError will
  /// be forwarded to [sink]'s addError, and then the [sink] will be closed.
  ///
  /// This method is a convenient way to connect this observable with a Dart
  /// Sink object, for example:
  ///
  /// ```dart
  /// var streamController = new StreamController();
  /// var observable = (...create observable...);
  /// observable.subscribeBySink(streamController);
  /// ```
  ///
  /// This method follows all contracts of [subscribeByObserver] method.
  Disposable subscribeBySink(Sink<T> sink) => subscribe(
      onNext: sink.add,
      onError: (error, [stackTrace]) {
        sink is EventSink
            ? ((sink as EventSink)
              ..addError(error, stackTrace)
              ..close())
            : sink.close();
      },
      onCompleted: sink.close);

  /// Dumps this observable to another data structure using the [convert]
  /// function.
  ///
  /// Compares with the [convertAs] function, the dumped data strucutre should
  /// have no relationship with this observable.
  ///
  /// # Example
  /// ```dart
  /// listFucture(Observable<T> observable) {
  ///   final completer = new Completer();
  ///   final list = [];
  ///   observable.subscribe(
  ///       onNext: list.add,
  ///       onComplete: () {
  ///         completer.complete(list);
  ///       });
  ///   return completer.future;
  /// }
  /// final myObservable = ...create observable...;
  /// final list = await myObservable.convertTo(listFucture);
  /// ```
  S convertTo<S>(ConvertFunction<T, S> convert) => convert(this);

  // -------------------------------------------------------------------
  // Converting to Stream api.
  // -------------------------------------------------------------------
  /// Returns a stream representation of this observable.
  Stream<T> asStream() {
    var sad = SingleAssignmentDisposable();
    StreamController<T> streamController;
    streamController = StreamController<T>(
        onListen: () {
          sad.disposable = subscribe(
              onNext: streamController.add,
              onError: streamController.addError,
              onCompleted: () {
                streamController.close();
              });
        },
        onCancel: sad.dispose);
    return streamController.stream;
  }

  // -------------------------------------------------------------------
  // ReactiveX operators.
  //
  // This section will implement operators described by
  // http://reactivex.io/documentation/operators.html
  // Some Dartlang specific apis are added to relative categories, and some
  // apis name may be variant.
  //
  // Note: keep name alphabetical order in each categories.
  // -------------------------------------------------------------------
  // ==== Aggregate ====
  /// Emits the events from this and [that] observable without interleaving.
  ///
  /// Note, [that] observable will only be subscribed once this observable is
  /// completed.
  ///
  /// # Example
  /// this: ----1----2----3-----4---|---------------------------
  /// that: ------------------------S--a----b----c----d--|------
  /// [                 this.concatWith(that)                  ]
  /// out : ----1----2----3-----4------a----b----c----d--|------
  ///
  /// See [concat operator in ReactiveX][rx-concat] for more details.
  ///
  /// [rx-concat]: http://reactivex.io/documentation/operators/concat.html
  Observable<T> concatWith(Observable<T> that) =>
      Observable((Observer<T> observer) {
        final thatDisposable = SingleAssignmentDisposable();
        final thisDisposable = subscribe(
            onNext: observer.sendNext,
            onError: observer.sendError,
            onCompleted: () {
              thatDisposable.disposable = that.subscribeByObserver(observer);
            });
        return CompositeDisposable([thisDisposable, thatDisposable]);
      })
        ..name = '$name.concatWith($that)';

  /// Concats all [observables] by reducing them using [concatWith] operator.
  ///
  /// See [concatWith] operator for more details.
  /// See [concat operator in ReactiveX][rx-concat] for more details.
  ///
  /// [rx-concat]: http://reactivex.io/documentation/operators/concat.html
  factory Observable.concat(List<Observable<T>> observables) =>
      observables.fold(
          Observable<T>.empty(),
          (Observable<T> prevValue, Observable<T> element) =>
              prevValue.concatWith(element))
        ..name = 'concat($observables)';

  // ==== Combining ====
  /// Takes the latest events from this and [thatObservable], then combines
  /// them using the provided [CombineFunction].
  ///
  /// If no [CombineFunction] is provided, returns a list of this observable's
  /// latest value and that observable's latest value.
  ///
  /// # Example
  /// src1: ----1--------2--------3--------4--------5-----|-------
  /// src2: -------a--b-----c-----d-----e--------------f---g----|-
  /// [             src1.combineLatestWith(src2)                 ]
  /// out : -------1a-1b-2b-2c----3d----3e-4e-------5e-5f--5g---|-
  ///
  /// See [combineLatest operator in ReactiveX][rx-combinelatest]
  /// for more details.
  ///
  /// [rx-combinelatest]: http://reactivex.io/documentation/operators/combinelatest.html
  Observable<O> combineLatestWith<S, O>(Observable<S> thatObservable,
      [CombineFunction<T, S, O> combiner]) {
    return Observable((Observer<O> observer) {
      T capturedThisValue;
      var didCaptureThisValue = false;
      var didThisComplete = false;
      S capturedThatValue;
      var didCaptureThatValue = false;
      var didThatComplete = false;
      void maySendNext() {
        if (didCaptureThisValue && didCaptureThatValue) {
          observer.sendNext(combiner == null
              ? [capturedThisValue, capturedThatValue]
              : combiner(capturedThisValue, capturedThatValue));
        }
      }

      void maySendCompleted() {
        if (didThisComplete && didThatComplete) {
          observer.sendCompleted();
        }
      }

      var thisSad = SingleAssignmentDisposable();
      var thatSad = SingleAssignmentDisposable();
      thisSad.disposable = subscribe(onNext: (T data) {
        capturedThisValue = data;
        didCaptureThisValue = true;
        maySendNext();
      },
          //onError: _sendErrorAndDispose(observer, thatSad),
          onCompleted: () {
        didThisComplete = true;
        maySendCompleted();
      });
      thatSad.disposable = thatObservable.subscribe(onNext: (S data) {
        capturedThatValue = data;
        didCaptureThatValue = true;
        maySendNext();
      },
          //onError: _sendErrorAndDispose(observer, thisSad),
          onCompleted: () {
        didThatComplete = true;
        maySendCompleted();
      });
      return CompositeDisposable([thisSad, thatSad]);
    })
      ..name = '$name.combineLatestWith($thatObservable)';
  }

  /// Combines the latest events from all [observables].
  ///
  /// see [combineLatestWith] for more details.
  /// See [combineLatest operator in ReactiveX][rx-combinelatest]
  /// for more details.
  ///
  /// [rx-combinelatest]: http://reactivex.io/documentation/operators/combinelatest.html
  static Observable<List<T>> combineLatest<T>(
          Iterable<Observable<T>> observables) =>
      observables.fold(
          Observable<List<T>>.just([]),
          (Observable<List<T>> prevValue, Observable<T> element) =>
              prevValue.combineLatestWith<T, List<T>>(element,
                  (combined, element) => List.from(combined)..add(element)))
        ..name = 'combineLatest($observables)';

  /// Merges the events from this and [thatObservable] into a single
  /// observable.
  ///
  /// # Example
  /// src1: ----1--------2-----------4--------5-----|-------
  /// src2: -------a--b-----c-----e--------------f---g----|-
  /// [               src1.mergeWith(src2)                 ]
  /// out : ----1--a--b--2--c----e---4--------5--f---g----|-
  ///
  /// See [merge operator in ReactiveX][rx-merge] for more details.
  ///
  /// [rx-merge]: http://reactivex.io/documentation/operators/merge.html
  Observable<T> mergeWith(Observable<T> that) =>
      Observable((Observer<T> observer) {
        var didThisComplete = false;
        var didThatComplete = false;
        var thisDisposable = SingleAssignmentDisposable();
        var thatDisposable = SingleAssignmentDisposable();
        void maySendCompleted() {
          if (didThisComplete && didThatComplete) {
            observer.sendCompleted();
          }
        }

        thisDisposable.disposable = subscribe(
            onNext: observer.sendNext,
            //onError: _sendErrorAndDispose(observer, thatDisposable),
            onCompleted: () {
              didThisComplete = true;
              maySendCompleted();
            });
        thatDisposable.disposable = that.subscribe(
            onNext: observer.sendNext,
            //onError: _sendErrorAndDispose(observer, thisDisposable),
            onCompleted: () {
              didThatComplete = true;
              maySendCompleted();
            });
        return CompositeDisposable([thisDisposable, thatDisposable]);
      })
        ..name = '$name.mergeWith($that)';

  /// Merges the events from all [observables].
  ///
  /// see [mergeWith] for more details.
  /// See [merge operator in ReactiveX][rx-merge] for more details.
  ///
  /// [rx-merge]: http://reactivex.io/documentation/operators/merge.html
  factory Observable.merge(List<Observable<T>> observables) => observables.fold(
      Observable<T>.empty(),
      (Observable<T> prevValue, Observable<T> element) =>
          prevValue.mergeWith(element))
    ..name = 'merge($observables)';

  /// Emits a specified sequence before beginning to emit from this.
  ///
  /// # Example
  /// src: --------a-------b-----c-----d-----------------|------
  /// [                src.startWith([1, 2, 3])                ]
  /// out: -1-2-3--a-------b-----c-----d-----------------|------
  ///
  /// See [startWith operator in ReactiveX][rx-startwith] for more details.
  ///
  /// [rx-startwith]: http://reactivex.io/documentation/operators/startwith.html
  Observable<T> startWith(List<T> values) =>
      Observable.fromValues(values).concatWith(this)
        ..name = '$name.startWith($values)';

  /// Emits the specified [value] before beginning to emit from this.
  ///
  /// # Example
  /// src: --------a-------b-----c-----d-----------------|------
  /// [                src.startWithSingle(1)                ]
  /// out: -1------a-------b-----c-----d-----------------|------
  ///
  /// See [startWith operator in ReactiveX][rx-startwith] for more details.
  ///
  /// [rx-startwith]: http://reactivex.io/documentation/operators/startwith.html
  Observable<T> startWithSingle(T value) =>
      Observable.fromValues([value]).concatWith(this)
        ..name = '$name.startWithSingle($value)';

  /// Takes the event sequences from the last emitted observable.
  ///
  /// This operator requires that this observable emits observables. The
  /// returned observable only emits event from the most-recently-emitted inner
  /// observable.
  ///
  /// # Example
  /// src: --in1----------in2-------------------in3 ---|----------
  /// in1: --------1------X--?------?---------?--------|----------
  /// in2: ---------------a------------b--------X---------?-|-----
  /// in3: ----------------------------------------x-y-z---|------
  /// [                   src.switchLatest()                     ]
  /// out: --------1------a------------b-----------x-y-z---|------
  ///
  /// Where 'X' means the inner observable should be `dispose`d, and '?' means
  /// the future event will not be received by the inner observer.
  ///
  /// See [switch operator in ReactiveX][rx-switch] for more details.
  ///
  /// [rx-switch]: http://reactivex.io/documentation/operators/switch.html
  Observable<S> switchLatest<S>() => Observable((Observer<S> observer) {
        var outerCompleted = false;
        var isLastInnerAlive = false;
        void maySendCompleted() {
          if (outerCompleted && !isLastInnerAlive) {
            observer.sendCompleted();
          }
        }

        SerialDisposable innerSd = SerialDisposable();
        var outerSad = SingleAssignmentDisposable();
        outerSad.disposable = subscribe(onNext: (T data) {
          //_checkIsObservable('switchLatest', data);
          isLastInnerAlive = false;
          innerSd.disposable = (data as Observable<S>).subscribe(
              onNext: observer.sendNext,
              //onError: _sendErrorAndDispose(observer, outerSad),
              onCompleted: () {
                isLastInnerAlive = false;
                maySendCompleted();
              });
          isLastInnerAlive = true;
        },
            //onError: _sendErrorAndDispose(observer, innerSd),
            onCompleted: () {
          outerCompleted = true;
          maySendCompleted();
        });
        return CompositeDisposable([outerSad, innerSd]);
      })
        ..name = '$name.switchLatest()';

  /// Emits event which is reduced from latest event of this observable and
  /// given [observable] at the time this observable emits an event.
  ///
  /// If [reducer] is provided, it will be used to convert the last from this
  /// observable and last value from [observable] into target value; otherwise
  /// the returned value is a two elements list which contains this last value
  /// and [observable] last value.
  ///
  /// # Example
  /// src1: ----1--------2--------3--4-----5--------6-----|-------
  /// src2: -------a--b-----c-----d-----e--------------f---g----|-
  /// [                src1.withLatestFrom(src2)                 ]
  /// out : -------------2b-------3d-4d----5e-------6e----|-------
  ///
  /// See [withLatestFrom in RxJs][rxjs-withlatestfrom] for more details.
  ///
  /// [rxjs-withlatestfrom]: https://github.com/Reactive-Extensions/RxJS/blob/master/doc/api/core/operators/withlatestfrom.md
  Observable<O> withLatestFrom<S, O>(Observable<S> observable,
          [O reducer(T thisValue, S thatValue)]) =>
      Observable((Observer<O> observer) {
        var didCaptureThat = false;
        S capturedThat;
        var thisSad = SingleAssignmentDisposable();
        var thatSad = SingleAssignmentDisposable();
        void onNextThis(T data) {
          observer.sendNext((reducer == null
              ? [data, capturedThat]
              : reducer(data, capturedThat)) as O);
        }

//        Function clearSendErrorThenDispose(Disposable disposable) =>
//            _sendErrorAndDispose(observer, () {
//              didCaptureThat = false;
//              capturedThat = null;
//              disposable.dispose();
//            });
        thatSad.disposable = observable.subscribe(onNext: (S data) {
          didCaptureThat = true;
          capturedThat = data;
        },
            //onError: clearSendErrorThenDispose(thisSad),
            onCompleted: () {
          if (!didCaptureThat) {
            // Optimization: if observable has not fired anything,
            // dispose this observable as well since the returned
            // observable will never fire anything.
            thisSad.dispose();
            observer.sendCompleted();
          }
        });
        thisSad.disposable = filter((_) => didCaptureThat).subscribe(
            onNext: onNextThis,
            //onError: clearSendErrorThenDispose(thatSad),
            onCompleted: () {
              capturedThat = null;
              thatSad.dispose();
              observer.sendCompleted();
            });
        return CompositeDisposable([thisSad, thatSad]);
      })
        ..name = '$name.withLatestFrom($observable, $reducer)';

  // ==== Connectable ====
  /// Let [subject] subscribe to this observable if the returned connection
  /// is connected.
  ///
  /// # Example
  ///
  /// # Code
  /// ```dart
  /// var subject = (... create subject ...);
  /// var multicasted = new Observable((observer) {
  ///   print('subscribed');
  ///   observer.sendNext(1);
  ///   observer.sendCompleted();
  /// }).multicast(subject);
  ///
  /// multicasted.observable.subscribeByObserver(observer1);
  /// multicasted.observable.subscribeByObserver(observer2);
  /// subject.subscribeByObserver(observer3);
  ///
  /// multicasted.connect(); // 'subscribed' is printed, observers receive 1.
  /// ```
  ///
  /// ## Timeline
  /// src: -----------------------[onSubscribe]------------------
  /// [                src.multicast(subject)                   ]
  /// con: -----------------------[connect]----------------------
  /// ob1: ---[subscribe]----------------------------------------
  /// ob2: ---------[subscribe]----------------------------------
  /// ob3: -----------[subscribe subject]------------------------
  /// ob4: -------------------------------------[subscribe]------
  ///
  /// See [publish operator in ReactiveX](rx-publish) for more details.
  ///
  /// [rx-publish]: http://reactivex.io/documentation/operators/publish.html
  Connectable<T> multicast(Subject<T> subject) =>
      Connectable._(this, subject)..name = '$name.multicast($subject)';

  /// Creates a subject and [multicast]s this observable to it.
  ///
  /// See [multicast] method for more details.
  /// See [publish operator in ReactiveX](rx-publish) for more details.
  ///
  /// [rx-publish]: http://reactivex.io/documentation/operators/publish.html
  Connectable<T> publish() => multicast(Subject<T>())..name = '$name.publish()';

  /// Creates a subject using [Subject.replay] factory and [multicast]s
  /// this observable to it.
  ///
  /// See [Subject.replay] factory for more details about the parameters.
  /// See [multicast] method for more details.
  /// See [publish operator in ReactiveX](rx-publish) for more details.
  /// See [replay operator in ReactiveX](rx-replay) for more details.
  ///
  /// [rx-publish]: http://reactivex.io/documentation/operators/publish.html
  /// [rx-replay]: http://reactivex.io/documentation/operators/replay.html
  Connectable<T> publishReplay(
          {bool shouldReplayAll = false,
          int bufferSize = 1,
          Iterable<T> initValues = const []}) =>
      multicast(Subject<T>.replay(
          shouldReplayAll: shouldReplayAll,
          bufferSize: bufferSize,
          initValues: initValues))
        ..name = '$name.publishReplay(shouldReplayAll: $shouldReplayAll, '
            'bufferSize: $bufferSize, initValues: $initValues)';

  /// [publish]s this observable and then chain with [refCount].
  ///
  /// See [publish] for more details.
  /// See [Connectable refCount] for more details.
  //
  // TODO(kismet):
  // Revisits this operator to decide whether it should depend on the
  // reference count. See
  // [the RxJs5 shareReplay issue][rxjs-5-share-replay-issue] for more details.
  //
  // [rxjs-5-share-replay-issue]: https://github.com/ReactiveX/rxjs/issues/3127
  Observable<T> share() => publish().refCount()..name = '$name.share()';

  /// [publishReplay]s this observable and then chain with [refCount].
  ///
  /// This is a convenience method since `publishReplay().refCount()` is widely
  /// used in code.
  ///
  /// See [publishReplay] for more details.
  /// See [Connectable refCount] for more details.
  //
  // TODO(kismet):
  // Revisits this operator to decide whether it should depend on the
  // reference count. See
  // [the RxJs5 shareReplay issue][rxjs-5-share-replay-issue] for more details.
  //
  // [rxjs-5-share-replay-issue]: https://github.com/ReactiveX/rxjs/issues/3127
  Observable<T> shareReplay(
          {bool shouldReplayAll = false,
          int bufferSize = 1,
          Iterable<T> initValues = const []}) =>
      publishReplay(
              shouldReplayAll: shouldReplayAll,
              bufferSize: bufferSize,
              initValues: initValues)
          .refCount()
            ..name = '$name.shareReplay('
                'shouldReplayAll: $shouldReplayAll, '
                'bufferSize: $bufferSize, initValues: $initValues)';

  // ==== Creating ====
  /// Creates a new observable using [observableCreator] for each subscription
  /// on the returned observable.
  ///
  /// See [defer operator in ReactiveX][rx-defer] for more details.
  ///
  /// [rx-defer]: http://reactivex.io/documentation/operators/defer.html
  factory Observable.defer(Observable<T> observableCreator()) =>
      Observable((Observer<T> observer) =>
          observableCreator().subscribeByObserver(observer))
        ..name = 'defer($observableCreator)';

  /// Creates an instance of Observable which will complete automatically
  /// without emitting any event.
  ///
  /// See:
  /// http://reactivex.io/documentation/operators/empty-never-throw.html
  factory Observable.empty() => Observable((Observer<T> observer) {
        observer.sendCompleted();
        return Disposable.noop;
      })
        ..name = 'empty()';

  /// Creates an instance of Observable from the given [future].
  ///
  /// There is no official ReactiveX operator for this, it is similar to
  /// RxJs's fromPromise:
  /// https://github.com/Reactive-Extensions/RxJS/blob/master/doc/api/core/operators/frompromise.md
  factory Observable.fromFuture(Future<T> future) =>
      Observable((Observer<T> observer) {
        // Note, need the CheckableDisposable since we are not able to stop
        // the computation in the closure of 'Future.then', so need to check
        // the status of disposable to decide whether we should feed observer.
        var disposable = CheckableDisposable();
        future.then((data) {
          if (!disposable.disposed) {
            observer.sendNext(data);
            observer.sendCompleted();
          }
        }, onError: (error, [stackTrace]) {
          if (!disposable.disposed) observer.sendError(error, stackTrace);
        });
        return disposable;
      })
        ..name = 'fromFuture($future)';

  /// Creates an instance of Observable from the given [stream].
  ///
  /// Note, by the contract of Observable, the returned instance will terminate
  /// if any error emitted by the [stream]. If you want to receive events after
  /// the error, use the materializeFromStream method instead.
  ///
  /// CONTRACT:
  /// - Given Observable is multicasted, so it will make
  ///   [stream].asBroadcastStream() if it is not a broadcast one.
  /// - Subscription on the returned Observable will terminate at the first
  ///   error emitted by the [stream].
  factory Observable.fromStream(Stream<T> stream) {
    var broadcastStream =
        stream.isBroadcast ? stream : stream.asBroadcastStream();
    return Observable((Observer<T> observer) => Disposable(broadcastStream
        .listen(observer.sendNext,
            onError: observer.sendError, onDone: observer.sendCompleted)
        .cancel))
      ..name = 'fromStream($stream)';
  }

  /// Creates an instance of Observable from the given [values].
  ///
  /// See:
  /// http://reactivex.io/documentation/operators/from.html
  factory Observable.fromValues(Iterable<T> values) {
    var copied = values.toList(growable: false);
    return Observable((Observer<T> observer) {
      copied.forEach(observer.sendNext);
      observer.sendCompleted();
      return Disposable.noop;
    })
      ..name = 'fromValues($values)';
  }

  /// Creates an instance of Observable from the given single [value].
  ///
  /// See:
  /// http://reactivex.io/documentation/operators/just.html
  factory Observable.just(T value) =>
      Observable.fromValues([value])..name = 'just($value)';

  /// Creates an instance of Observable which never emits any event.
  ///
  /// See:
  /// http://reactivex.io/documentation/operators/empty-never-throw.html
  factory Observable.never() =>
      Observable((_) => Disposable.noop)..name = 'never()';

  // ==== Error Handling ====
  /// Returns a new observable which will resubscribe to [this] observable when
  /// [this] emits any error, and the error won't be passed to observer.
  ///
  /// The resubscribe only happens [maxAttempts] times, if error still occurs in
  /// the last subscription, error will be passed to observer.
  ///
  /// If `[maxAttempts] < 0`, this retry will be infinit.
  /// If [shouldRetry] exists, it will be used to decide whether the error
  /// match the predication and retry if it is.
  ///
  /// # Example
  /// src: -----1--2--ES----3--4--ES----5--6--7--E---------------
  /// [                src.retry(maxAttempts: 2)                ]
  /// out: -----1--2--------3--4--------5--6--7--E---------------
  /// E: error
  /// S: subscribe
  ///
  /// See [retry operator in ReactiveX][rx-retry] for more details.
  ///
  /// [rx-retry]: http://reactivex.io/documentation/operators/retry.html
  //
  // TODO(kismet): implements [retryWhen] operator so that we don't need the
  // [shouldRetry] and [delay] parameter. But also need to either implement
  // the [zip] operator or change [scan] operator (to try/catch exception) to
  // simulate the [maxAttempts] behavior.
  Observable<T> retry(
          {int maxAttempts = 1,
          bool shouldRetry(Object object, [StackTrace stackTrace]),
          Duration delay(int attempted, Object error, [StackTrace stackTrace]),
          Scheduler scheduler}) =>
      Observable((Observer<T> observer) {
        var attempts = 0;
        scheduler ??= Scheduler.defaultScheduler;
        final cd = CompositeDisposable();
        final scheduleSad = SingleAssignmentDisposable();
        cd.add(scheduleSad);
        scheduleSad.disposable = scheduler.scheduleRecursiveDelay((reschedule) {
          final sad = SingleAssignmentDisposable();
          cd.add(sad);
          sad.disposable = subscribe(
              onNext: observer.sendNext,
              onError: (error, [stackTrace]) {
                void close() {
                  observer.sendError(error, stackTrace);
                  cd.dispose();
                }

                if (maxAttempts >= 0 && attempts == maxAttempts) {
                  close();
                } else {
                  if (shouldRetry == null || shouldRetry(error, stackTrace)) {
                    ++attempts;
                    final delayDuration = delay == null
                        ? null
                        : delay(attempts, error, stackTrace);
                    cd.remove(sad);
                    reschedule(delayDuration);
                  } else {
                    close();
                  }
                }
              },
              onCompleted: () {
                observer.sendCompleted();
                cd.dispose();
              });
        });
        return cd;
      })
        ..name = '$name.retry(maxAttempts: $maxAttempts, '
            'shouldRetry: $shouldRetry, delay: $delay, '
            'scheduler: $scheduler)';

  // TODO(kismet): implement [retryWhen] operator.
  // Observable<T> retryWhen(
  //         Observable Function(Observable<Object>) errorTriggerFactory);
  // ==== Filtering ====
  /// Only emits an item from this Observable if [duration] has passed without
  /// emitting another item.
  ///
  /// If given, [scheduler] will be used to defer the emission of items.
  ///
  /// # Example (each dash represents a second in the timeline).
  /// src: ----1--------2--3-4-5----------6------------7-|-------
  /// [         src.debounce(new Duration(seconds: 5))          ]
  /// out: ---------1---------------5----------6---------7|------
  ///
  /// See [debounce operator in ReactiveX][rx-debounce] for more details.
  ///
  /// [rx-debounce]: http://reactivex.io/documentation/operators/debounce.html
  Observable<T> debounce(Duration duration, {Scheduler scheduler}) =>
      Observable((Observer<T> observer) {
        scheduler ??= Scheduler.defaultScheduler;
        var hasLastValue = false;
        T lastData;
        var delaySd = SerialDisposable();
        var disposable = subscribe(onNext: (T data) {
          hasLastValue = true;
          lastData = data;
          delaySd.disposable = scheduler.scheduleDelay(duration, () {
            observer.sendNext(data);
            hasLastValue = false;
          });
        },
            //onError: _sendErrorAndDispose(observer, delaySd),
            onCompleted: () {
          // Cancel delayed 'sendNext' and emit the last data immediately.
          delaySd.dispose();
          // TODO(kismet): revisit potential threading issue.
          if (hasLastValue) observer.sendNext(lastData);
          observer.sendCompleted();
        });
        return CompositeDisposable([disposable, delaySd]);
      })
        ..name = '$name.debounce($duration, scheduler: $scheduler)';

  /// Drops events if they are equal to the previous event.
  ///
  /// If the [comparator] is not null, this method will use
  /// `comparator(currentEvent, prevEvent) == 0` to check whether the
  /// `currentEvent` is equal to `prevEvent`; otherwise, this method will use
  /// `currentEvent == prevEvent` to do the checking.
  ///
  /// # Example
  /// src: ----1---2---2---1---3---4---3---3---3---5-----|-------
  /// [             src.distinctUntilChanged()                  ]
  /// out: ----1---2-------1---3---4---3-----------5-----|-------
  ///
  /// See [the distinct operator in ReactiveX][rx-distinct] and
  /// [the distinctUntilChanged variant][rx-distinctUntilChanged]
  /// for more details.
  ///
  /// [rx-distinct]: http://reactivex.io/documentation/operators/distinct.html
  /// [rx-distinctUntilChanged]: http://rxmarbles.com/#distinctUntilChanged
  Observable<T> distinctUntilChanged([Comparator<T> comparator]) {
    isEqual(T a, T b) => comparator == null ? a == b : comparator(a, b) == 0;
    return Observable((Observer<T> observer) {
      T prevEvent;
      var isFirstEvent = true;
      return subscribe(
          onNext: (T data) {
            if (isFirstEvent || !isEqual(data, prevEvent)) {
              isFirstEvent = false;
              prevEvent = data;
              observer.sendNext(data);
            }
          },
          onError: observer.sendError,
          onCompleted: observer.sendCompleted);
    })
      ..name = '$name.distinctUntilChanged($comparator)';
  }

  /// Emits only the first item from this observable and completes immediately.
  ///
  /// # Example
  /// src: --------a-------b-----c-----d-----------------|------
  /// [                       src.first()                      ]
  /// out: --------a|-------------------------------------------
  ///
  /// See [the first operator in ReactiveX][rx-first] for more details.
  ///
  /// [rx-first]: http://reactivex.io/documentation/operators/first.html
  Observable<T> first() => take(1)..name = '$name.first()';

  /// Emits only the first [n] items emitted by this Observable and then
  /// completes while ignoring the remainder.
  ///
  /// The filtered Observable terminates and releases the subscription on this
  /// Observable once the [n]th item is emitted.
  ///
  /// # Example
  /// src: --------a-------b-----c-----d-----------------|------
  /// [                       src.take(3)                      ]
  /// out: --------a-------b-----c|-----------------------------
  ///
  /// See [the take operator in ReactiveX][rx-take] for more details.
  ///
  /// [rx-take]: http://reactivex.io/documentation/operators/take.html
  Observable<T> take(int n) {
    checkArgument(n >= 0,
        message: 'Observable.take(int n) does not accept negative $n');
    return n == 0
        ? Observable.empty()
        : Observable((Observer<T> observer) {
            final sad = SingleAssignmentDisposable();
            var localN = n;
            sad.disposable = subscribe(
                onNext: (T data) {
                  if (localN-- > 0) observer.sendNext(data);
                  if (localN <= 0) {
                    observer.sendCompleted();
                    sad.dispose();
                  }
                },
                onError: observer.sendError,
                onCompleted: observer.sendCompleted);
            return sad;
          })
      ..name = '$name.take($n)';
  }

  /// Emits only the last [n] items emitted by this Observable and ignores
  /// those items that come before them.
  /// The filtered Observable emits all items immediately after this Observable
  /// completes.
  ///
  /// # Example
  /// src: --------a-------b-----c-----d-----|------------------
  /// [                     src.takeLast(3)                    ]
  /// out: -----------------------------------bcd|--------------
  ///
  /// See [the takeLast operator in ReactiveX][rx-take-last] for more details.
  ///
  /// [rx-take-last]: http://reactivex.io/documentation/operators/takelast.html
  Observable<T> takeLast(int n) {
    checkArgument(n >= 0,
        message: 'Observable.takeLast(int n) does not accept negative $n');
    return n == 0
        ? Observable.empty()
        : Observable((Observer<T> observer) {
            var pool = Queue<T>();
            return subscribe(onNext: (T data) {
              if (pool.length == n) pool.removeFirst();
              pool.addLast(data);
            },
                //onError: _sendErrorAndDispose(observer, pool.clear),
                onCompleted: () {
              pool.forEach(observer.sendNext);
              pool.clear();
              observer.sendCompleted();
            });
          })
      ..name = '$name.takeLast($n)';
  }

  /// Keeps the next event only if it can pass the [predicate] checking.
  ///
  /// # Example
  /// src: ----1--------2--------3--------4--------5-----|-------
  /// [           src.filter((d) => d % 2 == 0)                 ]
  /// out: -------------2-----------------4--------------|-------
  ///
  /// See [the filter operator in ReactiveX][rx-filter] for more details.
  ///
  /// [rx-filter]: http://reactivex.io/documentation/operators/filter.html
  Observable<T> filter(bool predicate(T data)) =>
      Observable((Observer<T> observer) => subscribe(
          onNext: (T data) {
            if (predicate(data)) observer.sendNext(data);
          },
          onError: observer.sendError,
          onCompleted: observer.sendCompleted))
        ..name = '$name.filter($predicate)';

  /// Skips the first [n] events.
  ///
  /// # Example
  /// src: ----1--------2--------3--------4--------5-----|-------
  /// [                      src.skip(2)                        ]
  /// out: ----------------------3--------4--------5-----|-------
  ///
  /// See [the skip operator in ReactiveX][rx-skip] for more details.
  ///
  /// [rx-skip]: http://http://reactivex.io/documentation/operators/skip.html
  Observable<T> skip(int n) {
    checkArgument(n >= 0,
        message: 'Observable.skip(int n) does not accept negative $n');
    return n == 0
        ? this
        : Observable((Observer<T> observer) {
            final sad = SingleAssignmentDisposable();
            var localN = n;
            sad.disposable = subscribe(
                onNext: (T data) {
                  if (localN == 0) {
                    observer.sendNext(data);
                  } else {
                    localN--;
                  }
                },
                onError: observer.sendError,
                onCompleted: observer.sendCompleted);
            return sad;
          })
      ..name = '$name.skip($n)';
  }

  // ==== Transforming ====
  /// Creates an observable that batches emission of items from the source.
  ///
  /// If [drainOnCompleted] is true, the returned observable will emit
  /// the last buffer when the source is completed, even if the buffer does not
  /// have [bufferSize] data. Otherwise, it will drop the remaining buffer.
  ///
  /// # Example 1
  /// src: ----1--------2--------3--------4--------5-----|-------
  /// [                     src.buffer(2)                       ]
  /// out: -------------[1,2]-------------[3,4]----------|-------
  ///
  /// # Example 2
  /// src: ----1--------2--------3--------4--------5-----|-------
  /// [          src.buffer(2, drainOnCompleted:true)           ]
  /// out: -------------[1,2]-------------[3,4]----------[5]|----
  ///
  /// See [buffer operator in ReactiveX][rx-buffer] for more details.
  ///
  /// [rx-buffer]: http://reactivex.io/documentation/operators/buffer.html
  Observable<List<T>> buffer(int bufferSize, {bool drainOnCompleted = true}) {
    assert(bufferSize > 1);
    return Observable((Observer<List<T>> observer) {
      var buffer = <T>[];
      return subscribe(onNext: (T data) {
        buffer.add(data);
        if (buffer.length == bufferSize) {
          var tempBuffer = buffer;
          buffer = <T>[];
          observer.sendNext(tempBuffer);
        }
      }, onError: (error, [stackTrace]) {
        buffer = null;
        observer.sendError(error, stackTrace);
      }, onCompleted: () {
        if (drainOnCompleted && buffer.isNotEmpty) {
          var tempBuffer = buffer;
          buffer = null;
          observer.sendNext(tempBuffer);
        }
        observer.sendCompleted();
      });
    })
      ..name = '$name.buffer($bufferSize, drainOnCompleted: $drainOnCompleted)';
  }

  /// Applies [map] operator to this using [convert] function, and then applies
  /// [flatten] operator.
  ///
  /// See [map] and [flatten] operator for more details.
  ///
  /// See [flatMap operator in ReactiveX][rx-flatmap] for more details.
  ///
  /// [rx-flatmap]: http://reactivex.io/documentation/operators/flatmap.html
  Observable<S> flatMap<S>(Observable<S> convert(T data)) =>
      (map<Observable<S>>(convert).flatten<S>()
        ..name = '$name.flatMap($convert)');

  /// Flattens the observables emitted by this observable into one observable.
  ///
  /// This assumes each event emitted by this observable is an instance of
  /// Observable. Once an new inner observable comes in, the inner observable
  /// will be subscribed immediately.
  ///
  /// The returned observable merges all events of each inner observable.
  /// The sequences of inner observables may interleave.
  ///
  /// # Example
  /// src: --in1----------in2-------------------in3 ---|----------
  /// in1: --------1--------2-------3---------4--------|----------
  /// in2: ---------------a------------b--------c---------d--e--|-
  /// in3: ----------------------------------------x-y-z-|--------
  /// [                      src.flatten()                       ]
  /// out: --------1------a-2-------3--b------4-c--x-y-z--d--e--|-
  ///
  /// See [flatMap operator in ReactiveX][rx-flatmap] for more details.
  ///
  /// [rx-flatmap]: http://reactivex.io/documentation/operators/flatmap.html
  Observable<S> flatten<S>() => Observable((Observer<S> observer) {
        var cd = CompositeDisposable();
        var sad = SingleAssignmentDisposable();
        var outerCompleted = false;
        var innerAliveCount = 0;
        void maySendCompleted() {
          if (outerCompleted && innerAliveCount == 0) {
            observer.sendCompleted();
          }
        }

        sad.disposable = subscribe(onNext: (T data) {
          //_checkIsObservable('flatten', data);
          var innerObservable = data as Observable<S>;
          ++innerAliveCount;
          var innerSad = SingleAssignmentDisposable();
          cd.add(innerSad);
          innerSad.disposable = innerObservable.subscribe(
              onNext: observer.sendNext,
//                  onError: _sendErrorAndDispose(observer, () {
//                    sad.dispose();
//                    (cd..remove(innerSad)).dispose();
//                  }),
              onCompleted: () {
                cd.remove(innerSad);
                --innerAliveCount;
                maySendCompleted();
              });
        },
            //onError: _sendErrorAndDispose(observer, cd),
            onCompleted: () {
          outerCompleted = true;
          maySendCompleted();
        });
        return CompositeDisposable([sad, cd]);
      })
        ..name = '$name.flatten()';

  /// Returns a new observable which emits next event which is [convert]ed from
  /// the next event emitted by this observable.
  ///
  /// Error and completed event of this observable will be passed to the
  /// returned observable directly.
  ///
  /// # Example
  /// src: --------1--------2--------3--------4--------|----------
  /// [               src.map((data) => data * 2)                ]
  /// out: --------2--------4--------6--------8--------|----------
  ///
  /// See [map operator in ReactiveX][rx-map] for more details.
  ///
  /// [rx-map]: http://reactivex.io/documentation/operators/map.html
  Observable<S> map<S>(S convert(T data)) =>
      Observable((Observer<S> observer) => subscribe(
          onNext: (T data) {
            observer.sendNext(convert(data));
          },
          onError: observer.sendError,
          onCompleted: observer.sendCompleted))
        ..name = '$name.map($convert)';

  /// Creates an observable which gathers items emitted by source into
  /// fixed-length lists and emit these lists instead.
  ///
  /// src: --------1--------2--------3--------4--------5--------
  /// [                          ngram:3                       ]
  /// out: --------[/,/,1]--[/,1,2]--[1,2,3]--[2,3,4]--[3,4,5]--
  Observable<List<T>> nGram(int count) {
    checkArgument(count > 1);
    return Observable((Observer<List<T>> observer) {
      final buffer = Queue<T>()..addAll(List.generate(count, (_) => null));
      return subscribe(
          onNext: (T data) {
            buffer.addLast(data);
            buffer.removeFirst();
            observer.sendNext(buffer.toList());
          },
          onError: observer.sendError,
          onCompleted: observer.sendCompleted);
    })
      ..name = '$name.nGram($count)';
  }

  /// Returns a new Observable which emits the next item by applying
  /// [accumulator] to its last emission and the next emission of this
  /// Observable.
  ///
  /// [seed] is the value to be sent together with the first emission of this
  /// observable to the [accumulator]. [accumulator] should be able to handle
  /// the case when parameters are null.
  ///
  /// # Example
  /// src: --------1--------2--------3--------4--------|----------
  /// [                 src.scan((x, y) => x + y)                ]
  /// out: --------1--------3--------6--------10-------|----------
  ///
  /// See [ReactiveX Scan operator][rx-scan] for more details.
  ///
  /// [rx-scan]: http://reactivex.io/documentation/operators/scan.html
  Observable<S> scan<S>(S accumulator(S a, T b), [S seed]) =>
      Observable((Observer<S> observer) {
        var accumulated = seed;
        return this.subscribe(onNext: (T data) {
          accumulated = accumulator(accumulated, data);
          observer.sendNext(accumulated);
        },
//            onError: _sendErrorAndDispose(observer, () {
//              accumulated = null;
//            }),
            onCompleted: () {
          observer.sendCompleted();
          accumulated = null;
        });
      })
        ..name = '$name.scan()';

  // ==== Utility ====
  /// Shifts the emissions from an Observable forward in time by [duration].
  ///
  /// The shifting will be scheduled using [scheduler], if it is null, the
  /// [Scheduler.defaultScheduler] will be used.
  ///
  /// # Example
  /// src: --------1--2--3--4---------|---------------------------
  /// [                   src.delay(3 seconds)                   ]
  /// out: -----------1--2--3--4---------|------------------------
  ///
  /// Note: the error will be passed to the result immediately without
  /// scheduling.
  ///
  /// See the [delay operator in ReactiveX][rx-delay] for more details.
  ///
  /// [rx-delay]: http://reactivex.io/documentation/operators/delay.html
  Observable<T> delay(Duration duration, {Scheduler scheduler}) =>
      Observable((Observer<T> observer) {
        scheduler ??= Scheduler.defaultScheduler;
        final delayCd = CompositeDisposable();
        void scheduleAction(void action()) {
          final scheduledSad = SingleAssignmentDisposable();
          scheduledSad.disposable = scheduler.scheduleDelay(duration, () {
            delayCd.remove(scheduledSad);
            action();
          });
          delayCd.add(scheduledSad);
        }

        final disposable = subscribe(onNext: (T data) {
          scheduleAction(() {
            observer.sendNext(data);
          });
        },
            //onError: _sendErrorAndDispose(observer, delayCd),
            onCompleted: () {
          // TODO(kismet): revisit potential threading issue.
          scheduleAction(() {
            observer.sendCompleted();
            delayCd.dispose();
          });
        });
        return CompositeDisposable([disposable, delayCd]);
      })
        ..name = '$name.delay($duration, scheduler: $scheduler)';

  /// Creates an observable which will start firing an event every [period]
  /// interval when subscribed.
  ///
  /// The event is an incrementing integer. The first event will be 0, second
  /// will be 1, etc.
  ///
  /// See [interval operator in ReactiveX][rx-interval] for more details.
  ///
  /// [rx-interval]: http://reactivex.io/documentation/operators/interval.html
  static Observable<int> interval(Duration period, {Scheduler scheduler}) =>
      Observable.timer(period: period, scheduler: scheduler)
          .map((_) => 1)
          .scan((a, b) => (a ?? -1) + b)
            ..name = 'interval($period, scheduler: $scheduler)';

  /// Creates an observable using a timer.
  ///
  /// *After being subscribed*, the returned observable will fire the first
  /// event after [delay], and then repeatedly fire an event every [period],
  /// until the optional deadline ([until]) is exceeded.
  ///
  /// The event is the [Duration] between the time when the observable is
  /// [subscribe]d and the time when the event is fired.
  ///
  /// See [timer operator in ReactiveX][rx-timer] for more details.
  ///
  /// [rx-timer]: http://reactivex.io/documentation/operators/timer.html
  static Observable<Duration> timer(
          {Duration delay,
          Duration period,
          Duration until,
          Scheduler scheduler}) =>
      Observable<Duration>((Observer<Duration> observer) {
        scheduler = scheduler ?? Scheduler.defaultScheduler;
        final subscribedTimestampMillis = scheduler.now;
        return scheduler.scheduleTimer(
          () => observer.sendNext(Duration(
              milliseconds: scheduler.now - subscribedTimestampMillis)),
          delay: delay,
          period: period,
          until: until,
          timeoutCallback: observer.sendCompleted,
        );
      })
        ..name = 'timer(delay: $delay, period: $period, until: $until, '
            'scheduler: $scheduler)';

  /// Calls observer functions on the [scheduler].
  ///
  /// See [observeOn operator in ReactiveX][rx-observeon] for more details.
  ///
  /// [rx-observeon]: http://reactivex.io/documentation/operators/observeon.html
  Observable<T> observeOn(Scheduler scheduler) =>
      Observable((Observer<T> observer) {
        var nextCd = CompositeDisposable();
        var errorSad = SingleAssignmentDisposable();
        var completedSad = SingleAssignmentDisposable();
        // TODO(kismet): revisit potential threading issue.
        var thisDisposable = subscribe(onNext: (T data) {
          var localSad = SingleAssignmentDisposable();
          nextCd.add(localSad);
          localSad.disposable = scheduler.schedule(() {
            observer.sendNext(data);
            nextCd.remove(localSad);
          });
        }, onError: (error, [stackTrace]) {
          errorSad.disposable = scheduler.schedule(() {
            observer.sendError(error, stackTrace);
            nextCd.dispose();
            completedSad.dispose();
          });
        }, onCompleted: () {
          completedSad.disposable = scheduler.schedule(() {
            observer.sendCompleted();
            // TODO(kismet): assert the nextCd is empty.
            nextCd.dispose();
            errorSad.dispose();
          });
        });
        return CompositeDisposable([
          thisDisposable,
          nextCd,
          errorSad,
          completedSad,
        ]);
      })
        ..name = '$name.observeOn($scheduler)';

  /// Subscribes this observable on [scheduler].
  ///
  /// See [subscribeOn operator in ReactiveX][rx-subscribeon] for more details.
  ///
  /// [rx-subscribeon]: http://reactivex.io/documentation/operators/subscribeon.html
  Observable<T> subscribeOn(Scheduler scheduler) =>
      // TODO(kismet): revisit potential threading issue.
      Observable((Observer<T> observer) {
        var subscriptionSad = SingleAssignmentDisposable();
        var scheduleDisposable = scheduler.schedule(() {
          subscriptionSad.disposable = subscribeByObserver(observer);
        });
        return CompositeDisposable([scheduleDisposable, subscriptionSad]);
      })
        ..name = '$name.subscribeOn($scheduler)';

  /// Registers actions to run upon a variety of Observable lifecycle events.
  ///
  /// See [do operator in ReactiveX][rx-do] for more details.
  ///
  /// [rx-do]: http://reactivex.io/documentation/operators/do.html
  Observable<T> tap(
          {OnNextFunction<T> onNext,
          Function onError,
          OnCompletedFunction onCompleted,
          void Function() onSubscribed,
          void Function() onDisposed}) =>
      Observable((Observer<T> observer) {
        if (onSubscribed != null) onSubscribed();
        return CompositeDisposable([
          subscribe(onNext: (data) {
            if (onNext != null) onNext(data);
            observer.sendNext(data);
          }, onError: (error, [stackTrace]) {
            if (onError != null) onError(error, stackTrace);
            observer.sendError(error, stackTrace);
          }, onCompleted: () {
            if (onCompleted != null) onCompleted();
            observer.sendCompleted();
          }),
          Disposable(() {
            if (onDisposed != null) onDisposed();
          }),
        ]);
      })
        ..name = '$name.tap(onNext: $onNext, onError: $onError, '
            'onCompleted: $onCompleted, '
            'onSubscribed: $onSubscribed, onDisposed: $onDisposed)';

  /// Returns a new Observable of type [Notification] which wraps the events
  /// emitted by this observable. The [Notification] provides metadata for the
  /// type and data of the events.
  ///
  /// # Example
  /// src: --------1-----------------------2--------------|-------------------
  /// [                           src.materialize()                          ]
  /// out: --------[OnNext(1)]-------------[OnNext(2)]----[OnCompleted()]-----
  ///
  /// See [ReactiveX Materialize operator][rx-materialize] for more details.
  ///
  /// [rx-materialize]: http://reactivex.io/documentation/operators/materialize-dematerialize.html
  Observable<Notification<T>> materialize() =>
      Observable((Observer<Notification<T>> observer) {
        return subscribe(
            onNext: (T value) => observer.sendNext(Notification.onNext(value)),
            onError: (error, [stackTrace]) {
              observer.sendNext(Notification.onError(error, stackTrace));
              observer.sendCompleted();
            },
            onCompleted: () {
              observer.sendNext(Notification.onCompleted());
              observer.sendCompleted();
            });
      })
        ..name = '$name.materialize()';

  /// Returns a new Observable that emits events based on the metadata
  /// stored in the type, [Notification], of this observable.
  ///
  /// # Example
  /// src: --------[OnNext(1)]-------------[OnNext(2)]----[OnCompleted()]-----
  /// [                          src.dematerialize()                         ]
  /// out: --------1-----------------------2--------------|-------------------
  ///
  /// See [ReactiveX Dematerialize operator][rx-dematerialize] for more details.
  ///
  /// [rx-dematerialize]: http://reactivex.io/documentation/operators/materialize-dematerialize.html
  Observable<S> dematerialize<S>() => Observable((Observer<S> observer) {
        return subscribe(
            onNext: (T t) {
              checkArgument(t is Notification,
                  message: 'dematerialize can only be called on an '
                      'Observable<Notification> but got $t');
              Notification<S> notification = t as Notification<S>;
              switch (notification.type) {
                case NotificationType.OnNext:
                  observer.sendNext(notification.value);
                  break;
                case NotificationType.OnError:
                  observer.sendError(
                      notification.error, notification.stackTrace);
                  break;
                case NotificationType.OnCompleted:
                  observer.sendCompleted();
                  break;
              }
            },
            onError: (error, [stackTrace]) =>
                observer.sendError(error, stackTrace),
            onCompleted: () => observer.sendCompleted());
      })
        ..name = '$name.dematerialize()';
}

/// An implementation of observable which calls OnSubscribeFunction every
/// time it is subscribed.
class _OnSubscribeFunctionObservable<T> extends Observable<T> {
  final OnSubscribeFunction<T> _onSubscribe;

  _OnSubscribeFunctionObservable(this._onSubscribe) : super.protected();

  @override
  Disposable subscribeByObserver(Observer<T> observer) =>
      _onSubscribe(Observer.makeSafe(observer));
}

/// Connectable is used to implement the Observable connectable operators.
/// This is used by the [multicast], [publish] or [publishReplay] operator of
/// observables. Once any of these operator is applied to source observable,
/// it returns an instance of Connectable, and caller can subscribe to the
/// [get observable] field of this connectable. But the connection between the
/// [get observable] field and source observable is not established until the
/// [connect] method is called.
/// See the `Connectable Observable Operators` section in
/// [ReactiveX operators][rx-operators] for more details.
/// [rx-operators]: http://reactivex.io/documentation/operators.html
class Connectable<T> {
  /// Name of this Connectable.
  ///
  /// This is used to trace the operation chain.
  String name;
  final Observable<T> _source;
  final Subject<T> _subject;
  SingleAssignmentDisposable _connectedDisposable;

  /// Local variable to maintain how many [autoConnect]ions are alive
  /// (has living subscriptions).
  ///
  /// This is desired side effect out of observable onSubscribe function.
  ///
  /// This is used to avoid accidentally disposing connections.
  /// ```dart
  /// var connection = (...create observable...).publish();
  /// var observable1 = connection.autoConnect();
  /// var observable2 = connection.autoConnect();
  ///
  /// var disposable1 = observable1.subscribe(...); // observable1 is alive.
  /// var disposable2 = observable2.subscribe(...); // observable2 is alive.
  ///
  /// disposable1.dispose(); // Won't dispose the connection.
  /// disposable2.dispose(); // The connection will be disposed.
  /// ```
  int _autoConnectCount = 0;

  /// Whether the connectable is connected manually.
  bool _manuallyConnected = false;

  /// Whether the connectable will be auto connected.
  bool _willBeAutoConnected = false;

  Connectable._(this._source, this._subject);

  /// The observable is used to switch back to Observable interface.
  ///
  /// CONTRACT:
  /// - Always returns same instance for each call.
  ///
  /// TODO(kismet): wrap _subject into Observable to avoid caller downcast
  /// it to Subject instance.
  Observable<T> get observable => _subject;

  /// Connects the subscription between this [get observable] and
  /// source observable.
  ///
  /// If the connectable is connected, this method will do nothing; if
  /// the connection is broken, this method will re-connect the relationship.
  ///
  /// If the connectable is used as [autoConnect] observable, calling this
  /// method will throw exception.
  ///
  /// # Example
  /// ```dart
  /// var published = new Observable((observer) {
  ///   print('subscribed');
  /// }).publish();
  ///
  /// published.observable.subscribeByObserver(observer1);
  /// published.observable.subscribeByObserver(observer2);
  ///
  /// published.connect(); // print('subscribed') will be called.
  /// ```
  ///
  /// See [connect in ReactiveX][rx-connect] for more details.
  ///
  /// [rx-connect]: http://reactivex.io/documentation/operators/connect.html
  Disposable connect() {
    checkState(!_willBeAutoConnected,
        message: 'Can not manually connect since this connectable '
            'will be auto connected.');
    _manuallyConnected = true;
    return _connect();
  }

  /// Connects the connectable regardless auto or manual.
  Disposable _connect() {
    if (_connectedDisposable != null) return _connectedDisposable;
    _connectedDisposable = SingleAssignmentDisposable();
    _connectedDisposable.disposable = CompositeDisposable([
      _source.subscribeByObserver(_subject),
      Disposable(() {
        _connectedDisposable = null;
      }),
    ]);
    return _connectedDisposable;
  }

  /// Automatically [connect]s if the returned observable is subscribed
  /// by [subscriptionCount] observers.
  ///
  /// If this connectable is already manually [connect]ed, calling this method
  /// will throw exception.
  ///
  /// Note, call this multiple times will return different instances, following
  /// code won't trigger the connection logic:
  /// ```dart
  /// var published = new Observable(...).publish();
  /// published.autoConnect(2).subscribe(...);
  /// published.autoConnect(2).subscribe(...);
  /// ```
  /// Following code does the right thing:
  /// ```dart
  /// var autoConnected = new Observable(...)
  ///    .publish()
  ///    .autoConnect(2);
  /// autoConnected.subscribe(...);
  /// autoConnected.subscribe(...);
  /// ```
  ///
  /// CONTRACT:
  /// - If this is already connected by another auto connection,
  ///   the returned observable will do nothing once the subscriptions
  ///   meet the [subscriptionCount];
  /// - If the returned observable triggered the connection,
  ///   this [get observable] is also connected.
  ///
  /// See [autoConnect][rxjava-autoconnect] for more details.
  ///
  /// [rxjava-autoconnect]: http://reactivex.io/RxJava/javadoc/rx/observables/ConnectableObservable.html
  Observable<T> autoConnect([int subscriptionCount = 1]) {
    checkState(!_manuallyConnected,
        message: 'Can not auto connect this connectable since '
            'it is already manually connected.');
    checkState(subscriptionCount > 0,
        message: 'Auto connect only accepts >0 subscription count, '
            'but it is $subscriptionCount.');
    _willBeAutoConnected = true;
    // This is desired side effect out of onSubscribe function.
    var subscribedCount = 0;
    return Observable((Observer<T> observer) {
      var disposable = observable.subscribeByObserver(observer);
      if (subscribedCount == 0) ++_autoConnectCount;
      ++subscribedCount;
      if (subscribedCount >= subscriptionCount) _connect();
      return CompositeDisposable([
        disposable,
        Disposable(() {
          subscribedCount = max(0, subscribedCount - 1);
          if (subscribedCount == 0) {
            _autoConnectCount = max(0, _autoConnectCount - 1);
          }
          if (_autoConnectCount == 0) _connectedDisposable?.dispose();
        })
      ]);
    })
      ..name = '$name.autoConnect($subscriptionCount)';
  }

  /// Calls [autoConnect] with default parameter.
  ///
  /// See [refCount operator in ReactiveX][rx-refcount] for more details.
  ///
  /// [rx-refcount]: http://reactivex.io/documentation/operators/refcount.html
  Observable<T> refCount() => autoConnect()..name = '$name.refCount()';
}

/// Factory used by the [new Observable(OnSubscribeFunction)] method to
/// create instance.
class OnSubscribeObservableFactory {
  /// The default factory.
  static final OnSubscribeObservableFactory defaultFactory =
      OnSubscribeObservableFactory._();
  static OnSubscribeObservableFactory _currenctFactory;

  /// Current factory.
  static OnSubscribeObservableFactory get currentFactory =>
      _currenctFactory ?? defaultFactory;

  /// Sets current factory to [currenctFactory].
  ///
  /// Caller can set its own factory to let all observables are created
  /// by given factory, so that caller can intercept to all observables or
  /// operators, like, add logging to each operators.
  static set currentFactory(OnSubscribeObservableFactory currenctFactory) {
    _currenctFactory = currenctFactory;
  }

  OnSubscribeObservableFactory._();

  /// Creates an observable using the [onSubscribe] function.
  ///
  /// See [new Observable(OnSubscribeFunction)] for more details and its
  /// contracts.
  Observable<T> create<T>(OnSubscribeFunction<T> onSubscribe) =>
      _OnSubscribeFunctionObservable(onSubscribe)
        ..name = 'observable($onSubscribe)';

  /// Creates a Function which will to pass error and stackTrace
  /// to [observer], and then call the [dispose] function.
  Function _sendErrorAndDispose<T>(
          Observer<T> observer, DisposeFunction dispose) =>
      (error, [stackTrace]) {
        observer.sendError(error, stackTrace);
        dispose();
      };

  /// Checks whether the [object] is an Observable for [op]erator.
  void _checkIsObservable<T>(String op, T event) {
    checkState(event is Observable,
        message: '$op operator requires event to be an Observable, '
            'but it is $event');
  }
}
