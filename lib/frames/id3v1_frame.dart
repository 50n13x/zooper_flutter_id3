import 'dart:convert';

import 'package:zooper_flutter_id3/exceptions/unsupported_type_exception.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v1_frame_header.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

import 'headers/frame_header.dart';
import 'id3_frame.dart';

class Id3v1Frame<T> extends Id3Frame {
  late T value;

  factory Id3v1Frame.decode(Id3Header header, List<int> bytes, int startIndex, FrameIdentifier identifier) {
    var frameHeader = Id3v1FrameHeader(header, identifier);

    return Id3v1Frame._decode(header, frameHeader, bytes, startIndex);
  }

  Id3v1Frame._decode(Id3Header header, FrameHeader frameHeader, List<int> bytes, int startIndex)
      : super(header, frameHeader) {
    _decodeContent(bytes, startIndex);
  }

  FrameHeader loadFrameHeader(Id3Header header, FrameIdentifier identifier) {
    return Id3v1FrameHeader(header, identifier);
  }

  int _decodeContent(List<int> bytes, int startIndex) {
    var subBytes = _clearZeros(bytes.sublist(startIndex, startIndex + frameHeader.identifier.v11Length));

    switch (T) {
      case int:
        value = subBytes.first as T;
        break;
      default:
        value = latin1.decode(subBytes) as T;
        break;
    }

    return frameHeader.identifier.v11Length;
  }

  @override
  List<int> encode() {
    if (T is String) {
      return _filledArray(value as String);
    }

    if (T is int) {
      return [value as int];
    }

    throw UnsupportedTypeException(T);
  }

  /// Removes the NULL characters
  ///
  /// [list]Contains the bytes with potential zeros
  List<int> _clearZeros(List<int> list) {
    return list.where((i) => i != 0).toList();
  }

  /// Converts the input to a byte List of a specific size
  ///
  /// [inputString]The string to convert
  /// [size]The size of the outputted List
  List<int> _filledArray(String inputString, [int size = 30]) {
    final s = inputString.length > size ? inputString.substring(0, size) : inputString;
    return latin1.encode(s).toList()..addAll(List.filled(size - s.length, 0));
  }
}
