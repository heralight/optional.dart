library optional_internal;

import 'package:collection/collection.dart';

part 'src/absent.dart';
part 'src/failure.dart';
part 'src/present.dart';
part 'src/novaluepresent.dart';
part 'src/extension.dart';

/// A constant, absent Optional.
const Optional<dynamic> empty = _Absent<dynamic>();

/// A container object which may contain a non-null value.
///
/// Offers several methods which depend on the presence or absence of a contained value.
abstract class Optional<T> {
  /// Creates a new Optional with the given non-null value.
  ///
  /// Throws [ArgumentError] if value is null.
  factory Optional.of(T value) {
    if (value == null) {
      throw ArgumentError('value must be non-null');
    } else {
      return _Present<T>(value);
    }
  }

  /// Creates a new Optional with the given value, if non-null.  Otherwise, returns an empty Optional.
  factory Optional.ofNullable(T value) {
    if (value == null) {
      return empty.cast();
    } else {
      return _Present<T>(value);
    }
  }

  factory Optional.tryo(T Function() predicate) {
    try {
      return Optional.ofNullable(predicate());
    } catch (e, s) {
      var m = e.toString();

      return Failure<T>(
        message: m,
        exception: Optional.ofNullable(e),
        stackTrace: s.toOptional
      );
    }
  }

  /// Creates an empty Optional.
  const factory Optional.empty() = _Absent<T>._internal;

  /// The value associated with this Optional, if any.
  ///
  /// Throws [NoValuePresentError] if no value is present.
  T get value;

  /// Whether the Optional has a value.
  bool get isPresent;

  /// Whether the Optional has a value.
  bool get isEmpty;

  bool get isFailure;

  /// Returns an Optional with this Optional's value, if there is a value present and it matches the predicate.  Otherwise, returns an empty Optional.
  Optional<T> filter(bool Function(T) predicate);

  /// Returns an Optional provided by applying the mapper to this Optional's value, if present.  Otherwise, returns an empty Optional.
  Optional<R> flatMap<R>(Optional<R> Function(T) mapper);

  /// Returns an Optional containing the result of applying the mapper to this Optional's value, if present.  Otherwise, returns an empty Optional.
  ///
  /// If the mapper returns a null value, returns an empty Optional.
  Optional<R> map<R>(R Function(T) mapper);

  /// Whether the Optional contains the passed value.
  bool contains(T val);

  /// Returns this Optional's value, if present.  Otherwise, returns other.
  T orElse(T other);

  /// Returns this Optional's value, if present.  Otherwise, returns the result of calling supply().
  T orElseGet(T Function() supply);

  /// Returns this Optional's value, if present.  Otherwise, throws the result of calling supplyError().
  T orElseThrow(dynamic Function() supplyError);

  /// Invokes consume() with this Optional's value, if present.  Otherwise, if orElse is passed, invokes it, otherwise does nothing.
  void ifPresent(void Function(T) consume, {void Function() orElse});

  /// Returns a Set containing the value if present.  Otherwise, returns an empty Set. This Set is unmodifiable.
  Set<T> toSet();

  /// Returns a List containing the value if present.  Otherwise, returns an empty List. This List is unmodifiable.
  List<T> toList();

  /// The hashCode of this Optional's value, if present.  Otherwise, 0.
  @override
  int get hashCode;

  @override
  bool operator ==(Object other);

  /// Returns a view of this Optional as an Optional with an [R] value
  Optional<R> cast<R>();
}
