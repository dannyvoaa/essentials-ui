import 'package:quiver/core.dart';
import 'package:aae/rxdart/rx.dart';

/// Converts an [Observable] to an [Observable] of [Optional]s of the same type.
///
/// The resulting [Observable] has an initial value of absent.
Observable<Optional<T>> mapToOptional<T>(Observable<T> observable) => observable
    .map((value) => Optional.of(value))
    .startWithSingle(Optional.absent());
