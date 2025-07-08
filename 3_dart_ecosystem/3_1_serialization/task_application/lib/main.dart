import 'dart:convert';
import 'dart:io';

import 'package:task_application/models/request.dart';

void main(List<String> args) {
  final jsonFile = File(
      '/Users/a7/Desktop/flutter-incubator-main/3_dart_ecosystem/3_1_serialization/request.json');
  final jsonString = jsonFile.readAsStringSync();
  final request = Request.fromJson(jsonDecode(jsonString));

  print('YAML:\n${request.toYaml()}\n');
  print('TOML:\n${request.toToml()}');
}
