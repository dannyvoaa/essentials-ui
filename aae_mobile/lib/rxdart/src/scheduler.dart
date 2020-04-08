part of rx;

/// Function to be scheduled to run.
typedef void RunnableFunction();

/// Function is to be called in a scheduled recursive task to
/// reschedule that task asap.
typedef void RescheduleFunction();

/// Function to be scheduled to run.
/// This function can call [reschedule] to reschedule itself asap.
typedef void RecursiveRunnableFunction(RescheduleFunction reschedule);

/// Function is to be called in a scheduled task to reschedule that task
/// after [delay].
/// If [delay] is null, it will be rescheduled asap depends on the
/// implementation of scheduler.
typedef void RescheduleDelayFunction(Duration delay);

/// Function to be scheduled to run.
/// This function can call [rescheduleDelay] with a delay to
/// reschedule itself later.
typedef void RecursiveDelayRunnableFunction(
    RescheduleDelayFunction rescheduleDelay);
typedef void TimeoutCallbackFunction();
typedef int NowTimestampMillisecondsFunction();

/// Scheduler in ReactiveX.
/// See:
/// http://reactivex.io/documentation/scheduler.html
abstract class Scheduler {
  /// The default scheduler singleton which is an immediate schedule.
  static final Scheduler defaultScheduler = Scheduler.immediate()
    ..name = 'DefaultImmediateScheduler';

  /// The default microtask scheduler singleton.
  static final Scheduler microtaskScheduler = Scheduler.microtask()
    ..name = 'DefaultMicrotaskScheduler';

  /// The name of scheduler.
  ///
  /// This is used for debugging.
  String name;

  /// Protected constructor for subclassing.
  @protected
  Scheduler.protected();

  /// Creates a new immediate scheduler.
  ///
  /// This scheduler will call runnable immediately within the scheduling
  /// function.
  /// And it uses Dart Timer class for other delay/recursive tasks.
  ///
  /// [nowFn] is used to determine the timestamp of [now], if it does not
  /// present, [now] will use the standard timestamp since epoch.
  factory Scheduler.immediate([NowTimestampMillisecondsFunction nowFn]) =>
      _ImmediateScheduler(nowFn);

  /// Creates a scheduler which run runnable after the scheduling function
  /// exits.
  ///
  /// This scheduler will use microtask for scheduled task.
  /// And it uses Dart Timer class for other delay/recursive tasks.
  ///
  /// [nowFn] is used to determine the timestamp of [now], if it does not
  /// present, [now] will use the standard timestamp since epoch.
  factory Scheduler.microtask([NowTimestampMillisecondsFunction nowFn]) =>
      _MicrotaskScheduler(nowFn);

  @override
  String toString() => name;

  /// The duration in milliseconds between current time and the time when
  /// this scheduler is created.
  /// TODO(kismet): change the type from 'int' to 'Duration'.
  int get now;

  /// Schedules a [runnable] function to run.
  ///
  /// The returned disposable is used to dispose the scheduled task if it is
  /// not executed.
  Disposable schedule(RunnableFunction runnable);

  /// Schedules a [runnable] to be run after [delay].
  ///
  /// If [delay] is null, it will be [schedule]d directly.
  Disposable scheduleDelay(Duration delay, RunnableFunction runnable);

  /// Schedules a recursive task and runs it immediately.
  ///
  /// The [runnable] takes a RescheduleFunction as parameter.
  /// [runnable] can call that function to reschedule again.
  Disposable scheduleRecursive(RecursiveRunnableFunction runnable) =>
      scheduleRecursiveDelay((RescheduleDelayFunction rescheduleDelay) {
        runnable(() {
          rescheduleDelay(null);
        });
      });

  /// Schedules a recursive task and runs it immediately.
  ///
  /// The [runnable] takes a RescheduleDelayRunnableFunction as parameter.
  /// [runnable] can call that function with a delay duration to
  /// reschedule itself again later.
  Disposable scheduleRecursiveDelay(RecursiveDelayRunnableFunction runnable) {
    var sd = SerialDisposable();
    void scheduleNext() {
      runnable((Duration delay) {
        sd.disposable = scheduleDelay(delay, scheduleNext);
      });
    }

    return CompositeDisposable([schedule(scheduleNext), sd]);
  }

