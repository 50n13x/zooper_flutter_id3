import 'package:collection/collection.dart';
import 'package:zooper_flutter_id3/enums/frame_name.dart';
import 'package:zooper_flutter_id3/frames/id3_frame.dart';
import 'package:zooper_flutter_id3/tags/contents/id3_content.dart';

import 'headers/id3_header.dart';

abstract class Id3Tag<THeader extends Id3Header, TContent extends Id3Content, TFrame extends Id3Frame> {
  final THeader _header;
  final TContent _content;

  THeader get header => _header;
  TContent get content => _content;

  Id3Tag(this._header, this._content);

  /// Adds a frame to the list
  void addFrame(TFrame frame) {
    _content.addFrame(frame);
  }

  /// Returns the Frame stored inside, or null
  TFrame? getFrameByNameOrNull(FrameName name) {
    return content.frames.firstWhereOrNull((element) => element.frameHeader.identifier.frameName == name) as TFrame?;
  }

  /// Checks if a frame already exists by it's name
  ///
  /// Note: Because there can be multiple frames with different descriptions
  /// which are not defined as "the same" frame, this will not check if the
  /// frame is one of this frames and has a different description.
  /// So if there is such a frame, this method will always return TRUE
  bool containsFrameWithIdentifier(FrameName name) {
    return content.frames.any((element) => element.frameHeader.identifier.frameName == name);
  }

  /// Encodes the tag
  List<int> encode();
}
