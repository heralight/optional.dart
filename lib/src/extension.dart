part of optional_internal;

extension OptionalExtension<T extends Object> on T {
  /// Returns an empty Optional if called on `null`, otherwise returns an Optional with `this` as its value
  Optional<T> get toOptional => Optional.ofNullable(this);
}


extension OptionalFuncExtension<T extends Object> on T Function() {
    /// Returns an Failure Optional if called and throw an Exception, otherwise returns an Optional with `this` as its value
  Optional<T> get tryo => Optional.tryo(this);
}
