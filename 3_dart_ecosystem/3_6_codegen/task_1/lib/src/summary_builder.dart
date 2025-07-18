import 'dart:async';

import 'package:build/build.dart';

class SummaryBuilder implements Builder {
  @override
  final buildExtensions = const {
    r'$lib$': ['summary.g']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    const content = '''
Total lines of code: 1000

Lines of code by a file in descending order:
1. `dummy.dart`: 800
2. `test.dart`: 180
3. `main.dart`: 20
''';

    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'lib/summary.g'),
      content,
    );
  }
}
