import 'schedule.dart';

class Data {
  String task;
  bool success;
  String studentId;
  String name;
  String className;
  String major;
  List<Schedule> schedules;
  String error;

  Data(
      {this.task,
        this.success,
        this.studentId,
        this.name,
        this.className,
        this.major,
        this.schedules,
        this.error});

  Data.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    success = json['success'];
    studentId = json['student_id'];
    name = json['name'];
    className = json['class_name'];
    major = json['major'];
    error = json['error'];
    if (json['schedule'] != null) {
      schedules = new List<Schedule>();
      json['schedule'].forEach((v) {
        schedules.add(new Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task'] = this.task;
    data['success'] = this.success;
    data['student_id'] = this.studentId;
    data['name'] = this.name;
    data['class_name'] = this.className;
    data['major'] = this.major;
    data['error'] = this.error;
    if (this.schedules != null) {
      data['schedule'] = this.schedules.map((v) => v.toJson()).toList();
    }
    return data;
  }
}