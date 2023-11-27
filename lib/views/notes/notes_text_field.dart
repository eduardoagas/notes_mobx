import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../constants/dimensions.dart';
import '../../state/app_state.dart';

class NotesTextField extends StatelessWidget {
  final FocusNode focusNode;
  const NotesTextField({required this.focusNode, super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    context.read<AppState>().enter = true;
    return Observer(builder: (context) {
      final noteController =
          TextEditingController(text: appState.getEditText());
      noteController.selection = TextSelection.fromPosition(
          TextPosition(offset: noteController.text.length));
      return TextField(
        controller: noteController,
        textAlign: TextAlign.center,
        autofocus: true,
        focusNode: focusNode,
        onSubmitted: (event) async {
          context.read<AppState>().enter = false;
          if (noteController.text.isNotEmpty) {
            final str = noteController.text;
            noteController.clear();
            await context.read<AppState>().createOrEditNote(str);
          }
        },
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.font17,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          constraints: BoxConstraints(
            maxWidth: Dimensions.screenWidth * 0.74,
            maxHeight: Dimensions.height70,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.font16,
          ),
          hintText: "Digite seu texto",
        ),
      );
    });
  }
}
