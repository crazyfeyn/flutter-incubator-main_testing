void main() {
  final today = DateTime.now();
  print(today.parseDateToString);
}

extension ExtensionDateFormatting on DateTime {
  String get parseDateToString {
    final year = this.year.toString().padLeft(4, '0');
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$year.$month.$day';
  }
}
