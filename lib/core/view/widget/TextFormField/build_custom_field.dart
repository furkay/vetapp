import 'package:flutter/material.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';

Padding buildTextFormField(
    {@required TextFormFieldObject field, EdgeInsets padding}) {
  return Padding(
    padding: padding,
    child: TextFormField(
      decoration: InputDecoration(
        hintText: field.hintText,
        prefixIcon: Icon(field.icon),
      ),
      controller: field.controller,
    ),
  );
}
