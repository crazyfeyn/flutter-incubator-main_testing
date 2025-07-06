void main() {
  String text = "https://www.instagram.com/";
  print(text.extractLinks);
}

extension ExtensionParseTextToLinks on String {
  List<String> get extractLinks {
    final url = RegExp(
      r'((https?|ftp):\/\/[^\s/$.?#].[^\s]*)',
      caseSensitive: false,
    );
    return url.allMatches(this).map((match) => match.group(0)!).toList();
  }
}
