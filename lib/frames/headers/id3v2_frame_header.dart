import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:zooper_flutter_id3/exceptions/unsupported_frame_exception.dart';
import 'package:zooper_flutter_id3/exceptions/unsupported_version_exception.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/frames/frame_identifiers.dart';
import 'package:zooper_flutter_id3/frames/headers/frame_header.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';
import 'package:zooper_flutter_id3/headers/id3v2_header.dart';
import 'package:zooper_flutter_id3/helpers/size_calculator.dart';

abstract class Id3v2FrameHeader extends FrameHeader {
  late int _contentSize;

  int get identifierFieldSize;
  int get sizeFieldSize;

  @override
  int get contentSize => _contentSize;

  set contentSize(int size) {
    _contentSize = contentSize;
  }

  factory Id3v2FrameHeader.decode(Id3v2Header header, List<int> bytes, int startIndex) {
    var identifier = decodeFrameIdentifier(header, bytes, startIndex);

    switch (header.majorVersion) {
      case 4:
        return Id3v24FrameHeader(header, bytes, startIndex, identifier);
      case 3:
        return Id3v23FrameHeader(header, bytes, startIndex, identifier);
      case 2:
        return Id3v22FrameHeader(header, bytes, startIndex, identifier);
    }

    throw UnsupportedVersionException(header.version);
  }

  Id3v2FrameHeader._decode(Id3Header header, List<int> bytes, int startIndex, FrameIdentifier identifier)
      : super(header, identifier) {
    decode(bytes, startIndex);
  }

  /// Decodes the Header
  void decode(List<int> bytes, int startIndex);

  /// Encodes the header
  List<int> encode();

  int decodeFrameSize(List<int> bytes, int startIndex);

  List<int> encodeFrameSize(int frameSize);

  @override
  String toString() {
    return '${identifier.frameName.name} | ${identifier.v24Name ?? identifier.v23Name ?? identifier.v22Name}';
  }

  static FrameIdentifier decodeFrameIdentifier(Id3Header id3Header, List<int> bytes, int startIndex) {
    FrameIdentifier? frameIdentifier;
    String identifierId;

    switch (id3Header.majorVersion) {
      case 4:
        identifierId = latin1.decode(bytes.sublist(startIndex, startIndex + 4));
        frameIdentifier = frameIdentifiers.firstWhereOrNull((element) => element.v24Name == identifierId);
        break;
      case 3:
        identifierId = latin1.decode(bytes.sublist(startIndex, startIndex + 4));
        frameIdentifier = frameIdentifiers.firstWhereOrNull((element) => element.v23Name == identifierId);
        break;
      case 2:
        identifierId = latin1.decode(bytes.sublist(startIndex, startIndex + 3));
        frameIdentifier = frameIdentifiers.firstWhereOrNull((element) => element.v22Name == identifierId);
        break;
      default:
        throw UnsupportedVersionException(id3Header.version);
    }

    if (frameIdentifier == null) {
      throw UnsupportedFrameException(identifierId);
    }

    return frameIdentifier;
  }
}

class Id3v24FrameHeader extends Id3v23FrameHeader {
  Id3v24FrameHeader(
    Id3v2Header id3v2Header,
    List<int> bytes,
    int startIndex,
    FrameIdentifier identifier,
  ) : super(id3v2Header, bytes, startIndex, identifier);

  @override
  int decodeFrameSize(List<int> bytes, int startIndex) {
    return SizeCalculator.sizeOfSyncSafe(bytes.sublist(startIndex, startIndex + 4));
  }

  @override
  List<int> encode() {
    return <int>[
      ...utf8.encode(identifier.v24Name!),
      ...encodeFrameSize(contentSize),
      ...flags,
    ];
  }

  @override
  List<int> encodeFrameSize(int frameSize) {
    return SizeCalculator.frameSizeInSynchSafeBytes(frameSize);
  }
}

class Id3v23FrameHeader extends Id3v2FrameHeader {
  Id3v23FrameHeader(
    Id3v2Header id3v2Header,
    List<int> bytes,
    int startIndex,
    FrameIdentifier identifier,
  ) : super._decode(id3v2Header, bytes, startIndex, identifier);

  @override
  int get headerSize => 10;

  @override
  int get identifierFieldSize => 4;

  @override
  int get sizeFieldSize => 4;

  int get flagsFieldSize => 2;

  late List<int> _flags;
  List<int> get flags => _flags;

  @override
  void decode(List<int> bytes, int startIndex) {
    _contentSize = decodeFrameSize(bytes, startIndex + identifierFieldSize);
    _flags = _loadFlags(bytes, startIndex + identifierFieldSize + sizeFieldSize);
  }

  @override
  int decodeFrameSize(List<int> bytes, int startIndex) {
    return SizeCalculator.sizeOf(bytes.sublist(startIndex, startIndex + 4));
  }

  @override
  List<int> encode() {
    return <int>[
      ...utf8.encode(identifier.v23Name!),
      ...encodeFrameSize(contentSize),
      ...flags,
    ];
  }

  @override
  List<int> encodeFrameSize(int frameSize) {
    return SizeCalculator.frameSizeInBytes(frameSize);
  }

  List<int> _loadFlags(List<int> bytes, int startIndex) {
    return bytes.sublist(startIndex, startIndex + flagsFieldSize);
  }
}

class Id3v22FrameHeader extends Id3v2FrameHeader {
  Id3v22FrameHeader(
    Id3v2Header id3v2Header,
    List<int> bytes,
    int startIndex,
    FrameIdentifier identifier,
  ) : super._decode(id3v2Header, bytes, startIndex, identifier);

  @override
  int get headerSize => 6;

  @override
  int get identifierFieldSize => 3;

  @override
  int get sizeFieldSize => 3;

  @override
  void decode(List<int> bytes, int startIndex) {
    _contentSize = decodeFrameSize(bytes, startIndex + identifierFieldSize);
  }

  @override
  int decodeFrameSize(List<int> bytes, int startIndex) {
    return SizeCalculator.sizeOfSyncSafe([
      0,
      ...bytes.sublist(startIndex, startIndex + 2),
    ]);
  }

  @override
  List<int> encode() {
    return <int>[
      ...utf8.encode(identifier.v22Name!),
      ...encodeFrameSize(contentSize),
    ];
  }

  @override
  List<int> encodeFrameSize(int frameSize) {
    return SizeCalculator.frameSizeIn3Bytes(frameSize);
  }
}
