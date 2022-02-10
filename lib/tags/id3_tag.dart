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

  void addFrame(TFrame frame) {
    _content.addFrame(frame);
  }

  TFrame? getFrameByName(FrameName name) {
    return content.frames.firstWhereOrNull((element) => element.frameHeader.identifier.frameName == name) as TFrame;
  }

  List<int> encode();
}
