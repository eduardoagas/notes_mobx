import 'package:flutter/material.dart' show BuildContext;
import 'generic_dialog.dart';

Future<bool> showDeleteNoteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Deletar nota',
    content: 'Deletar essa nota? Esta operação não poderá ser desfeita.',
    optionsBuilder: () => {
      'Cancelar': false,
      'Deletar': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
