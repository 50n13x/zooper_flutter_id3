import 'package:zooper_flutter_id3/headers/id3_header.dart';

import 'headers/frame_header.dart';

abstract class Id3Frame {
  final Id3Header _header;
  final FrameHeader _frameHeader;

  Id3Frame(
    this._header,
    this._frameHeader,
  );

  Id3Header get header => _header;
  FrameHeader get frameHeader => _frameHeader;

  /// Converts the Frame to a [List] of [int]
  List<int> encode();

  @override
  String toString() {
    return _frameHeader.identifier.frameName.name;
  }
}
