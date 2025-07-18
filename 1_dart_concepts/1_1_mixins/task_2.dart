extension ParseToLinks on String {
  List<String> extractLinks() {
    final url = RegExp(
      r'((https?|ftp):\/\/[^\s/$.?#].[^\s]*)',
      caseSensitive: false,
    );
    return url.allMatches(this).map((el) => el.group(0)!).toList();
  }
}

void main(List<String> args) {
  String text = "https://www.instagram.com/";
  print(text.extractLinks());
}
