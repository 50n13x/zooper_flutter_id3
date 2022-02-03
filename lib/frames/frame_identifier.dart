import 'package:zooper_flutter_id3/enums/frame_name.dart';

class FrameIdentifier {
  final FrameName _frameName;

  final int _v10Length;
  final int _v11Length;

  final String? _v22Name;
  final String? _v23Name;
  final String? _v24Name;

  FrameIdentifier(
    this._frameName,
    this._v10Length,
    this._v11Length,
    this._v22Name,
    this._v23Name,
    this._v24Name,
  );

  FrameName get frameName => _frameName;

  int get v10Length => _v10Length;
  int get v11Length => _v11Length;

  String? get v22Name => _v22Name;
  String? get v23Name => _v23Name;
  String? get v24Name => _v24Name;

  @override
  String toString() => _frameName.name;
}
