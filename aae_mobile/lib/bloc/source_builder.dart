import 'dart:async';
import 'package:aae/bloc/nullable_optional.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:quiver/check.dart';

/// Builder that produces a [Widget] by combining the last known values of a
/// list of [Source]s and a builder [Function].
/// The builder function will be invoked whenever one of the sources produces
/// a value. The function is expected to take one NullableOptional enclosing
/// each of the values, on the same order they appear in the [sources] list.
/// A set of combineN factory methods are provided to simplify usage and for
/// added type checking.
/// Note that you have to be careful about how you combine sources, as a build
/// will be triggered whenever any of them changes. For example, if you have
/// two sources, sourceA and sourceB, and sourceA, and you want to build a
/// Column with their values, you could write:
/// ```dart
/// SourceBuilder.combine2(
///   sourceA, sourceB,
///   (sourceAValue, sourceBValue) {
///     return Column(
///       children: [
///         Text(sourceAValue.value),
///         Text(sourceBValue.value),
///       ]
///     )
///   }
/// )
/// ```
/// But if it happens that sourceA is updated much more frequently than sourceB,
/// it'd make sense to change this implementation to have a [SourceBuilder] for
/// each:
/// ```dart
/// Column(
///   children: [
///     SourceBuilder.of(sourceA, (sourceAValue) => Text(sourceAValue.value)),
///     SourceBuilder.of(sourceB, (sourceBValue) => Text(sourceBValue.value)),
///   ],
/// )
/// ```
/// The rule of thumb is: keep your source lists small by only combining sources
/// when you absolutely need to.
class SourceBuilder extends StatefulWidget {
  final List<Source> sources;
  final Function(List) builder;
  final VoidCallback onDispose;

  SourceBuilder._({
    Key key,
    this.onDispose,
    @required this.sources,
    @required this.builder,
  }) : super(key: key) {
    checkNotNull(sources);
    sources.forEach(checkNotNull);
    checkNotNull(builder);
  }

  static SourceBuilder of<A>({
    Key key,
    @required Source<A> source,
    VoidCallback onDispose,
    @required Function(NullableOptional<A>) builder,
  }) {
    checkNotNull(source);
    return SourceBuilder._(
      key: key,
      sources: [source],
      onDispose: onDispose,
      builder: (values) {
        return builder(
          values[0].retype<A>(),
        );
      },
    );
  }

  static SourceBuilder emptyBoxIfAbsent<A>({
    Key key,
    @required Source<A> source,
    VoidCallback onDispose,
    @required Widget Function(A) builder,
  }) {
    checkNotNull(source);
    checkNotNull(builder);
    return SourceBuilder.of(
      key: key,
      source: source,
      onDispose: onDispose,
      builder: (value) => value.absent ? SizedBox() : builder(value.value),
    );
  }

  static SourceBuilder combine2<A, B>(
    Source<A> first,
    Source<B> second, {
    VoidCallback onDispose,
    @required Function(NullableOptional<A>, NullableOptional<B>) builder,
  }) {
    checkNotNull(first);
    checkNotNull(second);
    return SourceBuilder._(
      sources: [first, second],
      onDispose: onDispose,
      builder: (values) {
        return builder(
          values[0].retype<A>(),
          values[1].retype<B>(),
        );
      },
    );
  }

  static SourceBuilder combine3<A, B, C>(
    Source<A> first,
    Source<B> second,
    Source<C> third, {
    VoidCallback onDispose,
    @required
        Function(
      NullableOptional<A>,
      NullableOptional<B>,
      NullableOptional<C>,
    )
            builder,
  }) {
    checkNotNull(first);
    checkNotNull(second);
    checkNotNull(third);
    return SourceBuilder._(
      sources: [first, second, third],
      onDispose: onDispose,
      builder: (values) {
        return builder(
          values[0].retype<A>(),
          values[1].retype<B>(),
          values[2].retype<C>(),
        );
      },
    );
  }

  static SourceBuilder combine4<A, B, C, D>(
    Source<A> first,
    Source<B> second,
    Source<C> third,
    Source<D> fourth, {
    VoidCallback onDispose,
    @required
        Function(
      NullableOptional<A>,
      NullableOptional<B>,
      NullableOptional<C>,
      NullableOptional<D>,
    )
            builder,
  }) {
    checkNotNull(first);
    checkNotNull(second);
    checkNotNull(third);
    checkNotNull(fourth);
    return SourceBuilder._(
      sources: [first, second, third, fourth],
      onDispose: onDispose,
      builder: (values) {
        return builder(
          values[0].retype<A>(),
          values[1].retype<B>(),
          values[2].retype<C>(),
          values[3].retype<D>(),
        );
      },
    );
  }

