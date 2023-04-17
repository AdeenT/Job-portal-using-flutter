class Bookmark {
  final String title;
  final String location;
  final String salary;
  final String companyName;
  final String type;
  final String jobId;
  final String companyLogo;

  Bookmark({
    required this.type,
    required this.companyName,
    required this.title,
    required this.location,
    required this.salary,
    required this.jobId,
    required this.companyLogo,
  });

  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(
        title: map['title'],
        companyName: map['companyName'],
        location: map['location'],
        type: map['type'],
        salary: map['salary'],
        jobId: map['jobId'],
        companyLogo: map['companyLogo']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'companyName': companyName,
      'location': location,
      'type': type,
      'salary': salary,
      'jobId': jobId,
      'companyLogo': companyLogo
    };
  }
}
