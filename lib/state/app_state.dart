import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:notes_mobx/state/validation_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/settings.dart';
import 'data_structure.dart';
import 'note.dart';
import 'package:uuid/uuid.dart';
part 'app_state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  @observable
  AppScreen currentScreen = AppScreen.login;

  @observable
  bool isLoading = false;

  @observable
  bool enter = false;

  @observable
  Response? response;

  @observable
  ObservableList<String> keys = ObservableList<String>();

  @observable
  ObservableList<Note> notes = ObservableList<Note>();

  @computed
  ObservableList<Note> get sortedNotes => ObservableList.of(notes.sorted());

  @action
  Future<void> createNote(String text) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final uuid = const Uuid().v1();
    final lastModified = DateTime.now();

    final newNote = {
      'uuid': uuid,
      'lastModified': lastModified.toIso8601String(),
      'text': text,
    };

    await prefs.setString(uuid, jsonEncode(newNote));
    keys.add(uuid);
    List<String> keysStringList = [];
    for (var key in keys) {
      keysStringList.add(key);
    }
    await prefs.setStringList('keys', keysStringList);

    final note = Note(
      uuid: uuid,
      lastModified: lastModified,
      text: text,
    );
    notes.add(note);
    isLoading = false;
  }

  @action
  Future<void> loadNotes() async {
    isLoading = true;
    print("before clear" + notes.toString());
    notes = ObservableList.of([]);
    keys = ObservableList.of([]);
    print("after clear" + notes.toString());
    final prefs = await SharedPreferences.getInstance();
    final stringListKeys = prefs.getStringList('keys') ?? [];
    if (stringListKeys.isNotEmpty) {
      keys.addAll(stringListKeys);
      List<Note> notesList = [];
      for (var key in keys) {
        final encodedData = prefs.getString(key) ?? "";
        if (encodedData.isNotEmpty) {
          final data = jsonDecode(encodedData);
          final note = Note(
            lastModified: DateTime.parse(data['lastModified'] as String),
            text: data['text'] as String,
            uuid: data['uuid'] as String,
          );
          notesList.add(note);
        }
      }
      notes = ObservableList.of(notesList);
    }

    currentScreen = AppScreen.notes;
    isLoading = false;
  }

  @action
  void goToNotes() {
    currentScreen = AppScreen.notes;
  }

  @action
  void goToGoogle() {
    currentScreen = AppScreen.goog;
  }

  @action
  void goToLogin() {
    currentScreen = AppScreen.login;
  }

  ValidationResponse validate({
    required String string,
  }) {
    // ignore: unused_local_variable
    try {
      String message = "Sucesso!";
      int status = 200;
      while (true) {
        if (string.isEmpty) {
          message = "Por favor preencha todos os campos.";
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
        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(string)) {
          message =
              "Por favor preencha os campos sem o uso de caracteres especiais";
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
      return ValidationResponse(
          status: status, data: DataStructure(message: message));
    } catch (_) {
      return const ValidationResponse(
          status: 404, data: DataStructure(message: ""));
    }
  }

  @action
  process({
    required String string,
  }) async {
    Dio dio = Dio();
    isLoading = true;

    try {
      if (Settings.mockApi) {
        ValidationResponse validationResponse = validate(string: string);
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              return handler.resolve(
                Response(
                    requestOptions: options,
                    data: validationResponse.data,
                    statusCode: validationResponse.status),
              );
            },
          ),
        );
      }
      response = await dio.get(Settings.validatorEndpoint,
          queryParameters: {Settings.validatorStringMapKey: string});
    } on DioException catch (e) {
      /*if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }*/
      response = Response(
          requestOptions: e.requestOptions, data: e.message, statusCode: 400);
    } finally {
      //dio.interceptors.clear();
      isLoading = false;
    }
  }
}

extension Sorted on List<Note> {
  List<Note> sorted() => [...this]..sort((lhs, rhs) {
      return rhs.lastModified.compareTo(lhs.lastModified); //descending
    });
}

enum AppScreen { login, notes, goog }
