import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/features/service/treatment_db.dart';
import 'package:vetapp/features/viewmodel/treat_provider.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';

class TreatmentListPage extends StatefulWidget {
  final int petID;
  final String userName;
  TreatmentListPage({@required this.petID, this.userName});
  @override
  _TreatmentListPageState createState() => _TreatmentListPageState();
}

class _TreatmentListPageState extends BaseState<TreatmentListPage> {
  var getTreat = sl<TreatmentDB>();
  var treatProvider = sl<TreatProvider>();
  var user = sl<UserProvider>();
  bool loading = false;
  getData() async {
    setState(() {
      loading = true;
    });
    await treatProvider.getData(petID: widget.petID);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: sl<TreatProvider>(),
        child: Consumer<TreatProvider>(
            builder: (context, TreatProvider treatProvider, ___) {
          return Container(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Uygulanan Tedaviler",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: insetsAll(0.01),
                    child: Visibility(
                      visible: widget.userName == null ? false : true,
                      child: Align(
                        child: FloatingActionButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(addTreatment, arguments: widget.petID),
                          child: Icon(Icons.add),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: insetSymmetric(width: 0.04, height: 0.02),
                decoration: BoxDecoration(
                    color: Color(0xffefefef),
                    borderRadius: BorderRadius.circular(5)),
                
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          margin: insetSymmetric(width: 0.04, height: 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Tedavi Adı",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "İlaç Adı",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Tarih",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                        ),
                        Container(
                          height: dynamicHeight(0.5),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: getTreat.globalTreatments.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: insetSymmetric(
                                      width: 0.04, height: 0.011),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            getTreat.globalTreatments[index]
                                                .treatmentName,
                                            style: TextStyle(fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            getTreat.globalTreatments[index]
                                                .medicineNames,
                                            style: TextStyle(fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            getTreat.globalTreatments[index]
                                                .treatmentDate,
                                            style: TextStyle(fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Visibility(
                                          visible: widget.userName == null
                                              ? false
                                              : true,
                                          child: Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                TreatmentDB().deleteTreatment(
                                                    getTreat
                                                        .globalTreatments[
                                                            index]
                                                        .treatmentName,
                                                    widget.petID);
                                                sl<TreatProvider>().getData(
                                                    petID: widget.petID);
                                              },
                                              child: CircleAvatar(
                                                child: Icon(Icons.delete),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
              ),
            ],
          ));
        }));
  }
}
