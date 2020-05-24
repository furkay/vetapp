import 'package:flutter/material.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/features/view/petviews/pets_card.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends BaseState<UserProfile> {
  var user= sl<UserProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(),
   body: Container(
     child: SingleChildScrollView(
       child: Column(
         children: <Widget>[
          Text(user.getUser.name),

          //buraya profil bilgilerini full çekersin
          //bu pet cartta bu sayfada biyerde olur
          PetsCard()
         ],
       ),
     )
   ),
    );
  }
}