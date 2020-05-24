import 'package:flutter/material.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/features/service/user_db.dart';

class VetHome extends StatefulWidget {
  @override
  _VetHomeState createState() => _VetHomeState();
}

class _VetHomeState extends State<VetHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(userProfile),
              child: Text("Profil"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<List>(
              future: UserDB().fetchUser(),
              initialData: List(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            color: Colors.red.shade200,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "İsim",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, int position) {
                                return Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                userDetails,
                                                arguments: snapshot
                                                    .data[position].name);
                                          },
                                          child: Text(
                                            snapshot.data[position].name,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
