import 'package:flutter/material.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/core/view/widget/TextFormField/build_custom_field.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';

import 'package:vetapp/features/model/user.dart';

import 'dart:math';

import 'package:vetapp/features/service/user_db.dart';

class UserAdd extends StatefulWidget {
  @override
  _UserAddState createState() => _UserAddState();
}

class _UserAddState extends BaseState<UserAdd> {
  TextEditingController userName = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController number = TextEditingController();
  String userLevel = 'Uye';
  @override
  Widget build(BuildContext context) {
    //TextField Create

    List<TextFormFieldObject> fields = [
      TextFormFieldObject(
          hintText: "Kullanıcı Adı",
          icon: Icons.colorize,
          controller: userName),
      TextFormFieldObject(
          hintText: "Adres", icon: Icons.colorize, controller: adress),
      TextFormFieldObject(
          hintText: "Numara", icon: Icons.phone_android, controller: number),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: RadioListTile(
                    groupValue: userLevel,
                    title: Text('Üye'),
                    value: 'Uye',
                    onChanged: (val) {
                      setState(() {
                        userLevel = val;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile(
                    groupValue: userLevel,
                    title: Text('Veteriner'),
                    value: 'Veteriner',
                    onChanged: (val) {
                      setState(() {
                        userLevel = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            RaisedButton.icon(
              onPressed: () {
                int i = Random().nextInt(10000);
                UserDB().addUser(User(
                  name: userName.text,
                  adress: adress.text,
                  number: number.text,
                  level: userLevel,
                ));
                //.then((value) => Navigator.of(context).pop());
              },
              icon: Icon(Icons.send),
              label: Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}
