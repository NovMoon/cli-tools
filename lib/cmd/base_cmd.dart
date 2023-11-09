mixin Runnable {
  Future<int> start(List<String> arguments);
}


abstract class BaseCmd with Runnable {
  const BaseCmd();

  String get cmd;

  String get help => '';
}
