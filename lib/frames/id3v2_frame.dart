import 'package:zooper_flutter_id3/frames/contents/id3v2_frame_content.dart';
import 'package:zooper_flutter_id3/frames/headers/frame_header.dart';
import 'package:zooper_flutter_id3/frames/id3_frame.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';
import 'package:zooper_flutter_id3/headers/id3v2_header.dart';

class Id3v2Frame extends Id3Frame {
  factory Id3v2Frame.decode(
    Id3Header header,
    List<int> bytes,
    int startIndex,
  ) {
    var frameHeader = Id3v2FrameHeader.decode(header as Id3v2Header, bytes, startIndex);

    return Id3v2Frame._decode(header, frameHeader, bytes, startIndex);
  }

  Id3v2Frame._decode(
    Id3Header header,
    FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
  ) : super(header, frameHeader) {
    _content = _decodeFrameContent(
      header,
      frameHeader as Id3v2FrameHeader,
      bytes,
      startIndex + frameHeader.headerSize,
      frameHeader.contentSize,
    );
  }

  late FrameContent _content;
  FrameContent get content => _content;

  /// The total framesize inclusive header
  int get frameSize => 10 + frameHeader.contentSize;

  @override
  List<int> encode() {
    // TODO: implement toByteList
    throw UnimplementedError();
  }

  FrameContent _decodeFrameContent(
      Id3Header header, Id3v2FrameHeader frameHeader, List<int> bytes, int startIndex, int size) {
    return FrameContent.decode(header, frameHeader, bytes, startIndex, size);
  }
}
