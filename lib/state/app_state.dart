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

  // @observable
  // bool? isLoggedIn;

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
    final id = const Uuid().v1();
    final lastModified = DateTime.now();

    final newNote = {
      'id': id,
      'lastModified': lastModified.toIso8601String(),
      'text': text,
    };

    await prefs.setString(id, newNote.toString());
    keys.add(id);
    await prefs.setStringList('keys', keys);

    final note = Note(
      id: id,
      lastModified: lastModified,
      text: text,
    );
    notes.add(note);
    isLoading = false;
  }

  @action
  Future<void> loadNotes() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final stringListkeys = prefs.getStringList('keys') ?? [];
    keys.addAll(stringListkeys);
    final notesDataStringList =
        keys.map((key) => prefs.getString(key) ?? "[]").toList();

    notesDataStringList.map((notesDataString) {
      final data = json.decode(notesDataString);

      notes.add(Note(
        id: data['id'],
        lastModified: DateTime.tryParse(data['lastModified']) ?? DateTime.now(),
        text: data['text'],
      ));
    });
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

  @action
  Future<void> initialize() async {
    isLoading = true;
    //isLoggedIn = false; // get from shared preferences
    //if (isLoggedIn == null || isLoggedIn == false) {
    //  currentScreen = AppScreen.login;
    //} else {
    await loadNotes();
    currentScreen = AppScreen.notes;
    //}
    isLoading = false;
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
      return lhs.lastModified.compareTo(rhs.lastModified);
    });
}

enum AppScreen { login, notes, goog }
