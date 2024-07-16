import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getFileFromUint8List(Uint8List bytes) async {
  final Directory tempDir = await getApplicationDocumentsDirectory();
  File file = File('${tempDir.path}/temp_'
      '${DateTime.now().microsecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes);
    return file;
}

Future<Uint8List> loadAssetImage(String path) async {
  ByteData data = await rootBundle.load(path);
  return data.buffer.asUint8List();
}