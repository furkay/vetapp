import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/features/service/user_db.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
      child: Scaffold(
          body: SingleChildScrollView(
                      child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/pett.png'),
                    height: 300,
                  ),
                  buildLoginForm()
                ],
              ),
            ),
          )),
    );
  }

  Widget buildLoginForm() {
    var data = sl<UserProvider>();
    // final userProvider = Provider.of<UserProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF003D78),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: TextFormField(
              controller: userNameCtrl,
              minLines: 1,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Kullanıcı adı boş bırakılamaz';
                }
                return null;
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Kullanıcı Adı",
                labelStyle: TextStyle(color: Color(0xffEEEEEE)),
                errorStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey.shade50.withAlpha(10),
                border: InputBorder.none,
                icon: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF003D78),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: TextFormField(
              controller: passwordCtrl,
              minLines: 1,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Şifre boş bırakılamaz';
                }
                return null;
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Şifre",
                labelStyle: TextStyle(color: Color(0xffEEEEEE)),
                errorStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey.shade50.withAlpha(10),
                border: InputBorder.none,
                icon: Icon(Icons.vpn_key, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  color: Color(0xFF71BF44),
                  onPressed: () {
                    Navigator.of(context).pushNamed(addUser);
                  },
                  child: Text(
                    "Kayıt Ol",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 15),
                RaisedButton(
                  color: Color(0xFF003D78),
                  onPressed: () {
                   if (_formKey.currentState.validate()) {
                        UserDB()
                            .authControl(userNameCtrl.text, passwordCtrl.text)
                            .then((value) {
                          if (value.name.isNotEmpty) {
                            data.setUser(value);
                          //  Navigator.of(context).pushNamed(data.getUser.level == "Uye" ? userHome : vetHome);
                            Navigator.pushNamedAndRemoveUntil(context, data.getUser.level == "Uye" ? userHome : vetHome, (route) => false);
                          } else
                            print("hata");
                        });
                      }
                  },
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
