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
        backgroundColor: Color(0xFF003D78),
        title: Text("Profil"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FloatingActionButton(
              heroTag: "1",
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, editProfile);
              },
              child: Icon(Icons.edit),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FloatingActionButton(heroTag: "2",
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, homeRoute, (route) => false);
              },
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Image(image: AssetImage("assets/user.png"),height: dynamicHeight(0.25),),
          ),
          buildProfileRow(Icons.perm_identity, "${user.getUser.name}"),
          buildProfileRow(Icons.location_on, "${user.getUser.adress}"),
          buildProfileRow(Icons.equalizer, "${user.getUser.level}"),
          buildProfileRow(Icons.phone, "${user.getUser.number}"),Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            
          ),
        ],
      ),
    );
  }

  Widget buildProfileRow(IconData iconData, String content) {
    return Container(
      
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 100),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border:
                BorderDirectional(bottom: BorderSide(color: Color(0xFFB3B3B3)))),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData,color: Colors.red,),
            SizedBox(width: 10),
            Text("$content", style: TextStyle(color: Colors.black))
          ],
        ),
      ),
    );
  }
}
