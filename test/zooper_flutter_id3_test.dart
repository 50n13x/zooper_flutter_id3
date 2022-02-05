import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zooper_flutter_id3/zooper_audiofile.dart';

void main() {
  const String file1 = 'C:/Users/Danie/Desktop/1.mp3';
  const String file2 = 'C:/Users/Danie/Desktop/2.mp3';
  const String file3 = 'C:/Users/Danie/Desktop/3.mp3';

  test('Loading file', () async {
    //var filePath = await _pickFile();

    final bytes = await _loadBytesAsync(file3);

    final ZooperAudioFile audioFile = ZooperAudioFile.load(bytes);

    debugPrint(audioFile.toString());

    await saveFileAsync(audioFile.audioData);
  });
}

Future<Uint8List> _loadBytesAsync(String filePath) async {
  File file = File(filePath);
  Uint8List bytes = await file.readAsBytes();

  return bytes;
}

Future<void> saveFileAsync(List<int> bytes) async {
  File file = File('C:/Users/Danie/Desktop/test.mp3');
  await file.writeAsBytes(bytes);
}

Future<File> _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    return File(result.files.single.path!);
  } else {
    throw Exception('Error loading file');
  }
}
