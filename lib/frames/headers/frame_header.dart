import 'package:zooper_flutter_id3/frames/frame_identifier.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

abstract class FrameHeader {
  final Id3Header _id3Header;
  final FrameIdentifier _identifier;

  FrameHeader(
    this._id3Header,
    this._identifier,
  );

  Id3Header get id3Header => _id3Header;
  FrameIdentifier get identifier => _identifier;
  int get headerSize;

  int get contentSize;
}
