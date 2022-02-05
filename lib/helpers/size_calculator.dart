class SizeCalculator {
  // Regular 32bit int
  static int sizeOf(List<int> block) {
    assert(block.length == 4);

    var len = block[0] << 24;
    len += block[1] << 16;
    len += block[2] << 8;
    len += block[3];

    return len;
  }

  // Sync safe 32bit int
  static int sizeOfSyncSafe(List<int> block) {
    assert(block.length == 4);

    var len = block[0] << 21;
    len += block[1] << 14;
    len += block[2] << 7;
    len += block[3];

    return len;
  }
}
