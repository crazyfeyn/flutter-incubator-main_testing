import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:task_2/task_2.dart';

//? I used AI to generate this file's code, but I couldn't do it completely because of demanding its hard core knowldege.

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

    final fromJson = _generateFromJson(className, element);

    final toJson = _generateToJson(className, element);

    return '''
// **************************************************************************
// SerializationGenerator
// **************************************************************************

part of '${_getPartFileName(buildStep.inputId.path)}';

$fromJson

$toJson
''';
  }

  String _generateFromJson(String className, ClassElement classElement) {
    final constructor = classElement.constructors.firstWhere(
      (c) => c.name.isEmpty,
      orElse: () => throw InvalidGenerationSourceError(
        'Default constructor is required',
        element: classElement,
      ),
    );

    final parameters = constructor.parameters.map((param) {
      final paramName = param.name;
      final paramType = param.type.toString();

      if (paramType == 'DateTime') {
        return '''
      $paramName: json['$paramName'] == null
          ? null
          : DateTime.parse(json['$paramName'] as String)''';
      } else {
        return "      $paramName: json['$paramName'] as $paramType";
      }
    }).join(',\n');

    return '''
${className}_\$${className}FromJson(Map<String, dynamic> json) => $className(
$parameters,
    );
''';
  }

  String _generateToJson(String className, ClassElement classElement) {
    final fields = classElement.fields.where((f) => !f.isStatic).map((field) {
      final fieldName = field.name;
      final fieldType = field.type.toString();

      if (fieldType == 'DateTime') {
        return "    '$fieldName': instance.$fieldName?.toString()";
      } else {
        return "    '$fieldName': instance.$fieldName";
      }
    }).join(',\n');

    return '''
Map<String, dynamic> _\$${className}ToJson($className instance) => {
$fields,
    };
''';
  }

  String _getPartFileName(String path) {
    final parts = path.split('/');
    return parts.last;
  }
}
