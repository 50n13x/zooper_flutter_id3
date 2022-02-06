import 'package:zooper_flutter_id3/frames/contents/frame_content.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

import 'headers/frame_header.dart';

abstract class Id3Frame {
  final Id3Header _header;
  final FrameHeader _frameHeader;
  final FrameContent _frameContent;

  Id3Header get header => _header;
  FrameHeader get frameHeader => _frameHeader;
  FrameContent get frameContent => _frameContent;

  /// The total framesize inclusive header
  int get frameSize => frameHeader.headerSize + frameHeader.contentSize;

  Id3Frame(
    this._header,
    this._frameHeader,
    this._frameContent,
  );

  /// Converts the Frame to a [List] of [int]
  List<int> encode();

  @override
  String toString() {
    return _frameHeader.identifier.frameName.name;
  }
}
