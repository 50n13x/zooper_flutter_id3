import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

abstract class Id3Header {
  static const int identifierSize = 3;
  static const int majorSize = 1;
  static const int minorSize = 1;

  late int _majorVersion;
  late int _revisionVersion;

  String get identifier;
  int get majorVersion => _majorVersion;
  int get revisionVersion => _revisionVersion;

  @protected
  set majorVersion(int value) {
    _majorVersion = value;
  }

  @protected
  set revisionVersion(int value) {
    _revisionVersion = value;
  }

  bool isValidHeader(Uint8List bytes, int startIndex) {
    var identifierBytes = bytes.sublist(startIndex, startIndex + identifierSize);
    var parsedIdentifier = latin1.decode(identifierBytes);

    return parsedIdentifier == identifier;
  }
}
