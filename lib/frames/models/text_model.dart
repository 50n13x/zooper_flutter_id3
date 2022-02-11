import 'dart:convert';

import 'package:zooper_flutter_id3/frames/models/frame_content_model.dart';

class TextModel extends FrameContentModel {
  late String value;
  late Encoding encoding;

  TextModel(this.encoding, this.value);
}
