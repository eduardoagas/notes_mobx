// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  late final _$currentScreenAtom =
      Atom(name: '_AppState.currentScreen', context: context);

  @override
  AppScreen get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(AppScreen value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppState.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: '_AppState.isLoggedIn', context: context);

  @override
  bool? get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool? value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$responseAtom =
      Atom(name: '_AppState.response', context: context);

  @override
  Response<dynamic>? get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(Response<dynamic>? value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  late final _$initializeAsyncAction =
      AsyncAction('_AppState.initialize', context: context);

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$_loadNotesAsyncAction =
      AsyncAction('_AppState._loadNotes', context: context);

  @override
  Future<bool> _loadNotes() {
    return _$_loadNotesAsyncAction.run(() => super._loadNotes());
  }

  late final _$processAsyncAction =
      AsyncAction('_AppState.process', context: context);

  @override
  Future process({required String string}) {
    return _$processAsyncAction.run(() => super.process(string: string));
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
isLoading: ${isLoading},
isLoggedIn: ${isLoggedIn},
response: ${response}
    ''';
  }
}
