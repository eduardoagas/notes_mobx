import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_mobx/dialogs/show_message.dart';
import 'package:notes_mobx/views/notes/notes_view.dart';
import 'package:notes_mobx/views/webview/goog_view.dart';
import 'package:provider/provider.dart';
import 'loading/loading_screen.dart';
import 'state/app_state.dart';
import 'views/login/login_view.dart';

void main() {
  runApp(
    Provider(
      create: (_) => AppState(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
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

              final response = context.read<AppState>().response;
              if (response != null) {
                if (response.statusCode != 200) {
                  showMessage(
                    message: response.data.message,
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
              case AppScreen.goog:
                return const GoogleView();
            }
          },
        ),
      ),
    );
  }
}
