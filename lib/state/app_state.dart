import 'package:mobx/mobx.dart';
import 'package:notes_mobx/state/validation_response.dart';
import 'package:dio/dio.dart';

import '../constants/settings.dart';

part 'app_state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  @observable
  AppScreen currentScreen = AppScreen.login;

  @observable
  bool isLoading = false;

  @observable
  Dio dio = Dio();

  @observable
  bool? isLoggedIn;

  @observable
  late Response response;

  @observable
  ValidationResponse? validationResponse;

  @action
  Future<void> initialize() async {
    isLoading = true;
    isLoggedIn = false; // get from shared preferences
    if (isLoggedIn == null || isLoggedIn == false) {
      
      currentScreen = AppScreen.login;
    } else {
      await _loadNotes();
      currentScreen = AppScreen.notes;
    }
    isLoading = false;
  }

  @action
  Future<bool> _loadReminders() async {
    final userId = currentUser?.uid;
    if (userId == null) {
      return false;
    }
    final collection =
        await FirebaseFirestore.instance.collection(userId).get();
    final reminders = collection.docs.map((doc) => Reminder(
          id: doc.id,
          creationDate:
              DateTime.parse(doc[_DocumentKeys.creationDate] as String),
          isDone: doc[_DocumentKeys.isDone] as bool,
          text: doc[_DocumentKeys.text] as String,
        ));
    this.reminders = ObservableList.of(reminders);
    return true;
  }

  @action
  void validate({
    required String string,
  }) {
    try {
      String message = "Sucesso!";
      int status = 200;
      while (true) {
        if (!RegExp(r'[a-zA-Z0-9]/s]').hasMatch(string)) {
          message =
              "Por favor preencha os campos sem o uso de caracteres especiais";
          status = 422;
          break;
        }
        if (string.length > 20) {
          message =
              "Por favor preencha os campos usando no máximo vinte caracteres";
          status = 422;
          break;
        }
        if (string.length < 2) {
          message =
              "Por favor preencha os campos usando no mínimo dois caracteres";
          status = 422;
          break;
        }
        if (string.endsWith(" ")) {
          message =
              "Por favor preencha os campos sem que o último caractere seja um espaço";
          status = 422;
          break;
        }
        break;
      }
      validationResponse = ValidationResponse(status: status, message: message);
    } catch (_) {
      validationResponse = const ValidationResponse(status: 404, message: "");
    }
  }

  @action
  Future<Response> process({
    required String string,
  }) async {
    isLoading = true;

    try {
      if (Settings.mockApi) {
        validate(string: string);
        if (validationResponse != null) {
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) {
                return handler.resolve(
                  Response(
                      requestOptions: options,
                      data: validationResponse?.message,
                      statusCode: validationResponse?.status),
                );
              },
            ),
          );
        }
      }
      response = await dio.get(Settings.validatorEndpoint,
          queryParameters: {Settings.validatorStringMapKey: string});
      return response;
    } on DioException catch (e) {
      /*if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }*/
      return Response(
          requestOptions: e.requestOptions, data: e.message, statusCode: 400);
    } finally {
      dio.interceptors.clear();
      isLoading = false;
    }
  }
}

enum AppScreen { login, notes }
