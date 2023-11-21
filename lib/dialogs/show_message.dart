import 'package:flutter/material.dart' show BuildContext;
import 'package:notes_mobx/dialogs/generic_dialog.dart';

Future<void> showMessage({
  required String message,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: "Erro!",
    content: message,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
