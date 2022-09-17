mixin _ResultMixin<ValueType, ErrorType> {
  capture({
    required Function(ValueType data) ok,
    required Function(ErrorType error) err,
  }) =>
      throw UnimplementedError();
}

class Result<ValueType, ErrorType> with _ResultMixin<ValueType, ErrorType> {
  factory Result.ok(ValueType data) = Ok<ValueType, ErrorType>;
  factory Result.error(ErrorType error) = Error<ValueType, ErrorType>;
}

class Ok<ValueType, ErrorType> implements Result<ValueType, ErrorType> {
  Ok(this.data);

  final ValueType data;

  @override
  capture({
    required Function(ValueType data) ok,
    required Function(ErrorType error) err,
  }) {
    return ok(data);
  }
}

class Error<ValueType, ErrorType> implements Result<ValueType, ErrorType> {
  Error(this.error);

  final ErrorType error;

  @override
  capture({
    required Function(ValueType data) ok,
    required Function(ErrorType error) err,
  }) {
    return err(error);
  }
}
