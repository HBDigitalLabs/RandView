import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart' as p;

class IntLimits {
  static const int unsignedIntMaxValue = 4_294_967_295;
}

enum ProcessStatus { successfuly, unsuccessfuly }

class ImageStorage {
  static const imageJsonName = "images.json";

  static Future<File> _getJsonFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, imageJsonName));

    if (!await file.exists()) {
      await file.writeAsString(jsonEncode([]));
    }

    return file;
  }

  static Future<String> _copyFileToAppDocuments(String path) async {
    final random = Random();

    final dir = await getApplicationDocumentsDirectory();
    final stringRandomNumber = random
        .nextInt(IntLimits.unsignedIntMaxValue)
        .toString();
    final newPath = p.join(dir.path, "${stringRandomNumber}_${p.basename(path)}");

    try {
      final sourceFile = File(path);
      await sourceFile.copy(newPath);
    } catch (e) {

      rethrow;
    }

    return newPath;
  }

  static Future<ProcessStatus> removeImage(String path) async {
    final file = await _getJsonFile();

    final data = await file.readAsString();
    final jsonData = List<String>.from(jsonDecode(data));

    try {
      final imageFile = File(path);

      if (!await imageFile.exists()) {
        return ProcessStatus.unsuccessfuly;
      }

      await imageFile.delete();
      jsonData.remove(path);
    } catch (_) {
      return ProcessStatus.unsuccessfuly;
    }

    await file.writeAsString(jsonEncode(jsonData));

    return ProcessStatus.successfuly;
  }

  static Future<ProcessStatus> removeAllImportedImages() async {
    final imagePaths = await getImagePaths();
    for(String i in imagePaths){
      final result = await removeImage(i);
      if(result != ProcessStatus.successfuly){
        return result;
      }
    }
    return ProcessStatus.successfuly;
  }

  static Future<ProcessStatus> addImage(String path) async {
    String newPath = "";

    try {
      newPath = await _copyFileToAppDocuments(path);
    } catch (_) {
      return ProcessStatus.unsuccessfuly;
    }

    final file = await _getJsonFile();

    final data = await file.readAsString();
    final jsonData = List<String>.from(jsonDecode(data));

    jsonData.add(newPath);

    await file.writeAsString(jsonEncode(jsonData));

    return ProcessStatus.successfuly;
  }

  static Future<List<String>> getImagePaths() async {
    final file = await _getJsonFile();
    final data = await file.readAsString();
    return List<String>.from(jsonDecode(data));
  }
}
