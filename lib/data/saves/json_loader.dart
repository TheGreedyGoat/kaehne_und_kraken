import 'dart:io';
import 'package:path_provider/path_provider.dart';

const String shipSaveFileName = 'ships';

class JsonLoader {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName, String extension) async {
    final path = await _localPath;
    return File('$path/$fileName.$extension');
  }

  static Future<File> writeFile(
    String content,
    String fileName,
    String extension,
  ) async {
    final file = await _localFile(fileName, extension);

    return file.writeAsString(content);
  }

  static Future<String> readFile(String fileName, String extension) async {
    final file = await _localFile(fileName, extension);
    if (!await file.exists()) {
      await file.create();
      file.writeAsString('[]');
    }
    return file.readAsString();
  }
}
