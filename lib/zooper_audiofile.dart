import 'package:zooper_flutter_id3/audio/audio_data.dart';
import 'package:zooper_flutter_id3/tags/id3v1_tag.dart';
import 'package:zooper_flutter_id3/tags/id3v2_tag.dart';

class ZooperAudioFile {
  Id3v1Tag? _id3v1tag;
  Id3v2Tag? _id3v2tag;
  late AudioData _audioData;

  ZooperAudioFile.decode(List<int> bytes) {
    _id3v1tag = _decodeV1Tag(bytes);
    _id3v2tag = _decodeV2Tag(bytes);
    _audioData = _getAudioData(bytes, _id3v1tag, _id3v2tag);
  }

  Id3v1Tag? get id3v1 => _id3v1tag;
  Id3v2Tag? get id3v2 => _id3v2tag;
  AudioData get audioData => _audioData;

  List<int> encode() {
    return <int>[
      ...id3v2?.encode() ?? [],
      ...audioData.audioData,
      ...id3v1?.encode() ?? [],
    ];
  }

  Id3v1Tag? _decodeV1Tag(List<int> bytes) {
    try {
      return Id3v1Tag.decode(bytes);
    } catch (exception) {
      return null;
    }
  }

  Id3v2Tag? _decodeV2Tag(List<int> bytes) {
    try {
      return Id3v2Tag.decode(bytes, 0);
    } catch (exception) {
      return null;
    }
  }

  AudioData _getAudioData(List<int> bytes, Id3v1Tag? v1, Id3v2Tag? v2) {
    var start = v2?.fullSize ?? 0;
    var end = v1 == null ? bytes.length : bytes.length - Id3v1Tag.tagLength;

    return AudioData.sublist(bytes, start, end);
  }
}
