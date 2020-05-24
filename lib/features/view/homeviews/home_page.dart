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
    return  ChangeNotifierProvider<UserProvider>(
               create: (_) => UserProvider(),
              child:Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(addUser);
                },
                child: Text("Kayıt Ol"),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
             buildLoginForm()
                //PetsCard Kullanıcı Profiline koyulacak calistirmak için koydum comment alınabilir
                //PetsCard(),
              ],
            ),
          ),
        )),
               );
    
  }

  Widget buildLoginForm() {
   var data= sl<UserProvider>();
   // final userProvider = Provider.of<UserProvider>(context);
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.pets, size: 50),
            TextFormField(
              controller: userNameCtrl,
              decoration:
                  InputDecoration(hintText: "Kullanıcı adınızı giriniz"),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Kullanıcı adı boş bırakılamaz';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordCtrl,
              decoration: InputDecoration(hintText: "Şifrenizi giriniz"),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Şifre boş bırakılamaz';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        UserDB()
                            .authControl(userNameCtrl.text, passwordCtrl.text)
                            .then((value) {
                          if (value.name.isNotEmpty) {
                            data.setUser(value);
                            Navigator.of(context).pushNamed(data.getUser.level == "Uye" ? userHome : vetHome);
                          } else
                            print("hata");
                        });
                      }
                    },
                    child: Text("Giriş Yap"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
