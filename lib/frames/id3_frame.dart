import 'package:flutter/foundation.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

abstract class Id3Frame {
  final Id3Header _header;
  late FrameIdentifier _identifier;

  Id3Frame(
    this._header,
  );

  Id3Frame.fromIdentifier(
    this._header,
    this._identifier,
  );

  Id3Header get header => _header;
  FrameIdentifier get identifier => _identifier;
  @protected
  set identifier(FrameIdentifier value) {
    _identifier = value;
  }

  /// Loads the frame and returns the size of this frame
  ///
  /// [bytes]The bytes
  /// [startIndex]The index where the frame starts
  void decode(List<int> bytes, int startIndex);

  /// Converts the Frame to a [List] of [int]
  List<int> encode();

  @override
  String toString() {
    return identifier.frameName.name;
  }
}
