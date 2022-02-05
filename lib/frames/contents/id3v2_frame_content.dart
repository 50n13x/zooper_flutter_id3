import 'dart:convert';
import 'package:collection/collection.dart' as collection;

import 'package:zooper_flutter_id3/constants/encoding_bytes.dart';
import 'package:zooper_flutter_id3/convertions/hex_encoding.dart';
import 'package:zooper_flutter_id3/convertions/utf16.dart';
import 'package:zooper_flutter_id3/enums/frame_name.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

import 'text_frame_content.dart';

abstract class FrameContent {
  factory FrameContent.decode(
      Id3Header header, Id3v2FrameHeader frameHeader, List<int> bytes, int startIndex, int size) {
    switch (frameHeader.frameIdentifier.frameName) {
      case FrameName.picture:
        throw UnimplementedError();
      case FrameName.comment:
        return CommentFrameContent.decode(header, frameHeader, bytes, startIndex, size);
      default:
        return TextFrameContent.decode(header, frameHeader, bytes, startIndex, size);
    }
  }

  FrameContent();

  Encoding getEncoding(int type) {
    switch (type) {
      case EncodingBytes.latin1:
        return latin1;
      case EncodingBytes.utf8:
        return const Utf8Codec(allowMalformed: true);
      case EncodingBytes.utf16:
        return UTF16LE();
      case EncodingBytes.utf16be:
        return UTF16BE();
      default:
        return HEXEncoding();
    }
  }

  /// Returns size of frame in bytes
  List<int> frameSizeInBytes(int value) {
    assert(value <= 16777216);

    final block = List<int>.filled(4, 0);
    const sevenBitMask = 0x7f;

    block[0] = (value >> 21) & sevenBitMask;
    block[1] = (value >> 14) & sevenBitMask;
    block[2] = (value >> 7) & sevenBitMask;
    block[3] = (value >> 0) & sevenBitMask;

    return block;
  }

  void decode(List<int> bytes, int startIndex, int size);
}

class CommentFrameContent extends FrameContent {
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
    language = decodeLanguage(bytes, 1, 3);

    // The index where the description will end
    // TODO: "Check if subBytes.indexOf(0x00, 4)" needs the "4"
    final splitIndex = encoding is UTF16 ? indexOfSplitPattern(subBytes, [0x00, 0x00], 4) : subBytes.indexOf(0x00, 4);

    description = decodeDescription(subBytes, 4, splitIndex);

    final offset = splitIndex + (encoding is UTF16 ? 2 : 1);

    body = decodeBody(subBytes, offset);
  }

  String decodeLanguage(List<int> bytes, int startIndex, int length) {
    return latin1.decode(bytes.sublist(startIndex, startIndex + length));
  }

  String decodeDescription(List<int> bytes, int startIndex, int endIndex) {
    return endIndex < 0 ? '' : encoding.decode(bytes.sublist(startIndex, endIndex));
  }

  String decodeBody(List<int> bytes, int startIndex) {
    final bodyBytes = bytes.sublist(startIndex);
    return encoding.decode(bodyBytes);
  }

  int indexOfSplitPattern(List<int> list, List<int> pattern, [int initialOffset = 0]) {
    for (var i = initialOffset; i < list.length - pattern.length; i += pattern.length) {
      final l = list.sublist(i, i + pattern.length);
      if (const collection.ListEquality().equals(l, pattern)) {
        return i;
      }
    }
    return -1;
  }
}
