import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {

  final String data;

  const UserDetails({Key key, this.data}) : super(key: key);

  

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
            Text(widget.data),
        ],
      ),
    );
  }
}