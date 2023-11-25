import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/dimensions.dart';
import '../../dialogs/delete_note_dialog.dart';
import '../../state/app_state.dart';

class NoteTile extends StatelessWidget {
  final int noteIndex;

  const NoteTile({
    super.key,
    required this.noteIndex,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final note = appState.sortedNotes[noteIndex];
    return Observer(
      builder: (context) {
        return ListTile(
          contentPadding: EdgeInsets.only(
              left: Dimensions.width16, right: Dimensions.width8),
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: Dimensions.width15),
                  child: Center(
                    child: Text(
                      note.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font16,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  appState.editModeOnOff(note);
                },
                icon: Icon(
                  Icons.drive_file_rename_outline_sharp,
                  color: appState.getEditColor(context, note.uuid),
                  size: Dimensions.height30,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final shouldDeleteNote = await showDeleteNoteDialog(context);
                  if (shouldDeleteNote) {
                    if (context.mounted) {
                      context.read<AppState>().delete(note);
                    }
                  }
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidCircleXmark,
                  size: Dimensions.height24,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
