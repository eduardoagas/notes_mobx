import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/dimensions.dart';
import '../../state/app_state.dart';
import '../components/custom_main_button.dart';

class LoginView extends StatefulHookWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
              Color.fromARGB(255, 30, 83, 101),
              Color.fromARGB(255, 43, 142, 137),
            ])),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: Dimensions.height40, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.width10,
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
                          prefixIcon: const Icon(Icons.person),
                          //labelText: "Usuário",

                          constraints: BoxConstraints(
                            maxWidth: Dimensions.screenWidth * 0.7,
                            maxHeight: Dimensions.height50,
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
                      left: Dimensions.width10,
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
                            maxWidth: Dimensions.screenWidth * 0.7,
                            maxHeight: Dimensions.height50,
                          ),
                          prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.height13,
                                  top: Dimensions.height10),
                              child: FaIcon(FontAwesomeIcons.lock,
                                  size: Dimensions.font20)),
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
                padding: EdgeInsets.only(top: Dimensions.height20),
                child: Align(
                    alignment: Alignment.center,
                    child: CustomMainButton(
                      color: const Color.fromARGB(255, 68, 190, 110),
                      onPressed: () async {
                        try {
                          // ignore: unused_local_variable
                          late Response<dynamic> response;
                          // ignore: unused_local_variable
                          late Response<dynamic> response2;
                          response = await context
                              .read<AppState>()
                              .process(string: userController.text);
                          if (context.mounted) {
                            response2 = await context
                                .read<AppState>()
                                .process(string: passwordController.text);
                          }
                        } catch (_) {}
                      },
                      isLoading: false,
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                            fontSize: Dimensions.font18,
                            color: Colors.grey[200]),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
