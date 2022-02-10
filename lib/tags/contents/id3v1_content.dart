import 'package:zooper_flutter_id3/enums/frame_name.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/frames/frame_identifiers.dart';
import 'package:zooper_flutter_id3/frames/id3v1_frame.dart';
import 'package:zooper_flutter_id3/tags/contents/id3_content.dart';
import 'package:zooper_flutter_id3/tags/headers/id3_header.dart';

class Id3v1Content extends Id3Content<Id3v1Frame> {
  Id3v1Content.decode(Id3Header header, List<int> bytes, int startIndex) {
    // Title
    startIndex += _loadFrame(
      header,
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.title),
      bytes,
      startIndex,
    );

    // Artist
    startIndex += _loadFrame<String>(
      header,
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.artist),
      bytes,
      startIndex,
    );

    // Album
    startIndex += _loadFrame<String>(
      header,
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.album),
      bytes,
      startIndex,
    );

    // Year
    startIndex += _loadFrame<String>(
      header,
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.year),
      bytes,
      startIndex,
    );

    // Comment
    startIndex += _loadFrame<String>(
      header,
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.comment),
      bytes,
      startIndex,
    );

    // Genre
    startIndex += _loadFrame<int>(
      header,
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.contentType),
      bytes,
      startIndex,
    );
  }

  @override
  List<int> encode() {
    return <int>[
      ..._encodeByFrameName(FrameName.title),
      ..._encodeByFrameName(FrameName.artist),
      ..._encodeByFrameName(FrameName.album),
      ..._encodeByFrameName(FrameName.year),
      ..._encodeByFrameName(FrameName.comment),
      ..._encodeByFrameName(FrameName.contentType),
    ];
  }

  @override
  bool isFrameSupported(Id3v1Frame frame) {
    return frame.frameHeader.identifier.frameName == FrameName.title ||
        frame.frameHeader.identifier.frameName == FrameName.artist ||
        frame.frameHeader.identifier.frameName == FrameName.album ||
        frame.frameHeader.identifier.frameName == FrameName.year ||
        frame.frameHeader.identifier.frameName == FrameName.comment ||
        frame.frameHeader.identifier.frameName == FrameName.contentType;
  }

  int _loadFrame<T>(Id3Header header, FrameIdentifier identifier, List<int> bytes, int startIndex) {
    var frame = Id3v1Frame<T>.decode(header, bytes, startIndex, identifier);
    addFrame(frame);
    return identifier.v11Length;
  }

  List<int> _encodeByFrameName(FrameName frameName) {
    var frame = frames.firstWhere((element) => element.frameHeader.identifier.frameName == frameName);
    return frame.encode();
  }
}
