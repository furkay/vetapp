import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vetapp/features/service/user_db.dart';
import 'package:vetapp/features/view/petviews/pets_card.dart';

class UserDetails extends StatefulWidget {
  final String data;

  const UserDetails({Key key, this.data}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  _launchCaller(String _url) async {
    String url = "tel:$_url";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003D78),
        title: Text("Üye Profili"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List>(
              future: UserDB().getUserByName(widget.data),
              initialData: List(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, int position) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Card(
                                            color: Colors.red.shade200,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "İsim",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Card(
                                            color: Colors.green.shade300,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                snapshot.data[position].name,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Card(
                                            color: Colors.red.shade200,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Adres",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Card(
                                            color: Colors.green.shade300,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                snapshot.data[position].adress,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Card(
                                            color: Colors.red.shade200,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Numara",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              _launchCaller(snapshot
                                                  .data[position].number);
                                            },
                                            child: Card(
                                              color: Colors.green.shade300,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    
                                                    Text(
                                                      snapshot.data[position]
                                                          .number,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Icon(
                                                      Icons.call,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
            PetsCard(
              userName: widget.data,
            ),
          ],
        ),
      ),
    );
  }
}
