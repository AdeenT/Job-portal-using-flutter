import 'dart:convert';

class SeekerModel {
  String seekerName;
  String seekerAge;
  String seekerAddress;
  String seekerOccupation;
  String seekerEmail;
  String seekerDpUrl;

  SeekerModel({
    required this.seekerName,
    required this.seekerAge,
    required this.seekerAddress,
    required this.seekerOccupation,
    required this.seekerEmail,
    required this.seekerDpUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seekerName': seekerName,
      'seekerAge': seekerAge,
      'seekerAddress': seekerAddress,
      'seekerOccupation': seekerOccupation,
      'seekerEmail': seekerEmail,
      'seekerDpUrl': seekerDpUrl,
    };
  }

  factory SeekerModel.fromMap(Map<String, dynamic> map) {
    return SeekerModel(
      seekerName: map['seekerName'] as String,
      seekerAge: map['seekerAge'] as String,
      seekerAddress: map['seekerAddress'] as String,
      seekerOccupation: map['seekerOccupation'] as String,
      seekerEmail: map['seekerEmail'] as String,
      seekerDpUrl: map['seekerDpUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SeekerModel.fromJson(String source) =>
      SeekerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
