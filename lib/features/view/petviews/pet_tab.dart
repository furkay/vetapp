import 'package:flutter/material.dart';
import 'package:vetapp/features/view/treatmentviews/treatment_list_page.dart';

class PetTab extends StatefulWidget {
  final int petID;

  PetTab({@required this.petID});
    @override
  _PetTabState createState() => _PetTabState();
}

class _PetTabState extends State<PetTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
        appBar: AppBar(
         bottom: TabBar(tabs: [
           Tab(child: Text("Tedaviler"),icon: Icon(Icons.healing),),
           Tab(child: Text("Aşılar"),icon: Icon(Icons.live_help),),
         ]),
        ),
       body: TabBarView(children: [
         TreatmentListPage(petID:widget.petID),
         Icon(Icons.live_tv)
         
       ])
      ),);
  }
}