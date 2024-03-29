import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();

  double width;
  double height;
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;

  static double _textScaleFactor;

  ScreenUtil({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  });

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  static double get textScaleFactory => _textScaleFactor;

  static double get pixelRatio => _pixelRatio;

  /// dp
  static double get screenWidthDp => _screenWidth;

  /// dp
  static double get screenHeightDp => _screenHeight;

  /// px
  static double get screenWidth => _screenWidth * _pixelRatio;

  /// px
  static double get screenHeight => _screenHeight * _pixelRatio;

  /// dp
  static double get statusBarHeight => _statusBarHeight;

  /// dp
  static double get bottomBarHeight => _bottomBarHeight;

  ///dp
  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;

  ///Thích ứng với chiều rộng thiết bị của dự thảo thiết kế
  ///Chiều cao cũng được điều chỉnh theo điều này để đảm bảo không bị biến dạng
  setWidth(double width) => width * scaleWidth;

  /// Thích nghi cao với thiết kế của thiết bị
  /// Khi nhận thấy rằng một màn hình trong bản phác thảo thiết kế không phù hợp với hiệu ứng kiểu hiện tại,/// hoặc khi có sự khác biệt về hình dạng, nên sử dụng phương pháp này để điều chỉnh chiều cao.
  /// Việc điều chỉnh chiều cao chủ yếu cho cùng hiệu ứng mà bạn muốn hiển thị
  /// theo một màn hình của bản phác thảo thiết kế.
  setHeight(double height) => height * scaleHeight;

  setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}
