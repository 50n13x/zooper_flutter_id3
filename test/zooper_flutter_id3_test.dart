// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';

//import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zooper_flutter_id3/enums/frame_name.dart';
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

  test('Read and save file', () async {
    final bytes = await _loadBytesAsync(file3);

    final audioFile = ZooperAudioFile.decode(bytes);

    var encoded = audioFile.encode();
    await saveFileAsync(encoded, 'test3');
  });

  test('Id3v2 contains frame', () async {
    final bytes = await _loadBytesAsync(file3);

    final audioFile = ZooperAudioFile.decode(bytes);

    var containsFrame = audioFile.id3v2?.containsFrameWithIdentifier(FrameName.title);

    expect(containsFrame, true);
  });
}

Future<Uint8List> _loadBytesAsync(String filePath) async {
  File file = File(filePath);
  Uint8List bytes = await file.readAsBytes();

  return bytes;
}

Future<void> saveFileAsync(List<int> bytes, String name) async {
  File file = File('C:/Users/Danie/Desktop/$name.mp3');
  await file.writeAsBytes(bytes);
}

/*Future<File> _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    return File(result.files.single.path!);
  } else {
    throw Exception('Error loading file');
  }
}
*/