import 'package:flutter/material.dart';


abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get currentTheme => Theme.of(context);

  double dynamicHeight(double val) => MediaQuery.of(context).size.height * val;
  double dynamicWidth(double val) => MediaQuery.of(context).size.width * val;

  EdgeInsets insetsAll(double val) => EdgeInsets.all(dynamicHeight(val));
  EdgeInsets insetHorizontal(double val) =>
      EdgeInsets.symmetric(horizontal: dynamicWidth(val));
  EdgeInsets insetVertical(double val) =>
      EdgeInsets.symmetric(vertical: dynamicHeight(val));
  EdgeInsets insetSymmetric({@required double width,@required double height}) =>
      EdgeInsets.symmetric(horizontal: dynamicWidth(width),vertical: dynamicHeight(height));
}