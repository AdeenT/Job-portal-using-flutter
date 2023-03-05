// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class VacancyModel {
  String position;
  String salary;
  String location;
  String type;

  VacancyModel({
    required this.position,
    required this.salary,
    required this.location,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position,
      'salary': salary,
      'location': location,
      'type': type,
    };
  }

  factory VacancyModel.fromMap(Map<String, dynamic> map) {
    return VacancyModel(
      position: map['position'] as String,
      salary: map['salary'] as String,
      location: map['location'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VacancyModel.fromJson(String source) => VacancyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
