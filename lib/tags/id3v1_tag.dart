import 'dart:convert';

import 'package:zooper_flutter_id3/frames/id3v1_frame.dart';
import 'package:zooper_flutter_id3/tags/contents/id3v1_content.dart';
import 'package:zooper_flutter_id3/tags/id3_tag.dart';

import 'headers/id3v1_header.dart';

class Id3v1Tag extends Id3Tag<Id3v1Frame> {
  static const int tagLength = 128;

  factory Id3v1Tag.decode(List<int> bytes) {
    var header = Id3v1Header(bytes, bytes.length - tagLength);
    var content = Id3v1Content.decode(header, bytes, bytes.length - tagLength + header.headerSize);

    return Id3v1Tag(header, content);
  }

  Id3v1Tag(Id3v1Header header, Id3v1Content content) : super(header, content);

  @override
  List<int> encode() {
    return <int>[
      ...latin1.encode(header.identifier),
      ...content.encode(),
    ];
  }
}
