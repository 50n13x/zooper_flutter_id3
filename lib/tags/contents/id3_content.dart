import 'package:zooper_flutter_id3/exceptions/frame_present_exception.dart';
import 'package:zooper_flutter_id3/exceptions/unsupported_frame_exception.dart';
import 'package:zooper_flutter_id3/frames/id3_frame.dart';

abstract class Id3Content<T extends Id3Frame> {
  final List<T> _frames = [];

  List<T> get frames => _frames;

  void addFrame(T frame) {
    if (isFrameSupported(frame) == false) {
      throw UnsupportedFrameException(frame.frameHeader.identifier.frameName.name);
    }

    if (frameExists(frame)) {
      throw FramePresentException(frame.frameHeader.identifier.frameName.name);
    }

    frames.add(frame);
  }

// TODO: Implement operator for equality
  bool frameExists(T frame) {
    return frames
        .any((element) => element.frameHeader.identifier.frameName.name == frame.frameHeader.identifier.frameName.name);
  }

  bool isFrameSupported(T frame);

  List<int> encode();
}
