import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)..init(context);
    return Scaffold(
      body: Container(
        color: Colors.blue[900],
          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
          child: SpinKitRotatingCircle(
            color: Colors.blue,
            size: 50.0,
          )),
    );
  }
}
