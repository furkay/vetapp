import 'package:flutter/material.dart';
import 'package:vetapp/features/view/treatmentviews/treatment_list_page.dart';
import 'package:vetapp/features/view/vaccineviews/vaccine_list_page.dart';

class PetTab extends StatefulWidget {
 final List list;
  

  PetTab({@required this.list});
  @override
  _PetTabState createState() => _PetTabState();
}

class _PetTabState extends State<PetTab> {
  @override
  Widget build(BuildContext context) {
     int petID=widget.list[0];
    String userName=widget.list[1];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "     Sağlık Bilgileri",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.left,
                )),
            bottom: TabBar(tabs: [
              Tab(
                child: Text("Tedaviler"),
                icon: Icon(Icons.healing),
              ),
              Tab(
                child: Text("Aşılar"),
                icon: Icon(Icons.live_help),
              ),
            ]),
          ),
          body: TabBarView(children: [
            TreatmentListPage(petID: petID, userName:userName),
            VaccineListPage(petID: petID,userName:userName),
          ])),
    );
  }
}
