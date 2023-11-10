import 'dart:async';
import 'dart:convert';
import 'dart:io';

typedef RCallback<T> = void Function(T e);

extension IterableExt<T> on Iterable<T> {
  List<R> mapIndex<R>(R Function(T e, int index) f) {
    final result = <R>[];
    int i = 0;
    forEach((element) {
      result.add(f(element, i));
      i ++;
    });
    return result;
  }
}

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

  Future<Process> startAsCmd({RCallback<String>? out, RCallback<String>? err}) async {
    final list = [
      for (var item in this)
        if (item.trim().isNotEmpty) item.trim() else ''
    ];

    print('执行：${list.join(' ')}');

    String cmd = list.removeAt(0);

    final proc = await Process.start(cmd, list);
    final cliProcess = CliProcess(proc);

    var sub = proc.stdout.transform(utf8.decoder).listen(out ?? stdout.write);
    cliProcess._subs.add(sub);

    sub = proc.stderr.transform(utf8.decoder).listen(err ?? stderr.write);
    cliProcess._subs.add(sub);

    Future<void> f() async {
      await cliProcess.exitCode;
      cliProcess.recycle();
    }

    f();

    return cliProcess;
  }
}

class CliProcess extends Process {
  CliProcess(this.real);

  Process real;

  final List<StreamSubscription<dynamic>> _subs = [];

  @override
  Future<int> get exitCode => real.exitCode;

  @override
  bool kill([ProcessSignal signal = ProcessSignal.sigterm]) {
    return real.kill(signal);
  }

  @override
  int get pid => real.pid;

  @override
  Stream<List<int>> get stderr => real.stderr;

  @override
  IOSink get stdin => real.stdin;

  @override
  Stream<List<int>> get stdout => real.stdout;

  void recycle() {
    for (var element in _subs) {
      element.cancel();
    }
    _subs.clear();
  }
}
