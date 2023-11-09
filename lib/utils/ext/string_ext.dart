import 'dart:convert';
import 'dart:io';

import 'package:cli_tools/utils/ext/list_ext.dart';

const String _l1 = '****';
const String _l2 = '----';

extension StringNullableExt on String? {
  bool get isNull {
    return this == null;
  }
  bool get beEmptyOrNull {
    return this == null || this!.isEmpty;
  }
  bool get beNotEmptyOrNull {
    return !beEmptyOrNull;
  }

  bool get beEmpty {
    return this != null && this!.isEmpty;
  }

  bool get beNotEmpty {
    return !beEmpty;
  }
}

extension StringExt on String {
  String get firstLine {
    final result = split('\n');
    return result[0];
  }

  Future<bool> toClipboard() async {
    var cmd = 'pbcopy';
    if (Platform.isWindows) {
      cmd = 'clip';
    }
    final p = await Process.start(cmd, [], runInShell: true);
    p.stderr.transform(utf8.decoder).listen(print);
    p.stdin.write(this);
    bool result;
    try {
      await p.stdin.close();
      result = await p.exitCode == 0;
    } catch (e) {
      result = false;
    }
    if (result) {
      print('复制到粘贴板成功');
    } else {
      print('复制到粘贴板失败');
    }
    return result;
  }

  Future<String?> runAsCmd() => split(' ').runAsCmd();
}

extension IntExt on int {
  String get dividerOuter => _l1 * this;

  String get dividerInner => _l2 * this;

  String get emptyStr => ' ' * this;

  Iterable get iterable {
    return [for (var i = 0; i < this; i++) i];
  }
}
