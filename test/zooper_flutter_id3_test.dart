// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zooper_flutter_id3/zooper_audiofile.dart';

const String file1 = 'C:/Users/Danie/Desktop/1.mp3';
const String file2 = 'C:/Users/Danie/Desktop/2.mp3';
const String file3 = 'C:/Users/Danie/Desktop/3.mp3';
const String file4 = 'C:/Users/Danie/Desktop/4.mp4';
const String file5 = 'C:/Users/Danie/Desktop/5.mp3';
const String file6 = 'C:/Users/Danie/Desktop/6.mp3';
const String file7 = 'C:/Users/Danie/Desktop/star_test.mp3';

void main() {
  var emojiString = '🔥';
  var emojiBytes = <int>[0xFF, 0xFE, 0x3D, 0xD8, 0x25, 0xDD];

  test('Loading file', () async {
    //var filePath = await _pickFile();

    final bytes = await _loadBytesAsync(file6);

    final ZooperAudioFile audioFile = ZooperAudioFile.decode(bytes);

    debugPrint(audioFile.toString());

    var encoded = audioFile.encode();
    await saveFileAsync(encoded);
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
