import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/enums/view_state.dart';
import 'package:schedule/src/scoped_model/home_view_model.dart';
import 'package:schedule/src/scoped_model/login_view_model.dart';
import 'package:schedule/src/ui/menu/drawer_menu.dart';
import 'package:schedule/src/ui/views/base_view.dart';
import 'package:schedule/src/ui/views/loading_view.dart';
import 'package:schedule/src/utils/lesson_convert.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Map<DateTime, List> _events = new Map();
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime dayLesson;

  int checkDuplicate = 0;

  LoginViewModel model;

  @override
  void initState() {
    super.initState();

    final _selectedDay = DateTime.now();

    _selectedEvents = _events[_selectedDay] ?? [];

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    dayLesson = Convert.TimerConvert(day);
    if (_events.containsKey(dayLesson) == false) {
      Toast.show("Bạn không có lịch học vào ngày này", context,
          backgroundColor: Colors.redAccent, duration: Toast.LENGTH_LONG);
    }
    setState(() {
      _selectedEvents = _events[dayLesson] ?? [];
      _selectedEvents.forEach((obj) {
        print(obj.toString());
      });
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)..init(context);
    return SafeArea(
        child: BaseView<HomeViewModel>(
      onModelReady: (model) => model.getScheduleData(),
      builder: (context, child, model) {
        if (model.state == ViewState.Busy) {
          return LoadingView();
        } else {
          _events = model.schudeles;
          return Scaffold(
              drawer: Drawer(
                child: DrawerMenu(model.data.name),
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "KIT Schedule",
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(40),
                      fontFamily: "MR"),
                ),
                flexibleSpace: Container(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Color(0xFF6A82FB),
                          Color(0xFFFC5C7D),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
              ),
              body: CustomScrollView(slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  // Switch out 2 lines below to play with TableCalendar's settings
                  //-----------------------
                  _buildTableCalendar(),
                  _buildEventList(),
                ]))
              ]));
        }
      },
    ));
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blue[800],
        todayColor: Colors.blue[400],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventList() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(30)),
      child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: _selectedEvents.length,
          itemBuilder: ((context, posion) {
            // Open Package Lesson
            String lessonPackage = _selectedEvents[posion];
            List openPackage = lessonPackage.split("-");
            String lesson = openPackage[0];
            String subjectName = openPackage[1];
            String address = openPackage[2];
            Color color = Colors.black;
            if(posion>0) {
              if(_selectedEvents[posion-1].toString().contains(lesson) == true) {
                color = Colors.red;
              }
            }
            return _eventItemUI(lesson, subjectName, address, color);
          })),
    );
  }

  _eventItemUI(String lesson, String subjectName, String address, Color color) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8, color: color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width/5,
                child: Text("Tiết học: ",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(28),
                        color: color,
                        fontFamily: 'MR',
                        fontWeight: FontWeight.w600)),
              ),
              Text(lesson.trim(),
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(28),
                      color: color,
                      fontFamily: 'MR',
                      fontWeight: FontWeight.w500)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width/5,
                child: Text("Môn học: ",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(28),
                        color: color,
                        fontFamily: 'MR',
                        fontWeight: FontWeight.w600)),
              ),
              Flexible(
                child: Text(subjectName.trim(),
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(28),
                        color: color,
                        fontFamily: 'MR',
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width/5,
                child: Text("Địa điểm: ",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(28),
                        color: color,
                        fontFamily: 'MR',
                        fontWeight: FontWeight.w600)),
              ),
              Text(address.trim(),
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(28),
                      color: color,
                      fontFamily: 'MR',
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
