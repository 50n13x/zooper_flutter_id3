import 'package:zooper_flutter_id3/frames/contents/id3v2_frame_content.dart';
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
    var frame = Id3v2Frame._internal(header);
    frame.decode(bytes, startIndex);

    return frame;
  }

  Id3v2Frame._internal(Id3Header header) : super(header);

  late Id3v2FrameHeader _id3v2frameHeader;
  Id3v2FrameHeader get id3v2FrameHeader => _id3v2frameHeader;

  late FrameContent _content;
  FrameContent get content => _content;

  /// The total framesize inclusive header
  int get frameSize => 10 + _id3v2frameHeader.contentSize;

  @override
  void decode(List<int> bytes, int startIndex) {
    _id3v2frameHeader = _loadFrameHeader(bytes, startIndex);
    // TODO: abstract this into super class
    identifier = _id3v2frameHeader.frameIdentifier;

    _content = _loadFrameContent(
      header,
      id3v2FrameHeader,
      bytes,
      startIndex + _id3v2frameHeader.headerSize,
      id3v2FrameHeader.contentSize,
    );
  }

  @override
  List<int> encode() {
    // TODO: implement toByteList
    throw UnimplementedError();
  }

  Id3v2FrameHeader _loadFrameHeader(List<int> bytes, int startIndex) {
    return Id3v2FrameHeader.load(header as Id3v2Header, bytes, startIndex);
  }

  FrameContent _loadFrameContent(
      Id3Header header, Id3v2FrameHeader frameHeader, List<int> bytes, int startIndex, int size) {
    return FrameContent.decode(header, frameHeader, bytes, startIndex, size);
  }
}
