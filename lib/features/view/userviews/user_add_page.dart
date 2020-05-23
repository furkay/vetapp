import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/core/view/widget/TextFormField/build_custom_field.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';
import 'package:vetapp/features/model/user.dart';
import 'package:vetapp/features/model/vet.dart';
import 'package:vetapp/features/service/user_db.dart';
import 'package:vetapp/features/service/vet_db.dart';

class UserAdd extends StatefulWidget {
  @override
  _UserAddState createState() => _UserAddState();
}

class _UserAddState extends BaseState<UserAdd> {
  TextEditingController userName = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController vergiNoCtrl = TextEditingController();
  TextEditingController klinikCtrl = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userLevel = 'Uye';
  String hata;
  bool taxVisible = false;

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
        buildTextFormField(field: element, padding: insetHorizontal(0.2)),
      );
    });

    //end

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Kayıt"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
            Visibility(
              visible: taxVisible,
              child: Container(
                padding: insetHorizontal(0.2),
                child: TextFormField(
                  controller: vergiNoCtrl,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.info_outline),
                      hintText: "Vergi no"),
                ),
              ),
            ),
            Visibility(
              visible: taxVisible,
              child: Container(
                padding: insetHorizontal(0.2),
                child: TextFormField(
                  controller: klinikCtrl,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_hospital),
                      hintText: "Klinik"),
                ),
              ),
            ),
            Padding(
              padding: insetHorizontal(0.1),
              child: Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      groupValue: userLevel,
                      title: Text('Üye'),
                      value: 'Uye',
                      onChanged: (val) {
                        taxVisible = false;
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
                        taxVisible = true;
                        setState(() {
                          userLevel = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) => RaisedButton.icon(
                onPressed: () {
                  int i = Random().nextInt(10000);
                  UserDB()
                      .addUser(User(
                        name: userName.text,
                        adress: adress.text,
                        number: number.text,
                        level: userLevel,
                      ))
                      .then((value) => value != null
                          ? showSnackbar("Bu kullanıcı adı zaten kayıtlı")
                          : null);
                  userLevel == "Veteriner"
                      ? VetDB()
                          .addVet(Vet(
                              vetID: i,
                              kullaniciAdi: userName.text,
                              klinik: klinikCtrl.text,
                              vergiNo: vergiNoCtrl.text))
                          .then((value) => value != null
                              ? showSnackbar("Bu kullanıcı adı zaten kayıtlı")
                              : null)
                      : print("Kullanici");
                },
                icon: Icon(Icons.send),
                label: Text("Kaydet"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showSnackbar(String message) {
    return _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('$message'),
      duration: Duration(seconds: 2),
    ));
  }
}
