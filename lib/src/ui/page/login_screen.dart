import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule/src/enums/view_state.dart';
import 'package:schedule/src/scoped_model/login_view_model.dart';
import 'package:schedule/src/ui/views/base_view.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool checkValid = false;

  TextEditingController _accountController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)..init(context);

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _LogoAppUI(),
            _TextForm(),
          ],
        ),
      ),
    ));
  }

  _LogoAppUI() {
    return Column(
      children: <Widget>[
        Container(
            margin:
                EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(200)),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: ScreenUtil.getInstance().setHeight(150),
                  width: ScreenUtil.getInstance().setHeight(150),
                  color: Colors.white,
                ),
                SvgPicture.asset('assets/img/kit-logo.svg',
                    color: Colors.blue[900],
                    height: ScreenUtil.getInstance().setHeight(200)),
              ],
            )),
        Text(
          "KIT Schedule",
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(36),
              color: Colors.white,
              fontFamily: 'MR',
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  _TextForm() {
    return BaseView<LoginViewModel>(
      builder: (context, child, model) {
        return Form(
          key: _key,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
                child: TextField(
                  controller: _accountController,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(32),
                      color: Colors.white,
                      fontFamily: "MR"),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    errorText: model.checkValids.contains(1) ? "Tên đăng nhập phải có 8 kí tự gồm cả số và chữ" : null,
                      errorStyle: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(28),
                          color: Colors.red,
                          fontFamily: "MR"),
                      labelText: 'KMA Account',
                      labelStyle: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(32),
                          color: Colors.white,
                          fontFamily: "MR"),
                      prefixIcon:
                          Icon(Icons.account_circle, color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                child: TextField(
                  controller: _passwordController,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(32),
                      color: Colors.white,
                      fontFamily: "MR"),
                  autocorrect: false,
                  decoration: InputDecoration(
                    errorText: model.checkValids.contains(2) ? "Mật khẩu không được bỏ trống" : null,
                      errorStyle: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(28),
                          color: Colors.red,
                          fontFamily: "MR"),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(32),
                          color: Colors.white,
                          fontFamily: "MR"),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: GestureDetector(
                  onTap: () {
                    _setOnClickLoginButton(model);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: ScreenUtil.getInstance().setHeight(100),
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(34),
                            color: Colors.blue,
                            fontFamily: 'MR',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              _loadingUI(model)
            ],
          ),
        );
      },
    );
  }

  Visibility _loadingUI(LoginViewModel model) {
    print(model.notificationViewVisible);
    return Visibility(
        visible: model.notificationViewVisible != -1,
        child: model.state == ViewState.Busy
            ? Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(50)),
                child: SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 40.0,
                ),
              )
            : _stateUI(model));
  }

  Future _setOnClickLoginButton(LoginViewModel model) async {
    checkValid = model.checkValidationForm(_accountController.text.toUpperCase(), _passwordController.text);
    if (checkValid == true) {
      await model.fetchScheduleData(
          _accountController.text.toUpperCase(), _passwordController.text);
      if (model.state == ViewState.Busy) {
        print("wating");
      } else if (model.state == ViewState.Success) {
        print("success");
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }

  _stateUI(LoginViewModel model) {
    switch (model.notificationViewVisible) {
      case -1:
        return Padding(
          padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
          child: Text(
            "Kết nối thất bại. Vui lòng kiểm tra lại",
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(28),
                color: Colors.red,
                fontFamily: "MR",
                fontWeight: FontWeight.w600),
          ),
        );
        break;
      case 0:
        return Padding(
          padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(50)),
          child: Text(
            "Tên đăng nhập hoặc mật khẩu không đúng",
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(28),
                color: Colors.red,
                fontFamily: "MR",
                fontWeight: FontWeight.w600),
          ),
        );
        break;
      case 1:
        return Container();
        break;
    }
  }
}
