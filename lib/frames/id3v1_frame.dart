import 'dart:convert';

import 'package:zooper_flutter_id3/exceptions/unsupported_type_exception.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';

import 'id3_frame.dart';

class Id3v1Frame<T> extends Id3Frame {
  late T value;

  Id3v1Frame(FrameIdentifier identifier) : super(identifier);

  @override
  int load(List<int> bytes, int startIndex) {
    var subBytes = _clearZeros(bytes.sublist(startIndex, startIndex + identifier.v11Length));

    switch (T) {
      case int:
        value = subBytes.first as T;
        break;
      default:
        value = latin1.decode(subBytes) as T;
        break;
    }

    return identifier.v11Length;
  }

  @override
  List<int> toByteList() {
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
