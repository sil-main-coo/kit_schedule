import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:schedule/service_locator.dart';
import 'package:schedule/src/ui/page/login_screen.dart';
import 'package:schedule/splash_screen.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  setupLocator();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