  /// Schedules a timer task which will run the [runnable] after [delay],
  /// and then run it every [period] [until] exceed the deadline.
  ///
  /// See scheduleDelay and schedulePeriodic for more details.
  Disposable scheduleTimer(RunnableFunction runnable,
      {Duration delay,
      Duration period,
      Duration until,
      TimeoutCallbackFunction timeoutCallback}) {
    schedulePeriodicTask(Duration until) => period == null
        ? Disposable.noop
        : schedulePeriodic(period, runnable,
            until: until, timeoutCallback: timeoutCallback);
    if (delay == null) return schedulePeriodicTask(until);
    var sd = SerialDisposable();
    sd.disposable = scheduleDelay(delay, () {
      runnable();
      sd.disposable =
          schedulePeriodicTask(until == null ? null : until - delay);
    });
    return sd;
  }

  /// Schedules a [runnable] to be run every [period].
  ///
  /// The first run occurs after the first [period] from scheduling.
  ///
  /// If [until] is not null, [runnable] will terminate after [until] and the
  /// [timeoutCallback] will be called. Otherwise, the [runnable]
  /// will be executed infinitely until the returned disposable is disposed.
  ///
  /// Note, if [period] is null or 0 delay, depends on the implementation of
  /// scheduler, this function *may block* main thread execution.
  Disposable schedulePeriodic(Duration period, RunnableFunction runnable,
      {Duration until, TimeoutCallbackFunction timeoutCallback}) {
    var scheduledTimestamp = now;
    var localRunnable;
    return scheduleRecursiveDelay((RescheduleDelayFunction rescheduleDelay) {
      if (until != null && until.inMilliseconds <= now - scheduledTimestamp) {
        if (timeoutCallback != null) timeoutCallback();
      } else {
        // Note: here we are using the scheduleRecursiveDelay, but following the
        // definition of this api, the first run occurs after the first period
        // time, so we need to bypass the first time execution which is called
        // by scheduleRecursiveDelay immediately.
        if (localRunnable == null) {
          localRunnable = runnable;
        } else {
          localRunnable();
        }
        rescheduleDelay(period);
      }
    });
  }
}

/// The base scheduler depends on real time and Dart Timer class.
abstract class _BaseTimerScheduler extends Scheduler {
  static int _nowSinceEpoch() => DateTime.now().millisecondsSinceEpoch;

  /// The timestamp of this scheduler is created in milliseconds.
  final int _creationTimestamp;
  final NowTimestampMillisecondsFunction _nowFn;

  _BaseTimerScheduler(NowTimestampMillisecondsFunction nowFn)
      : _nowFn = nowFn ?? _nowSinceEpoch,
        _creationTimestamp = (nowFn ?? _nowSinceEpoch)(),
        super.protected();

  @override
  int get now => _nowFn() - _creationTimestamp;

  @override
  Disposable scheduleDelay(Duration delay, RunnableFunction runnable) =>
      delay == null
          ? schedule(runnable)
          : Disposable(Timer(delay, runnable).cancel);

  // Note: Dart Timer provides periodic task directly, override this method
  // for efficiency.
  @override
  Disposable schedulePeriodic(Duration period, RunnableFunction runnable,
      {Duration until, TimeoutCallbackFunction timeoutCallback}) {
    var scheduledTimestamp = now;
    Timer periodicTimer;
    periodicTimer = Timer.periodic(period, (_) {
      if (until != null && until.inMilliseconds <= now - scheduledTimestamp) {
        periodicTimer?.cancel();
        if (timeoutCallback != null) timeoutCallback();
      } else {
        runnable();
      }
    });
    return Disposable(periodicTimer.cancel);
  }
}

/// Scheduler implementation to run the scheduled runnable immediately.
class _ImmediateScheduler extends _BaseTimerScheduler {
  static int _count = 0;

  _ImmediateScheduler(NowTimestampMillisecondsFunction nowFn) : super(nowFn) {
    name = 'ImmediateScheduler_${_count++}';
  }

  @override
  Disposable schedule(RunnableFunction runnable) {
    runnable();
    return Disposable.noop;
  }
}

/// Scheduler implementation to run the scheduled runnable in the microtask
/// loop using scheduleMicrotask.
class _MicrotaskScheduler extends _BaseTimerScheduler {
  static int _count = 0;

  _MicrotaskScheduler(NowTimestampMillisecondsFunction nowFn) : super(nowFn) {
    name = 'MicrotaskScheduler_${_count++}';
  }

