import 'lesson.dart';

class Schedule {
  int date;
  List<Lesson> lessons;

  Schedule({this.date, this.lessons});

  Schedule.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['lessons'] != null) {
      lessons = new List<Lesson>();
      json['lessons'].forEach((v) {
        lessons.add(new Lesson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.lessons != null) {
      data['lessons'] = this.lessons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
