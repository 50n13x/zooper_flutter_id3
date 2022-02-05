import 'package:zooper_flutter_id3/exceptions/unsupported_version_exception.dart';
import 'package:zooper_flutter_id3/frames/id3_frame.dart';
import 'package:zooper_flutter_id3/frames/id3v2_frame.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';
import 'package:zooper_flutter_id3/headers/id3v2_header.dart';
import 'package:zooper_flutter_id3/tags/id3_tag.dart';

abstract class Id3v2Tag extends Id3Tag {
  factory Id3v2Tag.load(List<int> bytes, int startIndex) {
    var header = Id3v2Header(bytes, 0);

    if (header.majorVersion == 4) {
      return Id3v24Tag(header, bytes, startIndex);
    } else if (header.majorVersion == 3) {
      return Id3v23Tag(header, bytes, startIndex);
    }

    // TODO implement other versions

    throw UnsupportedVersionException(header.version);
  }

  Id3v2Tag(Id3Header header, List<int> bytes, int startIndex) : super(header) {
    load(bytes, 10);
  }

  void load(List<int> bytes, int startIndex) {
    bool hasNextFrame = true;

    var start = startIndex;

    while (hasNextFrame) {
      var frame = Id3v2Frame.decode(header, bytes, start);
      start += frame.frameSize;
    }
  }
}

class Id3v24Tag extends Id3v2Tag {
  Id3v24Tag(
    Id3Header header,
    List<int> bytes,
    int startIndex,
  ) : super(header, bytes, startIndex);

  @override
  bool isFrameSupported(Id3Frame frame) {
    // TODO: implement isFrameSupported
    throw UnimplementedError();
  }

  @override
  List<int> toByteList() {
    // TODO: implement toByteList
    throw UnimplementedError();
  }
}

class Id3v23Tag extends Id3v2Tag {
  Id3v23Tag(
    Id3Header header,
    List<int> bytes,
    int startIndex,
  ) : super(header, bytes, startIndex);

  @override
  bool isFrameSupported(Id3Frame frame) {
    // TODO: implement isFrameSupported
    throw UnimplementedError();
  }

  @override
  List<int> toByteList() {
    // TODO: implement toByteList
    throw UnimplementedError();
  }
}
