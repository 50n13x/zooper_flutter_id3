import 'dart:convert';

import 'package:zooper_flutter_id3/constants/encoding_bytes.dart';
import 'package:zooper_flutter_id3/convertions/hex_encoding.dart';
import 'package:zooper_flutter_id3/convertions/utf16.dart';
import 'package:zooper_flutter_id3/enums/frame_name.dart';
import 'package:zooper_flutter_id3/frames/contents/frame_content.dart';
import 'package:zooper_flutter_id3/frames/contents/ignored_frame_content.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

import 'comment_frame_content.dart';
import 'text_frame_content.dart';

abstract class Id3v2FrameContent extends FrameContent {
  factory Id3v2FrameContent.decode(
      Id3Header header, Id3v2FrameHeader frameHeader, List<int> bytes, int startIndex, int size) {
    switch (frameHeader.identifier.frameName) {
      case FrameName.picture:
        return IgnoredFrameContent.decode(header, frameHeader, bytes, startIndex, size);
      case FrameName.comment:
        return CommentFrameContent.decode(header, frameHeader, bytes, startIndex, size);

      case FrameName.album:
      case FrameName.BPM:
      case FrameName.composer:
      case FrameName.contentType:
      case FrameName.copyright:
      case FrameName.encodingTime:
      case FrameName.playlistDelay:
      case FrameName.originalReleaseTime:
      case FrameName.recordingTime:
      case FrameName.releaseTime:
      case FrameName.taggingTime:
      case FrameName.encodedBy:
      case FrameName.lyricist:
      case FrameName.fileType:
      case FrameName.involvedPeople:
      case FrameName.contentGroupDescription:
      case FrameName.title:
      case FrameName.subTitle:
      case FrameName.initialKey:
      case FrameName.language:
      case FrameName.length:
      case FrameName.musicianCredits:
      case FrameName.mediaType:
      case FrameName.mood:
      case FrameName.originalAlbum:
      case FrameName.originalFilename:
      case FrameName.originalLyricist:
      case FrameName.originalPerformer:
      case FrameName.owner:
      case FrameName.artist:
      case FrameName.accompaniment:
      case FrameName.conductor:
      case FrameName.modifiedBy:
      case FrameName.partOfSet:
      case FrameName.producedNotice:
      case FrameName.publisher:
      case FrameName.track:
      case FrameName.radioStation:
      case FrameName.radioStationOwner:
      case FrameName.albumSortOrder:
      case FrameName.performerSortOrder:
      case FrameName.titleSortOrder:
      case FrameName.ISRC:
      case FrameName.encodingSettings:
      case FrameName.setSubtitle:
      case FrameName.additionalInfo:
      case FrameName.date:
      case FrameName.time:
      case FrameName.originalReleaseYear:
      case FrameName.recordingDates:
      case FrameName.size:
      case FrameName.year:
        return TextFrameContent.decode(header, frameHeader, bytes, startIndex, size);
      default:
        return IgnoredFrameContent.decode(header, frameHeader, bytes, startIndex, size);
    }
  }

  Id3v2FrameContent();

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
}
