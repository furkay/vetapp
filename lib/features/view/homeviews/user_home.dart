import 'package:flutter/material.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/features/service/vet_db.dart';
import 'package:vetapp/features/view/petviews/pets_card.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
              PetsCard(),
              /*
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return buildClinicRows();
                  },
                ),
              ) */
              Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  color: Colors.red,
                  child: Text("KLİNİKLER")),
              FutureBuilder<List>(
                future: VetDB().fetchVet(),
                initialData: List(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, int position) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data[position].kullaniciAdi,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ],
          ),
        ));
  }

  Widget buildClinicRows() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.queue),
        title: Text("Sa"),
      ),
    );
  }
}
