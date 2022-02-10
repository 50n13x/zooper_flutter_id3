import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zooper_flutter_id3/exceptions/tag_not_found_exception.dart';

import 'id3_header.dart';

class Id3v1Header extends Id3Header with EquatableMixin {
  @override
  String get identifier => 'TAG';

  @override
  String get version => '1.$majorVersion';

  @override
  int get headerSize => 3;

  Id3v1Header(List<int> bytes, int startIndex) {
    if (isValidHeader(bytes, startIndex) == false) {
      throw TagNotFoundException(identifier);
    }

    majorVersion = 1;
  }

  @override
  String toString() => version;

  @override
  List<int> encode() {
    return <int>[
      ...latin1.encode(identifier),
    ];
  }

  @override
  List<Object?> get props => [majorVersion];
}
