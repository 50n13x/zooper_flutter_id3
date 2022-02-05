import 'dart:convert';

import 'package:flutter/foundation.dart';

abstract class Id3Header {
  static const int identifierSize = 3;
  static const int majorSize = 1;
  static const int minorSize = 1;

  late int _majorVersion;

  String get identifier;
  int get majorVersion => _majorVersion;

  String get version;

  @protected
  set majorVersion(int value) {
    _majorVersion = value;
  }

  bool isValidHeader(List<int> bytes, int startIndex) {
    var identifierBytes = bytes.sublist(startIndex, startIndex + identifierSize);
    var parsedIdentifier = latin1.decode(identifierBytes);

    return parsedIdentifier == identifier;
  }
}
