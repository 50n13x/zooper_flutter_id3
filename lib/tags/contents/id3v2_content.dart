import 'package:zooper_flutter_id3/exceptions/unsupported_version_exception.dart';
import 'package:zooper_flutter_id3/frames/id3_frame.dart';
import 'package:zooper_flutter_id3/frames/id3v2_frame.dart';
import 'package:zooper_flutter_id3/tags/contents/id3_content.dart';
import 'package:zooper_flutter_id3/tags/headers/id3_header.dart';
import 'package:zooper_flutter_id3/tags/headers/id3v2_header.dart';

abstract class Id3v2Content extends Id3Content<Id3v2Frame> {
  factory Id3v2Content.decode(
    Id3v2Header header,
    List<int> bytes,
    int startIndex,
  ) {
    if (header.majorVersion == 4) {
      return Id3v24Content(header, bytes, startIndex, header.frameSize);
    } else if (header.majorVersion == 3) {
      return Id3v23Content(header, bytes, startIndex, header.frameSize);
    } else if (header.majorVersion == 2) {
      return Id3v22Content(header, bytes, startIndex, header.frameSize);
    }

    throw UnsupportedVersionException(header.version);
  }

  Id3v2Content._decode(Id3v2Header header, List<int> bytes, int startIndex, int size) {
    bool hasNextFrame = true;

    var start = startIndex;

    while (hasNextFrame) {
      var frame = _decodeFrame(header, bytes, start);

      if (frame == null) {
        hasNextFrame = false;
        break;
      }

      frames.add(frame);

      start += frame.frameSize;
      hasNextFrame = start < size;
    }

    // In order to read the audio data, we need to set the header size
    // equally to the index of the first non-padding frame
    //
    // Looks shit, but works
    var indexOfPaddingEnd = _getIndexOfPaddingEnd(bytes, start);
    header.frameSize = indexOfPaddingEnd - header.headerSize;
  }

  @override
  List<int> encode() {
    var list = <int>[];

    for (var frame in frames) {
      var frameBytes = frame.encode();

      list.addAll(frameBytes);
    }

    var padding = List<int>.filled(1024, 0x00);

    return <int>[
      ...list,
      ...padding,
    ];
  }

  Id3v2Frame? _decodeFrame(Id3Header header, List<int> bytes, int start) {
    try {
      return Id3v2Frame.decode(header, bytes, start);
    } catch (exception) {
      return null;
    }
  }

  int _getIndexOfPaddingEnd(List<int> bytes, int start) {
    return bytes.indexWhere((element) => element != 0, start);
  }
}

class Id3v24Content extends Id3v2Content {
  Id3v24Content(
    Id3v2Header header,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super._decode(header, bytes, startIndex, size);

  @override
  bool isFrameSupported(Id3Frame frame) {
    return frame.frameHeader.identifier.v24Name != null;
  }
}

class Id3v23Content extends Id3v2Content {
  Id3v23Content(
    Id3v2Header header,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super._decode(header, bytes, startIndex, size);

  @override
  bool isFrameSupported(Id3Frame frame) {
    return frame.frameHeader.identifier.v23Name != null;
  }
}

class Id3v22Content extends Id3v2Content {
  Id3v22Content(
    Id3v2Header header,
    List<int> bytes,
    int startIndex,
    int size,
  ) : super._decode(header, bytes, startIndex, size);

  @override
  bool isFrameSupported(Id3Frame frame) {
    return frame.frameHeader.identifier.v22Name != null;
  }
}
