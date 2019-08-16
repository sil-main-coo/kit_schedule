import 'dart:convert';

import 'package:schedule/src/enums/view_state.dart';
import 'package:schedule/src/models/data.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/models/schedule.dart';
import 'package:schedule/src/service/web_service.dart';
import 'package:schedule/src/utils/lesson_convert.dart';

import '../../service_locator.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  WebService _service = locator<WebService>();
  List<Schedule> _allScheduleList = new List<Schedule>();
  List<Lesson> _allSchudeleByLessonList = new List<Lesson>();
  List<Schedule> _allSchudeleByWeekList = new List();
  List _selectDay = new List();



  List<Schedule> get allSchudeleByWeekList => _allSchudeleByWeekList;
  Data _data;

  List get selectDay => _selectDay;

  set selectDay(List value) {
    _selectDay = value;
    notifyListeners();
  }

  Map<DateTime, List> _schudeles = new Map();

  Map<DateTime, List> get schudeles => _schudeles;

  set schudeles(Map<DateTime, List> value) {
    _schudeles = value;
    notifyListeners();
  }

  WebService get service => _service;

  set service(WebService value) {
    _service = value;
    notifyListeners();
  }

  set allSchudeleByWeekList(List<Schedule> value) {
    _allSchudeleByWeekList = value;
  }

  List<Lesson> get allSchudeleByLessonList => _allSchudeleByLessonList;

  set allSchudeleByLessonList(List<Lesson> value) {
    _allSchudeleByLessonList = value;
    notifyListeners();
  }

  List<Schedule> get allScheduleList => _allScheduleList;

  set allScheduleList(List<Schedule> value) {
    _allScheduleList = value;
  }

  Data get data => _data;

  set data(Data value) {
    _data = value;
    notifyListeners();
  }

  Future getScheduleData() async {
    setState(ViewState.Busy);
    notifyListeners();
    String scheduleJson = await service.retrieveData("data");
    data = Data.fromJson(json.decode(scheduleJson));
      allScheduleList.addAll(data.schedules);

      allScheduleList.sort(
              (Schedule obj_a, Schedule obj_b) => obj_a.date.compareTo(obj_b.date));

      allScheduleList.forEach((obj) {
        DateTime dayLesson = Convert.TimerConvert(
            new DateTime.fromMillisecondsSinceEpoch(obj.date));
        List<Lesson> lessones = Convert.sortLesson(obj.lessons);
        List lessonPackage = new List();
        lessones.forEach((lessonInfo) {

          lessonPackage.add(lessonPackaging(lessonInfo));
        });
        schudeles[dayLesson] = lessonPackage;
        notifyListeners();
      });
      setState(ViewState.DataFetched);
    notifyListeners();
  }


  lessonPackaging(Lesson lessonInfo) {
    String lessonNumb = lessonInfo.lesson;
    String subjectName = lessonInfo.subjectName;
    String address = lessonInfo.address;
    return "$lessonNumb-$subjectName-$address";
  }
}
