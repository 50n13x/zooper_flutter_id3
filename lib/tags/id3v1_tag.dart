import 'dart:typed_data';

import 'package:zooper_flutter_id3/enums/frame_name.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/frames/frame_identifiers.dart';
import 'package:zooper_flutter_id3/frames/id3v1_frame.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';
import 'package:zooper_flutter_id3/headers/id3v1_header.dart';
import 'package:zooper_flutter_id3/tags/id3_tag.dart';

class Id3v1Tag extends Id3Tag<Id3v1Frame> {
  factory Id3v1Tag.load(Uint8List bytes) {
    var header = Id3v1Header(bytes, bytes.length - 128);

    return Id3v1Tag._internal(header, bytes);
  }

  Id3v1Tag._internal(Id3Header header, Uint8List bytes) : super(header) {
    load(bytes);
  }

  void load(Uint8List bytes) {
    int startIndex = bytes.length - 128 + header.identifier.length;

    // Title
    startIndex += _loadFrame(
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.title),
      bytes,
      startIndex,
    );

    // Artist
    startIndex += _loadFrame<String>(
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.artist),
      bytes,
      startIndex,
    );

    // Album
    startIndex += _loadFrame<String>(
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.album),
      bytes,
      startIndex,
    );

    // Year
    startIndex += _loadFrame<String>(
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.year),
      bytes,
      startIndex,
    );

    // Comment
    startIndex += _loadFrame<String>(
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.comment),
      bytes,
      startIndex,
    );

    // Genre
    startIndex += _loadFrame<int>(
      frameIdentifiers.firstWhere((element) => element.frameName == FrameName.genre),
      bytes,
      startIndex,
    );
  }

  @override
  bool isFrameSupported(Id3v1Frame frame) {
    return true;
  }

  int _loadFrame<T>(FrameIdentifier identifier, List<int> bytes, int startIndex) {
    var frame = Id3v1Frame<T>(identifier);
    int size = frame.load(bytes, startIndex);
    addFrame(frame);
    return size;
  }

  @override
  List<int> toByteList() {
    // TODO: implement toByteList
    throw UnimplementedError();
  }
}
