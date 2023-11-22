import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import 'note_tile.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Observer(
      builder: (context) {
        return ListView.builder(
          itemCount: appState.sortedNotes.length,
          itemBuilder: (context, index) {
            return NoteTile(
              reminderIndex: index,
            );
          },
        );
      },
    );
  }
}
