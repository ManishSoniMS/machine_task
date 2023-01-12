import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({
    required this.code,
    required this.message,
    this.error,
  });

  final String code;

  final String message;

  final Object? error;

  @override
  String toString() =>
      'Failure{ code: $code, message: $message, error: $error,}';

  @override
  List<Object?> get props => [
        code,
        message,
        error,
      ];
}
