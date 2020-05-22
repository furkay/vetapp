import 'package:flutter/material.dart';
import 'package:vetapp/features/model/user.dart';
import 'package:vetapp/features/service/user_db.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

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
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("kaydet"),
            onPressed: () {
             // UserDB userDB = UserDB();
              UserDB.addUser(User(
                  adress: "sa",
                  level: 10,
                  name: "furkan",
                  number: "1",
                  petID: 12,
                  userID: 21));
                  setState(() {
                    
                  });
            },
          )
        ],
      )),
    );
  }
}
