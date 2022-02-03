import 'dart:convert';

import 'dart:typed_data';

import 'package:zooper_flutter_id3/exceptions/id3_exception.dart';
import 'package:zooper_flutter_id3/exceptions/tag_not_found_exception.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

class Id3v2Header extends Id3Header {
  static const int majorSize = 1;
  static const int minorSize = 1;

  Id3v2Header(Uint8List bytes, int startIndex) {
    if (isValidHeader(bytes, startIndex) == false) {
      throw TagNotFoundException(identifier);
    }

    majorVersion = readMajorVersion(bytes);
    revisionVersion = readRevisionVersion(bytes);
  }

  @override
  String get identifier => 'ID3';

  String get version => '2.$majorVersion.$revisionVersion';

  String readIdentifier(Uint8List bytes) {
    var identifierBytes = _getBytes(bytes, 0, identifier.length);
    var readIdentifier = latin1.decode(identifierBytes);

    if (readIdentifier.toLowerCase() != identifier.toLowerCase()) {
      throw Id3Exception('File does not have an ID3v2 header');
    }

    return identifier;
  }

  int readMajorVersion(Uint8List bytes) {
    return bytes[3];
  }

  int readRevisionVersion(Uint8List bytes) {
    return bytes[4];
  }

  Uint8List _getBytes(Uint8List bytes, int start, int length) {
    return bytes.sublist(start, start + length);
  }

  @override
  String toString() => version;
}
