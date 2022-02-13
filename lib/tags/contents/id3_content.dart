import 'package:zooper_flutter_id3/exceptions/frame_present_exception.dart';
import 'package:zooper_flutter_id3/exceptions/unsupported_frame_exception.dart';
import 'package:zooper_flutter_id3/frames/id3_frame.dart';

abstract class Id3Content<T extends Id3Frame> {
  final List<T> _frames = [];

  /// Gets all frames
  List<T> get frames => _frames;

  /// Adds a frame if it fits all conditions
  ///
  /// Throws a [UnsupportedFrameException] if the frame is not supported by this ID3 version
  /// Throws a [FramePresentException] if the frame already exists
  void addFrame(T frame) {
    if (isFrameSupported(frame) == false) {
      throw UnsupportedFrameException(frame.frameHeader.identifier.frameName.name);
    }

    if (frameExists(frame)) {
      throw FramePresentException(frame.frameHeader.identifier.frameName.name);
    }

    frames.add(frame);
  }

  /// Checks if a frame already exists
  bool frameExists(T frame) {
    return frames.any((element) => element == frame);
  }

  /// Checks if the frame is supported by this ID3 version
  bool isFrameSupported(T frame);

  /// Encodes the content with all frames
  List<int> encode();
}
