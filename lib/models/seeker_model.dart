// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SeekerModel {
  String seekerName;
  String seekerAge;
  String seekerAddress;
  String seekerOccupation;

  SeekerModel({
    required this.seekerName,
    required this.seekerAge,
    required this.seekerAddress,
    required this.seekerOccupation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seekerName': seekerName,
      'seekerAge': seekerAge,
      'seekerAddress': seekerAddress,
      'seekerOccupation': seekerOccupation,
    };
  }

  factory SeekerModel.fromMap(Map<String, dynamic> map) {
    return SeekerModel(
      seekerName: map['seekerName'] as String,
      seekerAge: map['seekerAge'] as String,
      seekerAddress: map['seekerAddress'] as String,
      seekerOccupation: map['seekerOccupation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SeekerModel.fromJson(String source) => SeekerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
