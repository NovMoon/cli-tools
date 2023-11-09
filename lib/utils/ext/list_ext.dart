import 'dart:io';

extension ListExt on List<String> {
  Future<String?> runAsCmd() async {
    final list = [
      for (var item in this)
        if (item.trim().isNotEmpty) item.trim() else ''
    ];

    print('执行：${list.join(' ')}');

    final result = await Process.run(list.removeAt(0), list, runInShell: true);
    if (result.exitCode != 0) {
      print('${result.stderr}');
      return null;
    }
    return result.stdout.toString();
  }
}