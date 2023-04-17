class AcceptedModel {
  final String candidateName;
  final String candidateOccupation;
  final String candidateEmail;
  final String candidateAppliedJob;
  final String candidatePhoto;
  final String createdTime;
  final String candidateCv;
  AcceptedModel({
    required this.candidateName,
    required this.candidateOccupation,
    required this.candidateEmail,
    required this.candidateAppliedJob,
    required this.createdTime,
    required this.candidatePhoto,
    required this.candidateCv,
  });
  factory AcceptedModel.fromMap(Map<String, dynamic> map) {
    return AcceptedModel(
      candidateName: map['candidateName'],
      candidateOccupation: map['candidateOccupation'],
      candidateEmail: map['candidateEmail'],
      candidateAppliedJob: map['candidateAppliedJob'],
      createdTime: map['createdTime'],
      candidatePhoto: map['candidatePhoto'],
      candidateCv: map['candidateCv'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'candidateName': candidateName,
      'candidateOccupation': candidateOccupation,
      'candidateEmail': candidateEmail,
      'candidateAppliedJob': candidateAppliedJob,
      'createdTime': createdTime,
      'candidatePhoto': candidatePhoto,
      'candidateCv': candidateCv,
    };
  }
}
