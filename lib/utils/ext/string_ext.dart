import 'dart:convert';
import 'dart:io';

import 'package:ansicolor/ansicolor.dart';
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

extension StrColorExt on String {
  static final AnsiPen _pen = AnsiPen();
  String cRed({bool bg = false, bool bold = false}) {
    _pen.reset();
    _pen.red(bg: bg, bold: bold);
    return _pen(this);
  }

  String cBlack({bool bg = false, bool bold = false}) {
    _pen.reset();
    _pen.black(bg: bg, bold: bold);
    return _pen(this);
  }

  String cGreen({bool bg = false, bool bold = false}) {
    _pen.reset();
    _pen.green(bg: bg, bold: bold);
    return _pen(this);
  }

  String cYellow({bool bg = false, bool bold = false}) {
    _pen.reset();
    _pen.yellow(bg: bg, bold: bold);
    return _pen(this);
  }

  String cBlue({bool bg = false, bool bold = false}) {
    _pen.reset();
    _pen.blue(bg: bg, bold: bold);
    return _pen(this);
  }

  String cMagenta({bool bg = false, bool bold = false}) {
    _pen.reset();
    _pen.magenta(bg: bg, bold: bold);
    return _pen(this);
  }

  String cCyan({bool bg = false, bool bold = false}) {
    _pen.reset();
    _pen.cyan(bg: bg, bold: bold);
    return _pen(this);
  }

  String cWhite({bool bg = false, bool bold = false}) {
    _pen.reset();
    _pen.white(bg: bg, bold: bold);
    return _pen(this);
  }

  String cGray({bool bg = false, num level = 1.0}) {
    _pen.reset();
    _pen.gray(bg: bg, level: level);
    return _pen(this);
  }

  static final RegExp _removeReg = RegExp(r'\[\d+;\d;\d+m|\[0m');

  String removeColor() {
    String str = this;
    str = replaceAll(_removeReg, '');
    return str;
  }
}

extension StringExt on String {
  String get firstLine {
    final result = split('\n');
    return result[0];
  }

  String get asLine {
    return '$this\n';
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
