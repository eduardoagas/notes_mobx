import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/dimensions.dart';
import '../../state/app_state.dart';
import '../components/custom_main_button.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final userController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      body: Container(
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
              padding: EdgeInsets.only(
                  bottom: Dimensions.height40,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.width15,
                          right: Dimensions.width8,
                          top: Dimensions.height5,
                        ),
                        child: Text(
                          'Usuário',
                          style: TextStyle(color: Colors.grey[200]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width8,
                            right: Dimensions.width8,
                            top: Dimensions.height5,
                            bottom: Dimensions.height5),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                size: Dimensions.font19,
                                Icons.person,
                                color: Colors.black,
                              ),
                              //labelText: "Usuário",

                              constraints: BoxConstraints(
                                maxWidth: Dimensions.screenWidth * 0.75,
                                maxHeight: Dimensions.height60,
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)))),
                          autofocus: false,
                          maxLines: 1,
                          controller: userController,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.width15,
                          right: Dimensions.width8,
                          top: Dimensions.height16,
                        ),
                        child: Text(
                          'Senha',
                          style: TextStyle(color: Colors.grey[200]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width8,
                            right: Dimensions.width8,
                            top: Dimensions.height5,
                            bottom: Dimensions.height5),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              constraints: BoxConstraints(
                                maxWidth: Dimensions.screenWidth * 0.75,
                                maxHeight: Dimensions.height60,
                              ),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width16,
                                      top: Dimensions.font19),
                                  child: FaIcon(
                                    FontAwesomeIcons.lock,
                                    size: Dimensions.height15,
                                    color: Colors.grey[900],
                                  )),
                              //labelText: "Senha",
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)))),
                          autofocus: false,
                          maxLines: 1,
                          controller: passwordController,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.height24),
                    child: Align(
                        alignment: Alignment.center,
                        child: CustomMainButton(
                          color: const Color.fromARGB(255, 0, 182, 64),
                          onPressed: () async {
                            try {
                              // ignore: unused_local_variable
                              late Response<dynamic> response;
                              // ignore: unused_local_variable
                              late Response<dynamic> response2;
                              if (context.mounted) {
                                await context
                                    .read<AppState>()
                                    .process(string: userController.text);
                              }
                              if (context.mounted) {
                                if (context
                                        .read<AppState>()
                                        .response
                                        ?.statusCode !=
                                    200) {
                                  throw Exception();
                                }
                              }
                              if (context.mounted) {
                                await context
                                    .read<AppState>()
                                    .process(string: passwordController.text);
                              }
                              if (context.mounted) {
                                if (context
                                        .read<AppState>()
                                        .response
                                        ?.statusCode !=
                                    200) {
                                  throw Exception();
                                }
                              }
                              if (context.mounted) {
                                context.read<AppState>().isLoggedIn = true;
                                context.read<AppState>().goToNotes();
                              }
                              ;
                            } catch (_) {
                            } finally {
                              if (context.mounted) {
                                context.read<AppState>().response = null;
                              }
                            }
                          },
                          isLoading: false,
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                                fontSize: Dimensions.font16,
                                color: Colors.grey[200]),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Dimensions.height40),
                child: GestureDetector(
                  onTap: () {
                    context.read<AppState>().goToGoogle();
                  },
                  child: Text('Política de Privacidade',
                      style: TextStyle(color: Colors.grey[200])),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
