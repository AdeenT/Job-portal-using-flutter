import 'dart:convert';

class RecruiterModel {
  String recruiterName;
  String recruiterEmail;
  String recruiterAddress;
  String recruiterPlace;
  String recruiterDate;
  String recruiterDp;

  RecruiterModel({
    required this.recruiterName,
    required this.recruiterEmail,
    required this.recruiterAddress,
    required this.recruiterPlace,
    required this.recruiterDate,
    required this.recruiterDp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recruiterName': recruiterName,
      'recruiterEmail': recruiterEmail,
      'recruiterAddress': recruiterAddress,
      'recruiterPlace': recruiterPlace,
      'recruiterDate': recruiterDate,
      'recruiterDp': recruiterDp,
    };
  }

  factory RecruiterModel.fromMap(Map<String, dynamic> map) {
    return RecruiterModel(
      recruiterName: map['recruiterName'] as String,
      recruiterEmail: map['recruiterEmail'] as String,
      recruiterAddress: map['recruiterAddress'] as String,
      recruiterPlace: map['recruiterPlace'] as String,
      recruiterDate: map['recruiterDate'] as String,
      recruiterDp: map['recruiterDp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecruiterModel.fromJson(String source) =>
      RecruiterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