  static SourceBuilder combine5<A, B, C, D, E>(
    Source<A> first,
    Source<B> second,
    Source<C> third,
    Source<D> fourth,
    Source<E> fifth, {
    VoidCallback onDispose,
    @required
        Function(
      NullableOptional<A>,
      NullableOptional<B>,
      NullableOptional<C>,
      NullableOptional<D>,
      NullableOptional<E>,
    )
            builder,
  }) {
    checkNotNull(first);
    checkNotNull(second);
    checkNotNull(third);
    checkNotNull(fourth);
    checkNotNull(fifth);
    return SourceBuilder._(
      sources: [first, second, third, fourth, fifth],
      onDispose: onDispose,
      builder: (values) {
        return builder(
          values[0].retype<A>(),
          values[1].retype<B>(),
          values[2].retype<C>(),
          values[3].retype<D>(),
          values[4].retype<E>(),
        );
      },
    );
  }

  static SourceBuilder combine6<A, B, C, D, E, F>(
    Source<A> first,
    Source<B> second,
    Source<C> third,
    Source<D> fourth,
    Source<E> fifth,
    Source<E> sixth, {
    VoidCallback onDispose,
    @required
        Function(
      NullableOptional<A>,
      NullableOptional<B>,
      NullableOptional<C>,
      NullableOptional<D>,
      NullableOptional<E>,
      NullableOptional<F>,
    )
            builder,
  }) {
    checkNotNull(first);
    checkNotNull(second);
    checkNotNull(third);
    checkNotNull(fourth);
    checkNotNull(fifth);
    checkNotNull(sixth);
    return SourceBuilder._(
      sources: [first, second, third, fourth, fifth, sixth],
      onDispose: onDispose,
      builder: (values) {
        return builder(
          values[0].retype<A>(),
          values[1].retype<B>(),
          values[2].retype<C>(),
          values[3].retype<D>(),
          values[4].retype<E>(),
          values[5].retype<F>(),
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() => _SourceBuilderState();
}

class _SourceBuilderState extends State<SourceBuilder> {
  final _lastKnownValues = <Source, NullableOptional>{};
  SourceBindings _bindings;

  @override
  void didUpdateWidget(SourceBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the new _lastKnownValues contains a source that is not part of the
    // new widget's, then we don't need to listen to it anymore.
    for (final source in _lastKnownValues.keys.toList()) {
      if (!widget.sources.contains(source)) {
        _bindings.unbind(source);
      }
    }
    widget.sources.forEach(_bindSource);
  }

  @override
  void initState() {
    super.initState();
    _bindings = SourceBindings.of(this);
    widget.sources.forEach(_bindSource);
  }

  @override
  Widget build(BuildContext context) {
    final orderedValues = widget.sources.map((s) => _lastKnownValues[s]);
    return widget.builder(orderedValues.toList());
  }

  @override
  void dispose() {
    _bindings.dispose();
    widget.onDispose?.call();
    super.dispose();
  }

  void _bindSource(Source source) {
    if (_lastKnownValues[source] != null) {
      return;
    }
    _lastKnownValues[source] = NullableOptional.absent();
    _bindings.bind(
      source: source,
      to: (value) {
        _lastKnownValues[source] = NullableOptional.of(value);
        scheduleMicrotask(() {
          if (mounted) {
            setState(() {});
          }
        });
      },
    );
  }
}

/// Utility class for a set of [Source] subscriptions.
class SourceBindings {
  static final _logger = Logger('ExpressBundle');
  final bool Function() _mountCheck;
  final _disposeFunctionsForSource = <Source, List<SourceDisposeFunction>>{};

  SourceBindings.of(State state) : this(() => state.mounted);

  @visibleForOverriding
  SourceBindings(this._mountCheck);

  /// Subscribes to [source], forwarding values to the provided [to] callback,
  /// only when [State] is mounted.
  ///
  /// All subscriptions indirectly created with this method are disposed on
  /// [dispose].
  void bind<T>({
    @required Source<T> source,
    @required Function(T) to,
  }) {
    _disposeFunctionsForSource[source] = (_disposeFunctionsForSource[source] ??
        [])
      ..add(source.subscribe((d) => _onNewData(d, to)));
  }

  void _onNewData<T>(T data, Function(T) callback) {
    if (_mountCheck()) {
      callback(data);
    } else {
      _logger.warning(
          'Attempted to invoke binding callback while state is not mounted.');
    }
  }

  /// Unbinds all callbacks tied to the specified source.
  ///
  /// This is useful for cases in which a widget binds a [Source] that can
  /// change. In that case, the widget can unbind the previous Source and bind
  /// the new one.
  void unbind<T>(Source<T> source) {
    for (final disposeFunction in _disposeFunctionsForSource[source] ?? []) {
      disposeFunction();
    }
    _disposeFunctionsForSource.remove(source);
  }

  /// Disposes all subscriptions created by this instance.
  void dispose() {
    for (final source in _disposeFunctionsForSource.keys.toList()) {
      unbind(source);
    }
  }
}
