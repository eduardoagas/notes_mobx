// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  Computed<ObservableList<Note>>? _$sortedNotesComputed;

  @override
  ObservableList<Note> get sortedNotes => (_$sortedNotesComputed ??=
          Computed<ObservableList<Note>>(() => super.sortedNotes,
              name: '_AppState.sortedNotes'))
      .value;

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

  late final _$notesAtom = Atom(name: '_AppState.notes', context: context);

  @override
  ObservableList<Note> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<Note> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$initializeAsyncAction =
      AsyncAction('_AppState.initialize', context: context);

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$processAsyncAction =
      AsyncAction('_AppState.process', context: context);

  @override
  Future process({required String string}) {
    return _$processAsyncAction.run(() => super.process(string: string));
  }

  late final _$_AppStateActionController =
      ActionController(name: '_AppState', context: context);

  @override
  void goToNotes() {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.goToNotes');
    try {
      return super.goToNotes();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToGoogle() {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.goToGoogle');
    try {
      return super.goToGoogle();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToLogin() {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.goToLogin');
    try {
      return super.goToLogin();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
isLoading: ${isLoading},
response: ${response},
notes: ${notes},
sortedNotes: ${sortedNotes}
    ''';
  }
}
