import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/frames/models/raw_model.dart';
import 'package:zooper_flutter_id3/tags/headers/id3_header.dart';

import 'id3v2_frame_content.dart';

class IgnoredFrameContent extends Id3v2FrameContent<RawModel> {
  IgnoredFrameContent.decode(
    Id3Header header,
    Id3v2FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super() {
    var content = bytes.sublist(startIndex, startIndex + size);

    model = RawModel(content);
  }

  @override
  List<int> encode() {
    return model.content;
  }
}
