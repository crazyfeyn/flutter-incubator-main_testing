// ignore: depend_on_referenced_packages
import 'package:build/build.dart';
// ignore: depend_on_referenced_packages
import 'package:source_gen/source_gen.dart';
import 'package:task_2/src/serialization_generator.dart';

Builder serializableBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [SerializationGenerator()],
    'serialization',
  );
}
