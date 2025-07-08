import 'package:build/build.dart';
import 'package:task_1/builder.dart';

void main() {
  final builder = summaryBuilder(BuilderOptions({}));

  print('Builder extensions: ${builder.buildExtensions}');
}
