import 'dart:convert';
import 'package:collection/collection.dart' as collection;
import 'package:zooper_flutter_id3/constants/terminations.dart';

import 'package:zooper_flutter_id3/convertions/utf16.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/tags/headers/id3_header.dart';

import 'id3v2_frame_content.dart';

class CommentFrameContent extends Id3v2FrameContent {
  late Encoding encoding;
  late String language;
  late String description;
  late String body;

  CommentFrameContent.decode(
    Id3Header header,
    Id3v2FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super() {
    decode(bytes, startIndex, size);
  }

  @override
  void decode(List<int> bytes, int startIndex, int size) {
    var subBytes = bytes.sublist(startIndex, startIndex + size);

    // Get the encoding
    encoding = getEncoding(subBytes[0]);
    language = _decodeLanguage(subBytes, 1, 3);

    // The index where the description will end
    final splitIndex = encoding is UTF16 ? _indexOfSplitPattern(subBytes, [0x00, 0x00], 4) : subBytes.indexOf(0x00, 4);

    description = _decodeDescription(subBytes, 4, splitIndex);

    final offset = splitIndex + (encoding is UTF16 ? 2 : 1);

    body = decodeBody(subBytes, offset);
  }

  String _decodeLanguage(List<int> bytes, int startIndex, int length) {
    return latin1.decode(bytes.sublist(startIndex, startIndex + length));
  }

  String _decodeDescription(List<int> bytes, int startIndex, int endIndex) {
    return endIndex < 0 ? '' : encoding.decode(bytes.sublist(startIndex, endIndex));
  }

  String decodeBody(List<int> bytes, int startIndex) {
    final bodyBytes = bytes.sublist(startIndex);
    return encoding.decode(bodyBytes);
  }

  int _indexOfSplitPattern(List<int> list, List<int> pattern, [int initialOffset = 0]) {
    for (var i = initialOffset; i < list.length - pattern.length; i += pattern.length) {
      final l = list.sublist(i, i + pattern.length);
      if (const collection.ListEquality().equals(l, pattern)) {
        return i;
      }
    }
    return -1;
  }

  @override
  List<int> encode() {
    return <int>[
      getIdFromEncoding(encoding),
      ...latin1.encode(language),
      ...encoding.encode(description),
      ...Terminations.getByEncoding(encoding),
      ...encoding.encode(body),
    ];
  }
}
