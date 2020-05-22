import 'package:flutter/material.dart';


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
            child: Text("login"),
            onPressed: () {

              Navigator.of(context).pushNamed("");

            },
          )
        ],
      )),
    );
  }
}
