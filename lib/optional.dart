/// An implementation of the Optional type.
library optional;

export 'optional_internal.dart'
    show Optional, OptionalExtension, NoValuePresentError, empty, Failure, ParamFailure;

export 'src/either.dart';