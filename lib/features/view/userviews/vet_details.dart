import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
      appBar: AppBar(
        backgroundColor: Color(0xFF003D78),
        title: Text("Doktorlar"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: FutureBuilder(
                  future: VetDB().fetchVetAllData(widget.data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Color(0xFF003D78).withAlpha(150),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.account_circle,
                                            color: Colors.white),
                                        Text(
                                          " Doktor ${index + 1}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: buildListView(
                                              snapshot.data[index])),
                                    ],
                                  ),
                                ],
                              ),
                            );
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

  List titleList = [
    "İsim :",
    "Klinik :",
    "Adres :",
    "Numara :",
    "Level :",
    "Vergi No :"
  ];
  _launchCaller(String _url) async {
    String url = "tel:$_url";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  ListView buildListView(List list) {
    return ListView.builder(
      itemCount: list.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(titleList[index % 5]),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(list[index]),
                      GestureDetector(
                        onTap: () {
                          _launchCaller("${list[index]}");
                        },
                                              child: Visibility(
                          visible: index == 3 ? true : false,
                          child: Icon(
                            Icons.phone,
                            color: Color(0xFF003D78),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
