import 'dart:convert';

import 'package:zooper_flutter_id3/constants/terminations.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

import 'id3v2_frame_content.dart';

abstract class TextFrameContent extends Id3v2FrameContent {
  factory TextFrameContent.decode(
    Id3Header header,
    Id3v2FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
    int size,
  ) {
    if (header.majorVersion == 4) {
      return _Id3v24TextFrameContent.decode(header, frameHeader, bytes, startIndex, size);
    }

    return _DefaultTextFrameContent.decode(header, frameHeader, bytes, startIndex, size);
  }

  TextFrameContent._decode(
    Id3Header header,
    Id3v2FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super() {
    decode(bytes, startIndex, size);
  }

  late String _value;
  String get value => _value;

  late Encoding _encoding;
  Encoding get encoding => _encoding;

  @override
  void decode(List<int> bytes, int startIndex, int size) {
    var sublist = bytes.sublist(startIndex, startIndex + size);

    // Get the encoding
    _encoding = getEncoding(sublist[0]);

    var termination = Terminations.getByEncoding(encoding);
    bool hasTermination = Terminations.hasTermination(
      sublist.sublist(1),
      termination,
    );

    var end = hasTermination ? sublist.length - termination.length : sublist.length;

    // Decode the string
    _value = encoding.decode(sublist.sublist(1, end));
  }

  @override
  String toString() {
    return _value;
  }
}

class _DefaultTextFrameContent extends TextFrameContent {
  _DefaultTextFrameContent.decode(
    Id3Header header,
    Id3v2FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super._decode(header, frameHeader, bytes, startIndex, size);

  @override
  List<int> encode() {
    var bytes = <int>[
      getIdFromEncoding(encoding),
      ...encoding.encode(value),
      ...Terminations.getByEncoding(encoding),
    ];

    return bytes;
  }
}

class _Id3v24TextFrameContent extends TextFrameContent {
  _Id3v24TextFrameContent.decode(
    Id3Header header,
    Id3v2FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super._decode(header, frameHeader, bytes, startIndex, size);

  @override
  List<int> encode() {
    return <int>[
      getIdFromEncoding(encoding),
      ...encoding.encode(value),
      ...Terminations.getByEncoding(encoding),
    ];
  }
}
