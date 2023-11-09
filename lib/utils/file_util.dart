import 'dart:io';

import 'package:cli_tools/utils/ext/string_ext.dart';

class Env {
  static String get homeOnly => Platform.environment['HOME']!;

  static String get home => homeOnly + Platform.pathSeparator;

  static String get bashProfile {
    return '$home.bash_profile';
  }

  static Future<String?> addX(String file) {
    return 'chmod +x $file'.runAsCmd();
  }

  static void addToBashProfile(final String cmd) {
    final file = File(bashProfile);
    final list = file.readAsLinesSync();

    for(var i=0; i<list.length; i++) {
      final line = list[i];
      if(line == cmd) {
        return;
      }
    }
    list.add('\n');
    list.add(cmd);
    file.writeAsStringSync(list.join('\n'));
  }

  static File? createHomeFile(final String fileName) {
    final file = File('${Env.home}$fileName');
    if(!file.existsSync()) {
      file.createSync();
    }
    return file;
  }
}

