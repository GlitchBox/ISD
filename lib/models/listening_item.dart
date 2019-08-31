class ListeningItem {
  List<String> options;
  int correct;
  String explanation;

  ListeningItem(List<String> items, int correct) {
    this.options = items;
    this.correct = correct;
  }
}
