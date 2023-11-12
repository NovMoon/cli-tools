
import 'dart:io';

import 'package:cli_tools/cli_tools.dart';

void toastErr(dynamic msg, [bool isLine = true]) {
  final m = msg.toString().cRed();
  if(isLine) {
    stdout.writeln(m);
  } else {
    stdout.write(m);
  }
}

void toastSuc(dynamic msg, [bool isLine = true]) {
  final m = msg.toString().cGreen();
  if(isLine) {
    stdout.writeln(m);
  } else {
    stdout.write(m);
  }
}

void toast(dynamic msg, [bool isLine = true]) {
  final m = msg.toString();
  if(isLine) {
    stdout.writeln(m);
  } else {
    stdout.write(m);
  }
}

extension ToastExt on dynamic {
  void print([bool isLine = true]) {
    toast(this, isLine);
  }
  void printErr([bool isLine = true]) {
    toastErr(this, isLine);
  }
  void printSuc([bool isLine = true]) {
    toastSuc(this, isLine);
  }
}