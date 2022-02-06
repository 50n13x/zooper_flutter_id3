import 'dart:convert';

import 'dart:typed_data';

import 'package:zooper_flutter_id3/exceptions/tag_not_found_exception.dart';
import 'package:zooper_flutter_id3/exceptions/unsupported_version_exception.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';
import 'package:zooper_flutter_id3/helpers/size_calculator.dart';

class Id3v2Header extends Id3Header {
  late int _revisionVersion;
  late int _flags;

  @override
  int get headerSize => 10;

  @override
  String get identifier => 'ID3';

  @override
  String get version => '2.$majorVersion.$revisionVersion';

  int get revisionVersion => _revisionVersion;

  int get flags => _flags;

  bool get useUnsynchronization => flags & 0x80 != 0;
  bool get hasExtendedHeader => flags & 0x40 != 0;
  bool get isExperimental => flags & 0x20 != 0;

  /// The size of all frames inclusive padding
  late int frameSize;

  Id3v2Header(List<int> bytes, int startIndex) {
    if (isValidHeader(bytes, startIndex) == false) {
      throw TagNotFoundException(identifier);
    }

    majorVersion = _decodeMajorVersion(bytes);
    _revisionVersion = _decodeRevisionVersion(bytes);
    _flags = _decodeFlags(bytes);
    frameSize = _decodeSize(bytes);
  }

  String readIdentifier(Uint8List bytes) {
    var identifierBytes = _sublist(bytes, 0, identifier.length);
    var readIdentifier = latin1.decode(identifierBytes);

    if (readIdentifier.toLowerCase() != identifier.toLowerCase()) {
      throw TagNotFoundException(identifier);
    }

    return identifier;
  }

  int _decodeMajorVersion(List<int> bytes) {
    return bytes[3];
  }

  int _decodeRevisionVersion(List<int> bytes) {
    return bytes[4];
  }

  int _decodeFlags(List<int> bytes) {
    return bytes[5];
  }

  int _decodeSize(List<int> bytes) {
    return SizeCalculator.sizeOfSyncSafe(bytes.sublist(6, 10));
  }

  List<int> _sublist(List<int> bytes, int start, int length) {
    return bytes.sublist(start, start + length);
  }

  @override
  String toString() => version;

  @override
  List<int> encode() {
    return <int>[
      ...latin1.encode(identifier),
      _encodeMajorVersion(majorVersion),
      ..._encodeRevisionVersion(revisionVersion),
      ..._encodeFlags(flags),
      ..._encodeSize(frameSize),
    ];
  }

  int _encodeMajorVersion(int majorVersion) {
    switch (majorVersion) {
      case 4:
        return 0x04;
      case 3:
        return 0x03;
      case 2:
        return 0x02;
      default:
        throw UnsupportedVersionException(version);
    }
  }

  List<int> _encodeRevisionVersion(int revisionVersion) {
    var list = Uint8List(4)..buffer.asInt32List()[0] = revisionVersion;

    return <int>[
      list.last,
    ];
  }

  List<int> _encodeFlags(int flags) {
    var list = Uint8List(4)..buffer.asInt32List()[0] = flags;

    return <int>[
      list.last,
    ];
  }

  List<int> _encodeSize(int size) {
    return SizeCalculator.frameSizeInSynchSafeBytes(size);
  }
}
