import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

import 'id3v2_frame_content.dart';

class IgnoredFrameContent extends FrameContent {
  IgnoredFrameContent.decode(
    Id3Header header,
    Id3v2FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super() {
    decode(bytes, startIndex, size);
  }

  late List<int> _content;
  List<int> get content => _content;

  @override
  void decode(List<int> bytes, int startIndex, int size) {
    _content = bytes.sublist(startIndex, startIndex + size);
  }
}
