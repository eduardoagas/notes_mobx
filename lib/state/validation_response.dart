import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';

@immutable
class ValidationResponse extends Equatable {
  final int status;
  final String message;
  const ValidationResponse({
    required this.status,
    required this.message,
  });

  @override
  List<Object> get props {
    return [status, message];
  }
}
