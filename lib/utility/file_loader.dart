import 'package:flutter/services.dart';

class FileLoader {
  static Future<void> loadFile({
    required String path,
    required Function(String) callback,
  }) async {
    final loadedData = await rootBundle.loadString(path);
    callback(loadedData.toString());
  }
}
