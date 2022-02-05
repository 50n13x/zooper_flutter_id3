import 'dart:convert';

import 'dart:typed_data';

import 'package:zooper_flutter_id3/exceptions/tag_not_found_exception.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';
import 'package:zooper_flutter_id3/helpers/size_calculator.dart';

class Id3v2Header extends Id3Header {
  static const int majorSize = 1;
  static const int minorSize = 1;

  late int _revisionVersion;
  late int _flags;
  late int _size;

  Id3v2Header(List<int> bytes, int startIndex) {
    if (isValidHeader(bytes, startIndex) == false) {
      throw TagNotFoundException(identifier);
    }

    majorVersion = _readMajorVersion(bytes);
    _revisionVersion = _readRevisionVersion(bytes);

    _flags = _readFlags(bytes);

    _size = _calculateSize(bytes);
  }

  @override
  String get identifier => 'ID3';

  @override
  String get version => '2.$majorVersion.$revisionVersion';

  int get revisionVersion => _revisionVersion;

  int get flags => _flags;

  bool get useUnsynchronization => flags & 0x80 != 0;
  bool get hasExtendedHeader => flags & 0x40 != 0;
  bool get isExperimental => flags & 0x20 != 0;

  /// The size of the whole ID3v2 Tag
  int get size => _size;

  String readIdentifier(Uint8List bytes) {
    var identifierBytes = _sublist(bytes, 0, identifier.length);
    var readIdentifier = latin1.decode(identifierBytes);

    if (readIdentifier.toLowerCase() != identifier.toLowerCase()) {
      throw TagNotFoundException(identifier);
    }

    return identifier;
  }

  int _readMajorVersion(List<int> bytes) {
    return bytes[3];
  }

  int _readRevisionVersion(List<int> bytes) {
    return bytes[4];
  }

  int _readFlags(List<int> bytes) {
    return bytes[5];
  }

  int _calculateSize(List<int> bytes) {
    return revisionVersion >= 4
        ? SizeCalculator.sizeOfSyncSafe(bytes.sublist(6, 10))
        : SizeCalculator.sizeOf(bytes.sublist(6, 10));
  }

  List<int> _sublist(List<int> bytes, int start, int length) {
    return bytes.sublist(start, start + length);
  }

  @override
  String toString() => version;
}
