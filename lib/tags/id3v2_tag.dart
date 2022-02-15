import 'package:collection/collection.dart';
import 'package:zooper_flutter_id3/frames/contents/text_frame_content.dart';
import 'package:zooper_flutter_id3/frames/frame_identifiers.dart';
import 'package:zooper_flutter_id3/frames/headers/id3v2_frame_header.dart';
import 'package:zooper_flutter_id3/frames/id3v2_frame.dart';
import 'package:zooper_flutter_id3/tags/contents/id3v2_content.dart';
import 'package:zooper_flutter_id3/tags/id3_tag.dart';

import '../enums/frame_name.dart';
import '../frames/models/text_model.dart';
import '../helpers/encoding_helper.dart';
import 'headers/id3v2_header.dart';

class Id3v2Tag extends Id3Tag<Id3v2Header, Id3v2Content, Id3v2Frame> {
  /// Decodes the Id3v2Tag
  static Id3v2Tag? decode(
    List<int> bytes,
    int startIndex,
  ) {
    var header = Id3v2Header.decode(bytes, startIndex);

    // If the header is not ID3v2 Header, just return
    if (header == null) {
      return null;
    }

    var content = Id3v2Content.decode(header, bytes, startIndex + header.headerSize);

    return Id3v2Tag(header, content);
  }

  Id3v2Tag(Id3v2Header header, Id3v2Content content) : super(header, content);

  /// Returns the full size of the v2 tag
  ///
  /// Because other softwares are setting the wrong tag size or padding
  /// this is needed in order to extract ALL audio data
  int get fullSize => header.headerSize + header.frameSize;

  @override
  List<int> encode() {
    // Don't encode if no frame is present
    if (content.frames.isEmpty) {
      return <int>[];
    }

    var frameBytes = content.encode();

    header.frameSize = frameBytes.length;
    var headerBytes = header.encode();

    return <int>[
      ...headerBytes,
      ...frameBytes,
    ];
  }

  /* Helper methods
  / 
  */

  TextModel? getArtistModel() {
    return getFramesByName(FrameName.artist).firstOrNull?.frameContent.model as TextModel?;
  }

  TextModel? getTitleModel() {
    return getFramesByName(FrameName.title).firstOrNull?.frameContent.model as TextModel?;
  }

  TextModel? getAlbumModel() {
    return getFramesByName(FrameName.album).firstOrNull?.frameContent.model as TextModel?;
  }

  TextModel? getGenreModel() {
    return getFramesByName(FrameName.contentType).firstOrNull?.frameContent.model as TextModel?;
  }

  TextModel? getBPMModel() {
    // TODO: Change this to an numeric Frame
    return getFramesByName(FrameName.BPM).firstOrNull?.frameContent.model as TextModel?;
  }

  TextModel? getCommentModel() {
    return getFramesByName(FrameName.comment).firstOrNull?.frameContent.model as TextModel?;
  }

  TextModel? getContentGroupDescriptionModel() {
    var frames = getFramesByName(FrameName.contentGroupDescription);

    return getFramesByName(FrameName.contentGroupDescription).firstOrNull?.frameContent.model as TextModel?;
  }

  void addArtist(String artist, [int encodintType = 3]) {
    var identifier = frameIdentifiers.firstWhere((element) => element.frameName == FrameName.artist);
    var frameHeader = Id3v2FrameHeader.create(header, identifier);

    var contentModel = Id3v2TextModel(getEncoding(encodintType), artist);
    var frameContent = TextFrameContent.create(header, contentModel);

    var frame = Id3v2Frame(header, frameHeader, frameContent);

    addFrame(frame);
  }
}
