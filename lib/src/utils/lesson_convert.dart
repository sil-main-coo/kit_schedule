import 'package:schedule/src/models/lesson.dart';

class Convert {
  static String LessonConvert(String lessonNumber) {
    switch (lessonNumber) {
      case '1 - 3':
        return "1,2,3";
        break;
      case '4 - 6':
        return "4,5,6";
        break;
      case '7 - 9':
        return "7,8,9";
        break;
      case '10 - 12':
        return "10,11,12";
        break;
      case '13 - 14':
        return "13,14";
        break;
      case '15 - 16':
        return "15,16";
        break;
      default:
        return "";
        break;
    }
  }

  static DateTime TimerConvert(DateTime time) {
    int year = time.year;
    int month = time.month;
    int day = time.day;
    DateTime happyDay = DateTime(year, month, day);
    return happyDay;
  }

  static List<Lesson> sortLesson(List<Lesson> lessones) {
    Map<int, Lesson> mapLessones = new Map();

    lessones.forEach((obj) {
      List<String> lessonNumb = obj.lesson.split(",");
      int key = int.parse(lessonNumb[0]);
      if (mapLessones.containsKey(key) == true) {
        key = key + 1;
      }
      mapLessones[key] = obj;
    });

    List<int> sortKeys = mapLessones.keys.toList()..sort();
    List<Lesson> sortLessones = new List();

    for (int i = 0; i <sortKeys.length; i++) {
      int key = sortKeys[i];
      sortLessones.add(mapLessones[key]);
    }
    return sortLessones;
  }
}
