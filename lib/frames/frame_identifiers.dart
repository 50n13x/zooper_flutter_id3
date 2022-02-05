import 'package:zooper_flutter_id3/enums/frame_name.dart';
import 'package:zooper_flutter_id3/frames/frame_identifier.dart';

final List<FrameIdentifier> frameIdentifiers = [
  // A
  FrameIdentifier(FrameName.encryption, 0, 0, 'CRA', 'AENC', 'AENC'),
  FrameIdentifier(FrameName.picture, 0, 0, 'PIC', 'APIC', 'APIC'),
  FrameIdentifier(FrameName.audioSeekPointIndex, 0, 0, null, null, 'ASPI'),

  // C
  FrameIdentifier(FrameName.comment, 30, 30, 'COM', 'COMM', 'COMM'),
  FrameIdentifier(FrameName.commercial, 0, 0, null, 'COMR', 'COMR'),
  FrameIdentifier(FrameName.encryptedMetaFrame, 0, 0, 'CRM', null, null),

  // E
  FrameIdentifier(FrameName.encryptionMethodRegistration, 0, 0, null, 'ENCR', 'ENCR'),
  FrameIdentifier(FrameName.equalization, 0, 0, 'EQU', 'EQUA', null),
  FrameIdentifier(FrameName.equalization2, 0, 0, null, null, 'EQUA2'),
  FrameIdentifier(FrameName.eventTimingCodes, 0, 0, 'ETC', 'ETCO', 'ETCO'),

  // G
  FrameIdentifier(FrameName.GEOB, 0, 0, 'GEO', 'GEOB', 'GEOB'),
  FrameIdentifier(FrameName.GRID, 0, 0, null, 'GRID', 'GRID'),

  // I
  FrameIdentifier(FrameName.people, 0, 0, 'IPL', 'IPLS', null),

  // L
  FrameIdentifier(FrameName.information, 0, 0, 'LNK', 'LINK', 'LINK'),

  // M
  FrameIdentifier(FrameName.MCDI, 0, 0, 'MCI', 'MCDI', 'MCDI'),
  FrameIdentifier(FrameName.MLLT, 0, 0, 'MLL', 'MLLT', 'MLLT'),

  // O
  FrameIdentifier(FrameName.OWNE, 0, 0, null, 'OWNE', 'OWNE'),

  // P
  FrameIdentifier(FrameName.private, 0, 0, null, 'PRIV', 'PRIV'),
  FrameIdentifier(FrameName.playCounter, 0, 0, 'CNT', 'PCNT', 'PCNT'),
  FrameIdentifier(FrameName.popularimeter, 0, 0, 'POP', 'POPM', 'POPM'),
  FrameIdentifier(FrameName.positionSynchronization, 0, 0, null, 'POSS', 'POSS'),

  // R
  FrameIdentifier(FrameName.recommendedBufferSize, 0, 0, 'BUF', 'RBUF', 'RBUF'),
  FrameIdentifier(FrameName.relativeVolumeAdjustment, 0, 0, 'RVA', 'RVAD', null),
  FrameIdentifier(FrameName.relativeVolumeAdjustment2, 0, 0, null, null, 'RVA2'),
  FrameIdentifier(FrameName.reverb, 0, 0, 'REV', 'RVRB', 'RVRB'),
  //

  // S
  FrameIdentifier(FrameName.seek, 0, 0, null, null, 'SEEK'),
  FrameIdentifier(FrameName.signature, 0, 0, null, null, 'SIGN'),
  FrameIdentifier(FrameName.synchronizedLyrics, 0, 0, 'SLT', 'SYLT', 'SYLT'),
  FrameIdentifier(FrameName.synchronizedTempoCodes, 0, 0, 'STC', 'SYTC', 'SYTC'),

  // T
  FrameIdentifier(FrameName.album, 30, 30, 'TAL', 'TALB', 'TALB'),
  FrameIdentifier(FrameName.BPM, 0, 0, 'TBP', 'TBPM', 'TBPM'),
  FrameIdentifier(FrameName.composer, 0, 0, 'TCM', 'TCOM', 'TCOM'),
  FrameIdentifier(FrameName.contentType, 1, 1, 'TCO', 'TCON', 'TCON'),
  FrameIdentifier(FrameName.copyright, 0, 0, 'TCR', 'TCOP', 'TCOP'),
  FrameIdentifier(FrameName.encodingTime, 0, 0, null, null, 'TDEN'),
  FrameIdentifier(FrameName.playlistDelay, 0, 0, 'TDY', 'TDLY', 'TDLY'),
  FrameIdentifier(FrameName.originalReleaseTime, 0, 0, null, null, 'TDOR'),
  FrameIdentifier(FrameName.recordingTime, 0, 0, null, null, 'TDRC'),
  FrameIdentifier(FrameName.releaseTime, 0, 0, null, null, 'TDRL'),
  FrameIdentifier(FrameName.taggingTime, 0, 0, null, null, 'TDTG'),
  FrameIdentifier(FrameName.encodedBy, 0, 0, 'TEN', 'TENC', 'TENC'),
  FrameIdentifier(FrameName.lyricist, 0, 0, 'TXT', 'TEXT', 'TEXT'),
  FrameIdentifier(FrameName.fileType, 0, 0, 'TFT', 'TFLT', 'TFLT'),
  FrameIdentifier(FrameName.involvedPeople, 0, 0, null, null, 'TIPL'),
  FrameIdentifier(FrameName.contentGroupDescription, 0, 0, 'TT1', 'TIT1', 'TIT1'),
  FrameIdentifier(FrameName.title, 30, 30, 'TT2', 'TIT2', 'TIT2'),
  FrameIdentifier(FrameName.subTitle, 0, 0, 'TT3', 'TIT3', 'TIT3'),
  FrameIdentifier(FrameName.initialKey, 0, 0, 'TKE', 'TKEY', 'TKEY'),
  FrameIdentifier(FrameName.language, 0, 0, 'TLA', 'TLAN', 'TLAN'),
  FrameIdentifier(FrameName.length, 0, 0, 'TLE', 'TLEN', 'TLEN'),
  FrameIdentifier(FrameName.musicianCredits, 0, 0, null, null, 'TMCL'),
  FrameIdentifier(FrameName.mediaType, 0, 0, 'TMT', 'TMED', 'TMED'),
  FrameIdentifier(FrameName.mood, 0, 0, null, null, 'TMOO'),
  FrameIdentifier(FrameName.originalAlbum, 0, 0, 'TOT', 'TOAL', 'TOAL'),
  FrameIdentifier(FrameName.originalFilename, 0, 0, 'TOF', 'TOFN', 'TOFN'),
  FrameIdentifier(FrameName.originalLyricist, 0, 0, 'TOL', 'TOLY', 'TOLY'),
  FrameIdentifier(FrameName.originalPerformer, 0, 0, 'TOA', 'TOPE', 'TOPE'),
  FrameIdentifier(FrameName.owner, 0, 0, null, 'TOWN', 'TOWN'),
  FrameIdentifier(FrameName.artist, 30, 30, 'TP1', 'TPE1', 'TPE1'),
  FrameIdentifier(FrameName.accompaniment, 0, 0, 'TP2', 'TPE2', 'TPE2'),
  FrameIdentifier(FrameName.conductor, 0, 0, 'TP3', 'TPE3', 'TPE3'),
  FrameIdentifier(FrameName.modifiedBy, 0, 0, 'TP4', 'TPE4', 'TPE4'),
  FrameIdentifier(FrameName.partOfSet, 0, 0, 'TPA', 'TPOS', 'TPOS'),
  FrameIdentifier(FrameName.producedNotice, 0, 0, null, null, 'TPRO'),
  FrameIdentifier(FrameName.publisher, 0, 0, 'TPB', 'TPUB', 'TPUB'),
  FrameIdentifier(FrameName.track, 0, 0, 'TRK', 'TRCK', 'TRCK'),
  FrameIdentifier(FrameName.radioStation, 0, 0, null, 'TRSN', 'TRSN'),
  FrameIdentifier(FrameName.radioStationOwner, 0, 0, null, 'TRSO', 'TRSO'),
  FrameIdentifier(FrameName.albumSortOrder, 0, 0, null, null, 'TSOA'),
  FrameIdentifier(FrameName.performerSortOrder, 0, 0, null, null, 'TSOP'),
  FrameIdentifier(FrameName.titleSortOrder, 0, 0, null, null, 'TSOT'),
  FrameIdentifier(FrameName.ISRC, 0, 0, 'TRC', 'TSRC', 'TSRC'),
  FrameIdentifier(FrameName.encodingSettings, 0, 0, 'TSS', 'TSSE', 'TSSE'),
  FrameIdentifier(FrameName.setSubtitle, 0, 0, null, null, 'TSST'),
  FrameIdentifier(FrameName.additionalInfo, 0, 0, 'TXX', 'TXXX', 'TXXX'),
  FrameIdentifier(FrameName.date, 0, 0, 'TDA', 'TDAT', null),
  FrameIdentifier(FrameName.time, 0, 0, 'TIM', 'TIME', null),
  FrameIdentifier(FrameName.originalReleaseYear, 0, 0, null, 'TORY', null),
  FrameIdentifier(FrameName.recordingDates, 0, 0, 'TRD', 'TRDA', null),
  FrameIdentifier(FrameName.size, 0, 0, 'TSI', 'TSIZ', null),
  FrameIdentifier(FrameName.year, 4, 4, 'TYE', 'TYER', null),

  // U
  FrameIdentifier(FrameName.ID, 0, 0, 'UFI', 'UFID', 'UFID'),
  FrameIdentifier(FrameName.termsofUse, 0, 0, null, 'USER', 'USER'),
  FrameIdentifier(FrameName.unsyncTranscript, 0, 0, 'ULT', 'USLT', 'USLT'),

  // W
  FrameIdentifier(FrameName.commercialInfo, 0, 0, 'WCM', 'WCOM', 'WCOM'),
  FrameIdentifier(FrameName.copyrightInfo, 0, 0, 'WCP', 'WCOP', 'WCOP'),
  FrameIdentifier(FrameName.oFileWebpage, 0, 0, 'WAF', 'WOAF', 'WOAF'),
  FrameIdentifier(FrameName.oArtistWebpage, 0, 0, 'WAR', 'WOAR', 'WOAR'),
  FrameIdentifier(FrameName.oAudioWebpage, 0, 0, 'WAS', 'WOAS', 'WOAS'),
  FrameIdentifier(FrameName.oRadioWebpage, 0, 0, null, 'WORS', 'WORS'),
  FrameIdentifier(FrameName.payment, 0, 0, null, 'WPAY', 'WPAY'),
  FrameIdentifier(FrameName.oPublisherWebpage, 0, 0, 'WPB', 'WPUB', 'WPUB'),
  FrameIdentifier(FrameName.cLink, 0, 0, 'WXX', 'WXXX', 'WXXX'),
];
