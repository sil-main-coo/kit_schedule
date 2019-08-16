import 'package:flutter/material.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeelbackScreen extends StatelessWidget {
  WebViewController _controller;
  String flutterUrl = "https://bitly.vn/8i5g";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)..init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Feedback",
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
body: WebView(
  key: Key("webview"),
  initialUrl: flutterUrl,
  javascriptMode: JavascriptMode.unrestricted,
  onWebViewCreated: (WebViewController webViewController) {
    _controller = webViewController;
  },
),
      ),
    );
  }

}