  @override
  Disposable schedule(RunnableFunction runnable) {
    var disposable = CheckableDisposable();
    scheduleMicrotask(() {
      if (!disposable.disposed) {
        // Note, there is no way to remove the task scheduled by
        // scheduleMicrotask method, so the only way we can do is to stop the
        // runnable to be executed if the disposable is disposed.
        runnable();
      }
    });
    return disposable;
  }
}

/// Scheduler implementation to run scheduled task in a virtual timeline.
class VirtualTimeScheduler extends Scheduler {
  static int _count = 0;
  int _virtualTimestamp = 0;
  bool _running = false;
  PriorityQueue<_VTTask> _tasks = PriorityQueue();

  VirtualTimeScheduler() : super.protected() {
    name = 'VirtualTimeScheduler_${_count++}';
  }

  @override
  int get now => _virtualTimestamp;

  /// Schedules a [runnable] at the given [tick] to run.
  Disposable _scheduleRunableAtTick(RunnableFunction runnable, int tick) {
    var task = _VTTask(runnable, tick);
    _tasks.add(task);
    return Disposable(task.dispose);
  }

  @override
  Disposable schedule(RunnableFunction runnable) =>
      _scheduleRunableAtTick(runnable, _virtualTimestamp);

  @override
  Disposable scheduleDelay(Duration delay, RunnableFunction runnable) =>
      delay == null
          ? schedule(runnable)
          : _scheduleRunableAtTick(
              runnable, _virtualTimestamp + delay.inMilliseconds);

  /// Pops and returns the next non disposed task.
  _VTTask _nextTask() {
    while (_tasks.isNotEmpty) {
      _VTTask task = _tasks.removeFirst();
      if (!task.disposed) {
        return task;
      }
    }
    return null;
  }

  _VTTask _peekAtNextTask() {
    while (_tasks.isNotEmpty) {
      if (_tasks.first.disposed) {
        _tasks.removeFirst();
      } else {
        return _tasks.first;
      }
    }
    return null;
  }

  /// Advances the time of this scheduler to [timestamp] and immediately runs
  /// all tasks scheduled to run before [timestamp] in order.
  ///
  /// [timestamp] is the duration passed from the creation of this Scheduler.
  void advanceTimeTo(Duration timestamp) {
    var nextTask = _peekAtNextTask();
    while (nextTask != null &&
        nextTask.scheduledTimestamp <= timestamp.inMilliseconds) {
      nextTask = _nextTask();
      _virtualTimestamp = nextTask.scheduledTimestamp;
      nextTask.runnable();
      nextTask = _peekAtNextTask();
    }
    _virtualTimestamp = timestamp.inMilliseconds;
  }

  /// Advances the time of this scheduler by the specified [duration].
  void advanceTimeBy(Duration duration) {
    advanceTimeTo(duration + Duration(milliseconds: _virtualTimestamp));
  }

  /// Starts the scheduler to run all scheduled tasks until there is no any
  /// pending tasks.
  ///
  /// Be careful, if you have scheduled any infinite tasks, e.g. periodic task
  /// without until or using scheduleRecursive/scheduleRecursiveDelay without
  /// termination logic, the start call may raise an infinite loop and you may
  /// have no chance to dispose it.
  void start() {
    if (!_running) {
      _running = true;
      while (_running) {
        var nextTask = _nextTask();
        if (nextTask != null) {
          if (nextTask.scheduledTimestamp > _virtualTimestamp) {
            _virtualTimestamp = nextTask.scheduledTimestamp;
          }
          nextTask.runnable();
        } else {
          _running = false;
        }
      }
    }
  }

  /// Stops the scheduler.
  void stop() {
    _running = false;
  }
}

/// A virtual time task.
class _VTTask implements Comparable<_VTTask> {
  /// The runnable of the task.
  final RunnableFunction runnable;

  /// The scheduled virtual time to run the runnable.
  final int scheduledTimestamp;
  bool _disposed = false;

  _VTTask(this.runnable, this.scheduledTimestamp);

  /// Mark the task is disposed.
  void dispose() {
    _disposed = true;
  }

  bool get disposed => _disposed;

  @override
  int compareTo(_VTTask other) {
    return scheduledTimestamp - other.scheduledTimestamp;
  }
}
