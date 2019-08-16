import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:schedule/src/enums/view_state.dart';
import 'package:schedule/src/scoped_model/drawer_menu_model.dart';
import 'package:schedule/src/service/web_service.dart';
import 'package:schedule/src/ui/page/feelback_screen.dart';
import 'package:schedule/src/ui/page/login_screen.dart';
import 'package:schedule/src/ui/views/base_view.dart';
import 'package:schedule/src/ui/views/loading_view.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

import '../../../splash_screen.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class DrawerMenu extends StatefulWidget {
  String name;

  DrawerMenu(String name) {
    this.name = name;
  }

  @override
  _DrawerMenuState createState() => new _DrawerMenuState(this.name);
}

//State is information of the application that can change over time or when some actions are taken.
class _DrawerMenuState extends State<DrawerMenu> {
  String notification = "false";
  String name;
  bool switchOn = false;
  WebService service = new WebService();

  _DrawerMenuState(String name) {
    this.name = name;
  }

  void _onChanged(bool value) {
    setState(() {});
  }

  @override
  Future initState() {
    // TODO: implement initState
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)..init(context);
    service
        .retrieveData("notification")
        .then((data) => this.notification = data);
    return new Scaffold(
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: BaseView<DrawerMenuModel>(
          onModelReady: (model) => model.checkSwitchOn(),
          builder: (context, child, model) {
            if (model.state == ViewState.Busy) {
              return LoadingView();
            } else {
              return new Container(
                child: new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: ScreenUtil.getInstance().setHeight(180),
                            width: MediaQuery.of(context).size.width,
                            decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [0.1, 0.9],
                                colors: [
                                  Color(0xFFFC5C7D),
                                  Color(0xFF6A82FB),
                                ],
                              ),
                            ),
                            padding: EdgeInsets.only(
                                left: ScreenUtil.getInstance().setWidth(18),
                                bottom: ScreenUtil.getInstance().setHeight(14)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Xin chào,",
                                  style: TextStyle(
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(28),
                                      color: Colors.white,
                                      fontFamily: "MR",
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(28),
                                      color: Colors.white,
                                      fontFamily: "MR",
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: InkWell(
                              onTap: () => _setOnClickSwitchButton(model),
                              child: Container(
                                height: ScreenUtil.getInstance().setHeight(120),
                                padding: EdgeInsets.only(
                                    left:
                                        ScreenUtil.getInstance().setWidth(18)),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[300],
                                            width: 1))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Nhận thông báo",
                                      style: TextStyle(
                                          fontSize: ScreenUtil.getInstance()
                                              .setSp(30),
                                          fontFamily: "MR",
                                          fontWeight: FontWeight.w600),
                                    ),
                                    new Switch(
                                        value: model.switchOn,
                                        onChanged: _onChanged),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeelbackScreen()));
                            },
                            child: Container(
                              height: ScreenUtil.getInstance().setHeight(120),
                              padding: EdgeInsets.only(
                                  left: ScreenUtil.getInstance().setWidth(18),
                                  right: ScreenUtil.getInstance().setWidth(18)),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 1))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Phản hồi",
                                    style: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(30),
                                        fontFamily: "MR",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await service.deleteData("data");
                              _cancelNotification();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Container(
                              height: ScreenUtil.getInstance().setHeight(120),
                              padding: EdgeInsets.only(
                                  left: ScreenUtil.getInstance().setWidth(18),
                                  right: ScreenUtil.getInstance().setWidth(18)),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 1))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Đăng xuất",
                                    style: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(30),
                                        fontFamily: "MR",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(Icons.exit_to_app),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(18),
            bottom: ScreenUtil.getInstance().setHeight(20),),
                        child: Text(
                          "© 2019 KIT. All Rights Reserved.",
                          style: TextStyle(
                              fontSize:
                              ScreenUtil.getInstance().setSp(26),
                              fontFamily: "MR",
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  Future<void> _repeatNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
  }

  Future<void> _showWeeklyAtDayAndTime() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'show weekly title',
        'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        Day.Monday,
        time,
        platformChannelSpecifics);
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  _setOnClickSwitchButton(DrawerMenuModel model) {
    model.switchOn = !model.switchOn;
    if (model.switchOn == true) {
      service.persistData("notification", "true");
      _repeatNotification();
    } else {
      service.persistData("notification", "false");
      _cancelNotification();
    }
  }
}
