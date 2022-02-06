import 'package:zooper_flutter_id3/frames/contents/frame_content.dart';
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
    // Decode the header
    var frameHeader = Id3v2FrameHeader.decode(
      header as Id3v2Header,
      bytes,
      startIndex,
    );

    // Decode the content
    var frameContent = Id3v2FrameContent.decode(
      header,
      frameHeader,
      bytes,
      startIndex + frameHeader.headerSize,
      frameHeader.contentSize,
    );

    return Id3v2Frame(header, frameHeader, frameContent);
  }

  Id3v2Frame(
    Id3Header header,
    FrameHeader frameHeader,
    FrameContent frameContent,
  ) : super(header, frameHeader, frameContent);

  /// The total framesize inclusive header
  int get frameSize => 10 + frameHeader.contentSize;

  @override
  List<int> encode() {
    // TODO: implement toByteList
    throw UnimplementedError();
  }
}
