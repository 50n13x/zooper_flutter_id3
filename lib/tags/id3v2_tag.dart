import 'dart:typed_data';

import 'package:zooper_flutter_id3/frames/id3_frame.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';
import 'package:zooper_flutter_id3/headers/id3v2_header.dart';
import 'package:zooper_flutter_id3/tags/id3_tag.dart';

abstract class Id3v2Tag extends Id3Tag {
  Id3v2Tag(Id3Header header) : super(header);
}

class Id3v23Tag extends Id3v2Tag {
  factory Id3v23Tag.load(Uint8List bytes) {
    var header = Id3v2Header(bytes, 0);

    return Id3v23Tag._internal(header);
  }

  Id3v23Tag._internal(Id3Header header) : super(header);

  @override
  bool isFrameSupported(Id3Frame frame) {
    // TODO: implement isFrameSupported
    throw UnimplementedError();
  }

  @override
  List<int> toByteList() {
    // TODO: implement toByteList
    throw UnimplementedError();
  }
}
