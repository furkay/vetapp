import 'package:flutter/material.dart';

class TextFormFieldObject {
  String hintText;
  IconData icon;
  TextEditingController controller;

  TextFormFieldObject(
      {@required this.hintText,
      @required this.icon,
      @required this.controller});
}
