part of optional_internal;

class _Present<T> implements Optional<T> {
  const _Present(this._value);

  final T _value;

  @override
  T get value => _value;

  @override
  bool get isPresent => true;

  @override
  bool get isEmpty => false;

  @override
  bool get isFailure => false;

  @override
  Optional<T> filter(bool Function(T) predicate) {
    if (predicate(_value)) {
      return this;
    } else {
      return empty.cast();
    }
  }

  @override
  R fold<R>(R Function() onEmpty, R Function(T a) onPresent) {
    return onPresent(_value);
  }
  @override
  Optional<R> flatMap<R>(Optional<R> Function(T) mapper) => mapper(_value);

  @override
  Future<Optional<R>> flatMapAsync<R>(Future<Optional<R>> Function(T) mapper) async => mapper(_value);

  @override
  Optional<R> map<R>(R Function(T) mapper) =>
      Optional<R>.ofNullable(mapper(_value));

  @override
  bool contains(T val) => _value == val;

  @override
  T orElse(T other) => _value;

  @override
  T orElseGet(T Function() supply) => _value;

  @override
  T orElseThrow(dynamic Function() supplyError) => _value;

  @override
  void ifPresent(void Function(T) consume, {void Function() orElse}) =>
      consume(_value);

  @override
  Set<T> toSet() => UnmodifiableSetView({_value});

  @override
  List<T> toList() => UnmodifiableListView([_value]);

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(Object other) => other is _Present && other._value == _value;

  @override
  String toString() => 'Optional[value: $_value]';

  @override
  Optional<R> cast<R>() => _Present(value as R);
}
