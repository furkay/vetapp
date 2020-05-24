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
            FutureBuilder<List>(
              future: VetDB().fetchVet(),
              initialData: List(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              color: Colors.red,
                              child: Text("KLİNİKLER")),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, int position) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(vetDetails, arguments:snapshot.data[position].kullaniciAdi);
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data[position].kullaniciAdi,
                                        textAlign: TextAlign.center,
                                      ),
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
