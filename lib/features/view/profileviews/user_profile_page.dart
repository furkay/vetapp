import 'package:flutter/material.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/features/view/petviews/pets_card.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends BaseState<UserProfile> {
  var user = sl<UserProvider>();

  final TextEditingController _nameControl = TextEditingController();
  final TextEditingController _adressControl = TextEditingController();
  final TextEditingController _numberControl = TextEditingController();
  final TextEditingController _passControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, editProfile);
              },
              child: Text("Düzenle"),
            ),
          ),
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildProfileRow("Kullanıcı Adı :", "${user.getUser.name}"),
            buildProfileRow("Adres :", "${user.getUser.adress}"),
            buildProfileRow("Kayıt Durumu :", "${user.getUser.level}"),
            buildProfileRow("Numara :", "${user.getUser.number}"),
            //buraya profil bilgilerini full çekersin
            //bu pet cartta bu sayfada biyerde olur
            PetsCard(),
          ],
        ),
      )),
    );
  }

  Widget buildProfileRow(String title, String content) {
    return Container(
      color: Color(0xFF333333),
      child: Container(
        decoration: BoxDecoration(
            border:
                BorderDirectional(bottom: BorderSide(color: Colors.yellow))),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text("$title", style: TextStyle(color: Colors.white)),
            ),
            Expanded(
              flex: 1,
              child: Text("$content", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget textfieldWidget(
      TextEditingController textEditingController,
      String label,
      IconData iconData,
      bool isEnable,
      bool isSuffix,
      bool obscure) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: TextFormField(
        enabled: isEnable,
        controller: textEditingController,
        minLines: 1,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black87,
          ),
          filled: true,
          fillColor: Colors.grey.shade50.withAlpha(10),
          border: InputBorder.none,
          icon: Icon(iconData, color: Colors.orange),
        ),
      ),
    );
  }
}
