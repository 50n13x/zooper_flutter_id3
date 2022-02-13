import 'dart:convert';

import 'package:zooper_flutter_encoding_utf16/zooper_flutter_encoding_utf16.dart';
import 'package:zooper_flutter_id3/constants/encoding_bytes.dart';
import 'package:zooper_flutter_id3/convertions/hex_encoding.dart';
import 'package:zooper_flutter_id3/enums/frame_name.dart';
import 'package:zooper_flutter_id3/frames/contents/frame_content.dart';
import 'package:zooper_flutter_id3/frames/contents/ignored_frame_content.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/frames/models/frame_content_model.dart';
import 'package:zooper_flutter_id3/tags/headers/id3_header.dart';

import '../frame_type.dart';
import 'comment_frame_content.dart';
import 'text_frame_content.dart';

abstract class Id3v2FrameContent<TModel extends FrameContentModel> extends FrameContent {
  late TModel model;

  factory Id3v2FrameContent.decode(
      Id3Header header, Id3v2FrameHeader frameHeader, List<int> bytes, int startIndex, int size) {
    switch (frameHeader.identifier.frameType) {
      case FrameType.custom:
        switch (frameHeader.identifier.frameName) {
          // TODO: Implement picture
          case FrameName.picture:
            return IgnoredFrameContent.decode(header, frameHeader, bytes, startIndex, size)
                as Id3v2FrameContent<TModel>;

          case FrameName.comment:
            return CommentFrameContent.decode(header, frameHeader, bytes, startIndex, size)
                as Id3v2FrameContent<TModel>;

          // TODO: Implement additional info
          case FrameName.additionalInfo:
            return IgnoredFrameContent.decode(header, frameHeader, bytes, startIndex, size)
                as Id3v2FrameContent<TModel>;

          default:
            return IgnoredFrameContent.decode(header, frameHeader, bytes, startIndex, size)
                as Id3v2FrameContent<TModel>;
        }

      case FrameType.text:
        return TextFrameContent.decode(header, frameHeader, bytes, startIndex, size) as Id3v2FrameContent<TModel>;

      case FrameType.url:
        // TODO: Implement URL frames
        return IgnoredFrameContent.decode(header, frameHeader, bytes, startIndex, size) as Id3v2FrameContent<TModel>;

      case FrameType.other:
        return IgnoredFrameContent.decode(header, frameHeader, bytes, startIndex, size) as Id3v2FrameContent<TModel>;
    }
  }

  Id3v2FrameContent();

  /// Gets the [Encoding] by it's [typeId]
  Encoding getEncoding(int typeId) {
    switch (typeId) {
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

  /// Gets the type id of the [Encoding] by the [type]
  int getIdFromEncoding(Encoding type) {
    switch (type.runtimeType) {
      case Latin1Codec:
        return EncodingBytes.latin1;
      case UTF16LE:
        return EncodingBytes.utf16;
      case UTF16BE:
        return EncodingBytes.utf16be;
      case Utf8Codec:
        return EncodingBytes.utf8;
      default:
        throw UnimplementedError('Encoding type $type is not implemented yet');
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
}
