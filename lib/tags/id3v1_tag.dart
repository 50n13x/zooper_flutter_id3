import 'package:zooper_flutter_id3/enums/frame_name.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/frames/frame_identifiers.dart';
import 'package:zooper_flutter_id3/frames/id3v1_frame.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';
import 'package:zooper_flutter_id3/headers/id3v1_header.dart';
import 'package:zooper_flutter_id3/tags/id3_tag.dart';

class Id3v1Tag extends Id3Tag<Id3v1Frame> {
  static const int tagLength = 128;

  factory Id3v1Tag.decode(List<int> bytes) {
    var header = Id3v1Header(bytes, bytes.length - tagLength);

    return Id3v1Tag._internal(header, bytes);
  }

  Id3v1Tag._internal(Id3Header header, List<int> bytes) : super(header) {
    load(header, bytes);
  }

  void load(Id3Header header, List<int> bytes) {
    int startIndex = bytes.length - tagLength + header.identifier.length;

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
  bool isFrameSupported(Id3v1Frame frame) {
    return true;
  }

  int _loadFrame<T>(Id3Header header, FrameIdentifier identifier, List<int> bytes, int startIndex) {
    var frame = Id3v1Frame<T>(header, identifier);
    int size = frame.decode(bytes, startIndex);
    addFrame(frame);
    return size;
  }

  @override
  List<int> toByteList() {
    // TODO: implement toByteList
    throw UnimplementedError();
  }
}
