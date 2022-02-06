abstract class FrameContent {
  void decode(
    List<int> bytes,
    int startIndex,
    int size,
  );

  List<int> encode();
}
