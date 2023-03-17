// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VacancyModel {
  String position;
  String salary;
  String location;
  String type;
  String description;
  String companyName;
  String createdTime;
  String? recruiterId;

  VacancyModel({
    required this.position,
    required this.salary,
    required this.location,
    required this.type,
    required this.description,
    required this.companyName,
    required this.createdTime,
    required this.recruiterId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position,
      'salary': salary,
      'location': location,
      'type': type,
      'description': description,
      'companyName': companyName,
      'createdTime': createdTime,
      'recruiterId': recruiterId,
    };
  }

  factory VacancyModel.fromJson(Map<String, dynamic> json) => VacancyModel(
        description: json['description'],
        salary: json['salary'],
        companyName: json['companyName'],
        location: json['location'],
        position: json['position'],
        createdTime: json['createdTime'],
        type: json['type'],
        recruiterId: json['recruiterId'],
      );

  String toJson() => json.encode(toMap());
}
