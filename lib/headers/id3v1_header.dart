import 'dart:typed_data';

import 'package:zooper_flutter_id3/exceptions/tag_not_found_exception.dart';

import 'id3_header.dart';

class Id3v1Header extends Id3Header {
  @override
  String get identifier => 'TAG';

  Id3v1Header(Uint8List bytes, int startIndex) {
    if (isValidHeader(bytes, startIndex) == false) {
      throw TagNotFoundException(identifier);
    }

    majorVersion = 1;
  }

  String get version => '1.$majorVersion';

  @override
  String toString() => version;
}
