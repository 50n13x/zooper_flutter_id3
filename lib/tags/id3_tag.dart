import 'package:zooper_flutter_id3/frames/id3_frame.dart';
import 'package:zooper_flutter_id3/tags/contents/id3_content.dart';

import 'headers/id3_header.dart';

abstract class Id3Tag<T extends Id3Frame> {
  final Id3Header _header;
  final Id3Content _content;

  Id3Header get header => _header;
  Id3Content get content => _content;

  Id3Tag(this._header, this._content);

  void addFrame(T frame) {
    _content.addFrame(frame);
  }

  List<int> encode();
}
