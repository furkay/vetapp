import 'package:flutter/material.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';

import 'package:vetapp/features/viewmodel/user_provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends BaseState<UserProfile> {
  var user = sl<UserProvider>();
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

            FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, homeRoute, (route) => false);
                },
                child: Icon(Icons.exit_to_app))
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
}
