import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();

  int _designWidth;
  int _designHeight;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;

  static double _textScaleFactor;

  ScreenUtil({int width, int height}) {
    _designWidth = width;
    _designHeight = height;
  }

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

  static double get screenWidthDp => _screenWidth;

  static double get screenHeightDp => _screenHeight;

  static double get screenWidth => _screenWidth;

  static double get screenHeight => _screenHeight;

  static double get statusBarHeight => _statusBarHeight;

  static double get bottomBarHeight => _bottomBarHeight;

  get scaleWidth => _screenWidth / instance._designWidth;

  get scaleHeight => _screenHeight / instance._designHeight;

  setWidth(int width) => width * scaleWidth;

  L(double width) => width * scaleWidth;

  setHeight(int height) => height * scaleHeight;

  setSp(int fontSize, [allowFontScaling = true]) => allowFontScaling
      ? setWidth(fontSize) * _textScaleFactor
      : setWidth(fontSize);
}
