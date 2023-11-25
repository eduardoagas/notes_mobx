import 'package:flutter/material.dart';
import 'package:notes_mobx/views/notes/notes_list_view.dart';
import 'package:provider/provider.dart';

import '../../constants/dimensions.dart';
import '../../state/app_state.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'notes_text_field.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  //ScrollController textFieldScrollController = ScrollController();
  late FocusNode _focusNode;
  bool enter = false;

 

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        //noteController.clear();
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
    /*noteController.addListener(() {
      if (context.read<AppState>().edit != null) {
        noteController.text = context.read<AppState>().edit!.text;
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, visible) {
      if (!visible && context.read<AppState>().enter) {
        context.read<AppState>().goToLogin();
      }
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                  Color.fromARGB(255, 2, 37, 22),
                  Color.fromARGB(255, 16, 114, 106),
                ])),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.height50),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      shape: const BeveledRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(2, 10))),
                      child: SizedBox(
                        height: Dimensions.screenHeight * 0.25,
                        width: Dimensions.screenWidth * 0.75,
                        child: const NotesListView(),
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  bottom: Dimensions.screenHeight * 0.08,
                  start: Dimensions.screenWidth * 0.13,
                  child: NotesTextField(focusNode: _focusNode),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.height20),
                    child: GestureDetector(
                      onTap: () {
                        context.read<AppState>().goToGoogle();
                      },
                      child: Text(
                        'Política de Privacidade',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: Dimensions.font14),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
