part of optional_internal;

/// Failure represent an error
class Failure<T> extends _Absent<T> implements Optional<T> {
  final Optional<String> message;
  final Optional<dynamic> exception;
  final Optional<StackTrace> stackTrace;
  final Optional<Failure> chain;
  Failure({this.message, this.exception, this.stackTrace, this.chain});

  @override
  bool get isFailure => true;

  @override
  Optional<R> cast<R>() => Failure<R>(
      message: message,
      exception: exception,
      stackTrace: stackTrace,
      chain: chain);
  @override
  String toString() => 'Failure[message: $message]';
}

///
/// A `ParamFailure` is a `[[Failure]]` with an additional type-safe parameter
/// that can allow an application to store other information related to the
/// failure.
///
class ParamFailure<T, R> extends Failure<T> {
  final Optional<R> param;
  ParamFailure(
      {Optional<String> message,
      Optional<dynamic> exception,
      Optional<StackTrace> stackTrace,
      Optional<Failure> chain,
      this.param})
      : super(
            message: message,
            exception: exception,
            stackTrace: stackTrace,
            chain: chain);
}
