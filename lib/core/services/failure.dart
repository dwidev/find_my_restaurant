abstract class Failure implements Exception {
  Failure(this.message);

  final String message;

  @override
  String toString() => 'Failure(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}
