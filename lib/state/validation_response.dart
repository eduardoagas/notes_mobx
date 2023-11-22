import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';
import 'package:notes_mobx/state/data_structure.dart';

@immutable
class ValidationResponse extends Equatable {
  final int status;
  final DataStructure data;
  const ValidationResponse({
    required this.status,
    required this.data,
  });

  @override
  List<Object> get props {
    return [status, data];
  }
}
