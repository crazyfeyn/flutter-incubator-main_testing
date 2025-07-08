import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'serialization_generator.dart';

Builder serializableBuilder(BuilderOptions options) {
  return PartBuilder(
    [SerializationGenerator()],
    '.g.dart',
  );
}
