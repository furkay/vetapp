import 'package:flutter/material.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/core/view/widget/TextFormField/build_custom_field.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';
import 'package:vetapp/features/model/vaccine.dart';
import 'package:vetapp/features/service/vaccine_db.dart';
import 'dart:math';

class VaccineAdd extends StatefulWidget {
  @override
  _VaccineAddState createState() => _VaccineAddState();
}

class _VaccineAddState extends BaseState<VaccineAdd> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TextField Create

    List<TextFormFieldObject> fields = [
      TextFormFieldObject(
          hintText: "Aşı Adı", icon: Icons.colorize, controller: name),
      TextFormFieldObject(
          hintText: "Aşı Yapılan Tarih",
          icon: Icons.date_range,
          controller: date),
    ];

    List<Widget> children = [];
    fields.forEach((element) {
      children.add(
          buildTextFormField(field: element, padding: insetHorizontal(0.2)));
    });

    //end

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: dynamicHeight(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                int i = Random().nextInt(10000);
                VaccineDB().addVaccine(Vaccine(
                    petID: i,
                    vaccineDate: name.text,
                    vaccineName: date.text));
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.send),
              label: Text("Kaydet"),
            )
          ],
        ),
      ),
    );
  }
}
