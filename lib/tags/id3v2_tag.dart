import 'package:zooper_flutter_id3/tags/contents/id3_content.dart';
import 'package:zooper_flutter_id3/tags/contents/id3v2_content.dart';
import 'package:zooper_flutter_id3/tags/id3_tag.dart';

import 'headers/id3_header.dart';
import 'headers/id3v2_header.dart';

class Id3v2Tag extends Id3Tag {
  /// Decodes the Id3v2Tag
  factory Id3v2Tag.decode(
    List<int> bytes,
    int startIndex,
  ) {
    var header = Id3v2Header(bytes, startIndex);
    var content = Id3v2Content.decode(header, bytes, startIndex + header.headerSize);

    return Id3v2Tag(header, content);
  }

  Id3v2Tag(Id3Header header, Id3Content content) : super(header, content);

  /// Returns the full size of the v2 tag
  ///
  /// Because other softwares are setting the wrong tag size or padding
  /// this is needed in order to extract ALL audio data
  int get fullSize => header.headerSize + (header as Id3v2Header).frameSize;

  @override
  List<int> encode() {
    var frameBytes = content.encode();

    (header as Id3v2Header).frameSize = frameBytes.length;
    var headerBytes = header.encode();

    return <int>[
      ...headerBytes,
      ...frameBytes,
    ];
  }
}
