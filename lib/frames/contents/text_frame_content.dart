import 'package:zooper_flutter_encoding_utf16/zooper_flutter_encoding_utf16.dart';
import 'package:zooper_flutter_id3/constants/terminations.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/frames/models/text_model.dart';
import 'package:zooper_flutter_id3/tags/headers/id3_header.dart';

import 'id3v2_frame_content.dart';

class TextFrameContent extends Id3v2FrameContent<TextModel> {
  TextFrameContent.decode(
    Id3Header header,
    Id3v2FrameHeader frameHeader,
    List<int> bytes,
    int startIndex,
    int size,
  ) {
    var sublist = bytes.sublist(startIndex, startIndex + size);

    // Get the encoding
    var encoding = getEncoding(sublist[0]);

    var termination = Terminations.getByEncoding(encoding);
    bool hasTermination = Terminations.hasTermination(
      sublist.sublist(1),
      termination,
    );

    var end = hasTermination ? sublist.length - termination.length : sublist.length;

    // Decode the string
    var value = encoding.decode(sublist.sublist(1, end));

    model = TextModel(encoding, value);
  }

  @override
  String toString() {
    return model.value;
  }

  @override
  List<int> encode() {
    var encoded = model.encoding is UTF16
        ? (model.encoding as UTF16).encodeWithBOM(model.value)
        : model.encoding.encode(model.value);

    var bytes = <int>[
      getIdFromEncoding(model.encoding),
      ...encoded,
      ...Terminations.getByEncoding(model.encoding),
    ];

    return bytes;
  }
}
