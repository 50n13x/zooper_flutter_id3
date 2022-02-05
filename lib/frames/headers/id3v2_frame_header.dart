import 'dart:convert';
import 'package:zooper_flutter_id3/exceptions/id3_exception.dart';
import 'package:zooper_flutter_id3/exceptions/unsupported_frame_exception.dart';
import 'package:zooper_flutter_id3/exceptions/unsupported_version_exception.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/frames/frame_identifiers.dart';
import 'package:zooper_flutter_id3/headers/id3v2_header.dart';
import 'package:zooper_flutter_id3/helpers/size_calculator.dart';

abstract class Id3v2FrameHeader {
  final Id3v2Header _id3v2Header;
  late FrameIdentifier _frameIdentifier;
  late int _contentSize;

  factory Id3v2FrameHeader.load(Id3v2Header header, List<int> bytes, int startIndex) {
    switch (header.majorVersion) {
      case 4:
        return Id3v24FrameHeader(header, bytes, startIndex);
      case 3:
        return Id3v23FrameHeader(header, bytes, startIndex);
      case 2:
        return Id3v22FrameHeader(header, bytes, startIndex);
    }

    throw UnsupportedVersionException(header.version);
  }

  Id3v2FrameHeader(this._id3v2Header, List<int> bytes, int startIndex) {
    load(bytes, startIndex);
  }

  int get headerSize;
  int get identifierFieldSize;
  int get sizeFieldSize;
  int get contentSize => _contentSize;
  Id3v2Header get id3v2Header => _id3v2Header;
  FrameIdentifier get frameIdentifier => _frameIdentifier;

  void load(List<int> bytes, int startIndex);

  void loadFrameIdentifier(List<int> bytes, int startIndex) {
    var identifierId = latin1.decode(bytes.sublist(startIndex, startIndex + identifierFieldSize));

    switch (id3v2Header.majorVersion) {
      case 4:
        _frameIdentifier = frameIdentifiers.firstWhere((element) => element.v24Name == identifierId);
        break;
      case 3:
        _frameIdentifier = frameIdentifiers.firstWhere((element) => element.v23Name == identifierId);
        break;
      case 2:
        _frameIdentifier = frameIdentifiers.firstWhere((element) => element.v22Name == identifierId);
        break;
      default:
        throw UnsupportedFrameException(identifierId);
    }
  }

  void loadFrameSize(List<int> bytes, int startIndex) {
    final size = id3v2Header.majorVersion == 4
        ? SizeCalculator.sizeOfSyncSafe(bytes.sublist(startIndex, startIndex + 4))
        : id3v2Header.majorVersion == 3
            ? SizeCalculator.sizeOf(bytes.sublist(startIndex, startIndex + 4))
            : id3v2Header.majorVersion == 2
                ? SizeCalculator.sizeOfSyncSafe([0, bytes[startIndex], bytes[startIndex + 1], bytes[startIndex + 2]])
                : throw UnsupportedVersionException(id3v2Header.majorVersion.toString());
    if (size <= 0) {
      throw Id3Exception('The calculated size is invalid');
    }

    _contentSize = size;
  }
}

class Id3v24FrameHeader extends Id3v23FrameHeader {
  Id3v24FrameHeader(Id3v2Header id3v2Header, List<int> bytes, int startIndex) : super(id3v2Header, bytes, startIndex);
}

class Id3v23FrameHeader extends Id3v2FrameHeader {
  Id3v23FrameHeader(
    Id3v2Header id3v2Header,
    List<int> bytes,
    int startIndex,
  ) : super(id3v2Header, bytes, startIndex);

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
  void load(List<int> bytes, int startIndex) {
    loadFrameIdentifier(bytes, startIndex);
    loadFrameSize(bytes, startIndex + identifierFieldSize);
    _loadFlags(bytes, startIndex + identifierFieldSize + sizeFieldSize);
  }

  void _loadFlags(List<int> bytes, int startIndex) {
    _flags = bytes.sublist(startIndex, startIndex + flagsFieldSize);
  }
}

class Id3v22FrameHeader extends Id3v2FrameHeader {
  Id3v22FrameHeader(
    Id3v2Header id3v2Header,
    List<int> bytes,
    int startIndex,
  ) : super(id3v2Header, bytes, startIndex);

  @override
  int get headerSize => 6;

  @override
  int get identifierFieldSize => 3;

  @override
  int get sizeFieldSize => 3;

  @override
  void load(List<int> bytes, int startIndex) {
    loadFrameIdentifier(bytes, startIndex);
    loadFrameSize(bytes, startIndex + identifierFieldSize);
  }
}
