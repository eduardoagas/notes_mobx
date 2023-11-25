import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/dimensions.dart';
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
          title: Row(
            children: [
              Expanded(
                child: Text(
                  note.text,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
                child: IconButton(
                  onPressed: () async {
                    /*final shouldDeleteReminder =
                        await showDeleteReminderDialog(context);
                    if (shouldDeleteReminder) {
                      if (context.mounted) {
                        context.read<AppState>().delete(reminder);
                      }
                    }*/
                  },
                  icon: Icon(
                    Icons.drive_file_rename_outline_sharp,
                    size: Dimensions.height30,
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              SizedBox(
                width: Dimensions.width10,
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      /*final shouldDeleteReminder =
                          await showDeleteReminderDialog(context);
                      if (shouldDeleteReminder) {
                        if (context.mounted) {
                          context.read<AppState>().delete(reminder);
                        }
                      }*/
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.circleXmark,
                      size: Dimensions.height24,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}
