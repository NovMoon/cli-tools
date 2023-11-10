import 'dart:async';
import 'dart:convert';
import 'dart:io';

Stream<String>? _stdin;

Stream<String> get keystrokes {
  return _stdin ??=
      stdin.transform<String>(const AsciiDecoder(allowInvalid: true)).asBroadcastStream();
}

bool lockInput = false;

Completer<bool> _locked = Completer<bool>();

Future<bool> get locked => _locked.future;

void unlockMain() {
  if(_locked.isCompleted) {
    return;
  }
  _locked.complete(true);
}

void lockMain() {
  if(_locked.isCompleted) {
    _locked = Completer<bool>();
  }
}

bool get singleCharMode {
  return stdin.lineMode && stdin.echoMode;
}

set singleCharMode(bool value) {
  // The order of setting lineMode and echoMode is important on Windows.
  if (value) {
    stdin.echoMode = false;
    stdin.lineMode = false;
  } else {
    stdin.lineMode = true;
    stdin.echoMode = true;
  }
}

Future<String> promptForCharInput(List<String> acceptedCharacters) async {
  assert(acceptedCharacters.isNotEmpty);
  String? choice;
  lockInput = true;
  singleCharMode = true;
  while (choice == null || choice.length > 1 || !acceptedCharacters.contains(choice)) {
    choice = (await keystrokes.first).trim();
  }
  singleCharMode = false;
  lockInput = false;
  return choice;
}
