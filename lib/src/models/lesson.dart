class Lesson {
  String lesson;
  String subjectName;
  String address;

  Lesson({this.lesson, this.subjectName, this.address});

  Lesson.fromJson(Map<String, dynamic> json) {
    lesson = json['lesson'];
    subjectName = json['subject_name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lesson'] = this.lesson;
    data['subject_name'] = this.subjectName;
    data['address'] = this.address;
    return data;
  }
}