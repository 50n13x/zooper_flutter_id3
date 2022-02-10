import 'package:zooper_flutter_id3/frames/id3v2_frame.dart';
import 'package:zooper_flutter_id3/tags/contents/id3v2_content.dart';
import 'package:zooper_flutter_id3/tags/id3_tag.dart';

import 'headers/id3v2_header.dart';

class Id3v2Tag extends Id3Tag<Id3v2Header, Id3v2Content, Id3v2Frame> {
  /// Decodes the Id3v2Tag
  factory Id3v2Tag.decode(
    List<int> bytes,
    int startIndex,
  ) {
    var header = Id3v2Header(bytes, startIndex);
    var content = Id3v2Content.decode(header, bytes, startIndex + header.headerSize);

    return Id3v2Tag(header, content);
  }

  Id3v2Tag(Id3v2Header header, Id3v2Content content) : super(header, content);

  /// Returns the full size of the v2 tag
  ///
  /// Because other softwares are setting the wrong tag size or padding
  /// this is needed in order to extract ALL audio data
  int get fullSize => header.headerSize + header.frameSize;

  @override
  List<int> encode() {
    var frameBytes = content.encode();

    header.frameSize = frameBytes.length;
    var headerBytes = header.encode();

    return <int>[
      ...headerBytes,
      ...frameBytes,
    ];
  }
}
