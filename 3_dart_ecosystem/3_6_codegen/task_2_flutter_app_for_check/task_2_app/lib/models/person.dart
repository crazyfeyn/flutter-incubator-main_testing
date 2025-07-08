part 'person.g.dart';

@Serializable()
class Person {
  final String name;
  final DateTime birthday;

  Person({required this.name, required this.birthday});

  // These will be generated
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
