// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Note on _Note, Store {
  late final _$lastModifiedAtom =
      Atom(name: '_Note.lastModified', context: context);

  @override
  DateTime get lastModified {
    _$lastModifiedAtom.reportRead();
    return super.lastModified;
  }

  @override
  set lastModified(DateTime value) {
    _$lastModifiedAtom.reportWrite(value, super.lastModified, () {
      super.lastModified = value;
    });
  }

  late final _$textAtom = Atom(name: '_Note.text', context: context);

  @override
  String get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(String value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  @override
  String toString() {
    return '''
lastModified: ${lastModified},
text: ${text}
    ''';
  }
}
