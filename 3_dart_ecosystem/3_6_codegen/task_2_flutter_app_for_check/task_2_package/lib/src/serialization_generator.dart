import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:task_2/task_2.dart';

class SerializationGenerator extends GeneratorForAnnotation<Serializable> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    // Only handle classes
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Only classes can be annotated with @Serializable',
        element: element,
      );
    }

    final className = element.name;
    final constructor = _getDefaultConstructor(element);
    final fields = _getSerializableFields(element);

    return '''
// **************************************************************************
// SerializationGenerator
// **************************************************************************

part of '${_getPartFileName(buildStep.inputId.path)}';

$className _\$${className}FromJson(Map<String, dynamic> json) => $className(
${_generateConstructorParams(constructor, fields)}
);

Map<String, dynamic> _\$${className}ToJson($className instance) => {
${_generateToJsonFields(fields)}
};
''';
  }

  ConstructorElement _getDefaultConstructor(ClassElement classElement) {
    return classElement.constructors.firstWhere(
      (c) => c.name.isEmpty,
      orElse: () => throw InvalidGenerationSourceError(
        'Default constructor is required for serialization',
        element: classElement,
      ),
    );
  }

  List<FieldElement> _getSerializableFields(ClassElement classElement) {
    return classElement.fields.where((field) {
      return !field.isStatic && field.isFinal;
    }).toList();
  }

  String _generateConstructorParams(
    ConstructorElement constructor,
    List<FieldElement> fields,
  ) {
    return constructor.parameters.map((param) {
      final paramName = param.name;
      final paramType = param.type.toString();
      final field = fields.firstWhere((f) => f.name == paramName);

      if (paramType == 'DateTime') {
        return '''      $paramName: json['$paramName'] == null
          ? null
          : DateTime.parse(json['$paramName'] as String)''';
      } else {
        return '''      $paramName: json['$paramName'] as $paramType''';
      }
    }).join(',\n');
  }

  String _generateToJsonFields(List<FieldElement> fields) {
    return fields.map((field) {
      final fieldName = field.name;
      final fieldType = field.type.toString();

      if (fieldType == 'DateTime') {
        return '''    '$fieldName': instance.$fieldName?.toIso8601String()''';
      } else {
        return '''    '$fieldName': instance.$fieldName''';
      }
    }).join(',\n');
  }

  String _getPartFileName(String path) {
    final parts = path.split('/');
    return parts.last;
  }
}
