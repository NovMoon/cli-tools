import 'dart:io';

extension FileExt on FileSystemEntity {
  String get name {
    return path.split(Platform.pathSeparator).last;
  }

  FileSystemEntity? findFromParent(bool Function(FileSystemEntity entity) find,
      {bool inHear = true}) {
    if (this is! Directory) {
      if (find(this)) {
        return this;
      }
      return null;
    }
    for (var f in (this as Directory).listSync()) {
      if (find(f)) {
        return f;
      }
    }

    return parent.findFromParent(find, inHear: inHear);
  }

  Directory? get asDir {
    if (isDir) {
      return this as Directory;
    }
    return null;
  }
}

extension FileNullExt on FileSystemEntity? {

  bool get isDir {
    return this is Directory;
  }

  Directory? get asDir {
    if (isDir) {
      return this as Directory;
    }
    return null;
  }
}

extension DirectoryExt on Directory {
  bool hasChild(String name) {
    return listSync().any((element) => element.name == name);
  }

  FileSystemEntity? child(String name) {
    for (var value in listSync()) {
      if (value.name == name) {
        return value;
      }
    }
    return null;
  }
}
