
import 'dart:io';

extension FileExt on FileSystemEntity {
  String get name {
    return path.split(Platform.pathSeparator).last;
  }
  FileSystemEntity? findFromParent(bool Function(FileSystemEntity entity) find, {bool inHear = true}) {
    if(this is! Directory) {
      if(find(this)) {
        return this;
      }
      return null;
    }
    for (var f in (this as Directory).listSync()) {
      if(find(f)) {
        return f;
      }
    }
    return parent.findFromParent(find, inHear: inHear);
  }
}

extension DirectoryExt on Directory {

}