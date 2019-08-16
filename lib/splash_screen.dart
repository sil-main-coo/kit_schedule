import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule/src/service/web_service.dart';
import 'package:schedule/src/ui/page/home_screen.dart';
import 'package:schedule/src/ui/page/login_screen.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData().then((value) async {
      await navigateToScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        alignment: Alignment.center,
        color: Colors.blue[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(200),
                  height: ScreenUtil.getInstance().setWidth(200),
                  color: Colors.white,
                ),
                SvgPicture.asset(
                  'assets/img/kit-logo.svg',width: ScreenUtil.getInstance().setWidth(250),color: Colors.blue[900],
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
            Text("KIT Schedule", style: TextStyle(fontSize: ScreenUtil.getInstance().setWidth(50), color: Colors.white,
                fontFamily: 'MR',
                fontWeight: FontWeight.w700),)
          ],
        ),
      ),
    );
  }

  Future initData() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Future navigateToScreen() async {
    WebService service =  new WebService();
    String data = await service.retrieveData("data");
    if( data == null ) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }

  }
}