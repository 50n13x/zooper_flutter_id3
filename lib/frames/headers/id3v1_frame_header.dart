import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/frames/headers/frame_header.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

class Id3v1FrameHeader extends FrameHeader {
  Id3v1FrameHeader(Id3Header id3Header, FrameIdentifier identifier) : super(id3Header, identifier);

  @override
  int get contentSize => throw UnimplementedError();
}
