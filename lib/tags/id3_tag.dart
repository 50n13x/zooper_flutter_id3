import 'package:zooper_flutter_id3/exceptions/frame_present_exception.dart';
import 'package:zooper_flutter_id3/exceptions/unsupported_frame_exception.dart';
import 'package:zooper_flutter_id3/frames/id3_frame.dart';
import 'package:collection/collection.dart';
import 'package:zooper_flutter_id3/headers/id3_header.dart';

abstract class Id3Tag<T extends Id3Frame> {
  final Id3Header _header;

  Id3Tag(this._header);

  final List<T> frames = [];
  Id3Header get header => _header;

  void addFrame(T frame) {
    if (isFrameSupported(frame) == false) {
      throw UnsupportedFrameException(frame.identifier.frameName.name);
    }

    if (frameExists(frame)) {
      throw FramePresentException(frame.identifier.frameName.name);
    }

    frames.add(frame);
  }

  bool frameExists(T frame) {
    return frames.any((element) => element.identifier.frameName.name == frame.identifier.frameName.name);
  }

  T? getFrameByIdentifier(String identifier) =>
      frames.firstWhereOrNull((element) => element.identifier.frameName.name == identifier);

  bool isFrameSupported(T frame);

  List<int> toByteList();
}
