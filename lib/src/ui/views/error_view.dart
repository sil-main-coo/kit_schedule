import 'package:flutter/material.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)..init(context);
    return Scaffold(
      body: Center(
        child: Row(
          children: <Widget>[
            Icon(Icons.error_outline, color: Colors.redAccent),
            Text(
              "Error connection",
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(34),
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
