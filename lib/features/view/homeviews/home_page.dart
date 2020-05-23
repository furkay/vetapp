import 'package:flutter/material.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/features/view/petviews/pets_card.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           RaisedButton(
            child: Text("login"),
            onPressed: () {
              //Using for create design
              Navigator.of(context).pushNamed(addTreatment);
            },
          ),

          //PetsCard Kullanıcı Profiline koyulacak calistirmak için koydum comment alınabilir
        PetsCard(),
          ],
        ),
      )
    );
  }
}
