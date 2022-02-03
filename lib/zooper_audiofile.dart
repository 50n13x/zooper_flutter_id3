import 'dart:typed_data';

import 'package:zooper_flutter_id3/tags/id3v1_tag.dart';
import 'package:zooper_flutter_id3/tags/id3v2_tag.dart';

class ZooperAudioFile {
  Id3v1Tag? _id3v1tag;
  Id3v2Tag? _id3v2tag;

  ZooperAudioFile.load(Uint8List bytes) {
    _id3v1tag = Id3v1Tag.load(bytes);
  }

  Id3v1Tag? get id3v1 => _id3v1tag;
  Id3v2Tag? get id3v2 => _id3v2tag;
}
