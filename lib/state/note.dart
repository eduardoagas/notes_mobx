import 'package:mobx/mobx.dart';

part 'note.g.dart';

class Note = _Note with _$Note;

abstract class _Note with Store {
  final String id;

  @observable
  DateTime lastModified;
  @observable
  String text;

  _Note({
    required this.id,
    required this.lastModified,
    required this.text,
  });

  @override
  bool operator ==(covariant _Note other) =>
      id == other.id &&
      text == other.text &&
      lastModified == other.lastModified;

  @override
  int get hashCode => Object.hash(
        id,
        text,
        lastModified,
      );
}
