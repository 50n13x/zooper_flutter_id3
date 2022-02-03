import 'package:zooper_flutter_id3/frames/frame_identifier.dart';

abstract class Id3Frame {
  final FrameIdentifier _identifier;

  Id3Frame(
    this._identifier,
  );

  FrameIdentifier get identifier => _identifier;

  /// Loads the frame and returns the size of this frame
  ///
  /// [bytes]The bytes
  /// [startIndex]The index where the frame starts
  int load(List<int> bytes, int startIndex);

  /// Converts the Frame to a [List] of [int]
  List<int> toByteList();
}
