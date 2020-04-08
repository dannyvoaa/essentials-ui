/// Represents a nullable value that might be absent.
/// This is necessary because Quiver's [Optional] doesn't accept null values.
class NullableOptional<T> {
  const NullableOptional._({this.value, this.present = false});

  const NullableOptional.absent() : this._(present: false);

  const NullableOptional.of(T value) : this._(value: value, present: true);

  NullableOptional<A> retype<A>() => NullableOptional._(
        value: value as A,
        present: present,
      );
  final T value;
  final bool present;

  bool get absent => !present;

  S get<S>() => value as S;

  T or(T other) => present ? value : other;

  @override
  String toString() {
    return present
        ? 'NullableOptional.present(value: $value)'
        : 'NullableOptional.absent()';
  }
}
