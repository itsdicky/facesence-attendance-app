extension PowerString on String {

  String smallSentence() {
    if (this.length > 30) {
      return this.substring(0, 30) + '...';
    } else {
      return this;
    }
  }

  String firstWords() {
    int startIndex = 0;
    late int indexOfSpace;

    for (int i = 0; i < 1; i++) {
      indexOfSpace = indexOf(' ', startIndex);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return this;
      }
      startIndex = indexOfSpace + 1;
    }

    return substring(0, indexOfSpace);
  }
}