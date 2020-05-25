import 'package:flutter/material.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/features/service/vet_db.dart';

class VetDetails extends StatefulWidget {
  final String data;
  VetDetails({@required this.data});
  @override
  _VetDetailsState createState() => _VetDetailsState();
}

class _VetDetailsState extends BaseState<VetDetails> {
  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: dynamicHeight(0.5),
              child: FutureBuilder(
                  future: VetDB().fetchVetAllData(widget.data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // snapshot.data.forEach(

                      // );

                      return ListView.builder(
                          //TODO 2 aynı klinikte olan tüm doktorlar
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List<String> list = snapshot.data[index];

                            return Column(
                              children: <Widget>[
                                Text("Doktor ${index + 1}"),
                                Container(
                                  height: dynamicHeight(0.4),
                                  //Height vermeyincce hata verdi ona göre tikkat et :D
                                  child: ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: Text(list[index]),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                            //   return Container();
                          });
                    } else
                      return CircularProgressIndicator();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
