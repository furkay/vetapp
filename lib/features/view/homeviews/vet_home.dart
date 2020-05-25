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
        backgroundColor: Color(0xFF003D78),
        title: Text("Üye Listesi"),
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
                          Container(
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.all(10),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, int position) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(userDetails,
                                        arguments:
                                            snapshot.data[position].name);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                   
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: Text(
                                                "${position + 1}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data[position].name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color:
                                                Colors.black.withOpacity(0.7)),
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
