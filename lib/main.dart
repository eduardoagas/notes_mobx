import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_mobx/dialogs/show_message.dart';
import 'package:notes_mobx/views/notes/notes_view.dart';
import 'package:provider/provider.dart';
import 'loading/loading_screen.dart';
import 'state/app_state.dart';
import 'views/login/login_view.dart';

void main() {
  runApp(
    Provider(
      create: (_) => AppState(
          //authService: FirebaseAuthService(),
          //remindersService: FirestoreRemindersService(),
          //imageUploadService: FirebaseImageUploadService(),
          )
      //..initialize()
      ,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ReactionBuilder(
        builder: (context) {
          return autorun(
            (_) {
              // handle loading screen
              final isLoading = context.read<AppState>().isLoading;
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                  text: 'Loading...',
                );
              } else {
                LoadingScreen.instance().hide();
              }

              final validationResponse =
                  context.read<AppState>().validationResponse;
              if (validationResponse != null) {
                if (validationResponse.status != 200) {
                  showMessage(
                    message: validationResponse.message,
                    context: context,
                  );
                }
              }
            },
          );
        },
        child: Observer(
          name: "CurrentScreen",
          builder: (context) {
            switch (context.read<AppState>().currentScreen) {
              case AppScreen.login:
                return const LoginView();
              case AppScreen.notes:
                return const NotesView();
            }
          },
        ),
      ),
    );
  }
}
