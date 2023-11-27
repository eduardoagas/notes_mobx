import 'package:mobx/mobx.dart';

part 'note.g.dart';

// ignore: library_private_types_in_public_api
class Note = _Note with _$Note;

abstract class _Note with Store {
  final String uuid;

  @observable
  DateTime lastModified;
  @observable
  String text;

  _Note({
    required this.uuid,
    required this.lastModified,
    required this.text,
  });

  @override
  bool operator ==(covariant _Note other) =>
      uuid == other.uuid &&
      text == other.text &&
      lastModified == other.lastModified;

  @override
  int get hashCode => Object.hash(
        uuid,
        text,
        lastModified,
      );
}
