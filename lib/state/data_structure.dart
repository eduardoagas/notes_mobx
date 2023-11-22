import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';

@immutable
class DataStructure extends Equatable {
  final String message;
  const DataStructure({
    required this.message,
  });

  @override
  List<Object> get props {
    return [message];
  }
}
