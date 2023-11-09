import 'dart:io';

bool yOrN(String? tip) {
  tip ??= '';
  print('$tip 是否确认 (Y/N): ');
  String? input = stdin.readLineSync()?.toUpperCase();

  return input != 'Y';
}