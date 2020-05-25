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
            children: <Widget>[
              Row(
                children: <Widget>[
                  Spacer(),
                  Expanded(
                    child: Text(
                      "Uygulanan Uygulamalar",
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: insetsAll(0.01),
                      child: Visibility(
                        visible: widget.userName == null ? false : true,
                        child: Align(
                          child: FloatingActionButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                                addTreatment,
                                arguments: widget.petID),
                            child: Icon(Icons.add),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: insetSymmetric(width: 0.04, height: 0.02),
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5)),
                height: dynamicHeight(0.5),
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: getTreat.globalTreatments.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: insetSymmetric(width: 0.04, height: 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        getTreat.globalTreatments[index]
                                            .treatmentName,
                                        style: TextStyle(fontSize: 25),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        getTreat.globalTreatments[index]
                                            .medicineNames,
                                        style: TextStyle(fontSize: 25),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        getTreat.globalTreatments[index]
                                            .treatmentDate,
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: insetsAll(0.02),
                                      child: Visibility(
                                        visible: widget.userName == null
                                            ? false
                                            : true,
                                        child: GestureDetector(
                                          onTap: () {
                                            TreatmentDB().deleteTreatment(
                                                getTreat.globalTreatments[index]
                                                    .treatmentName,
                                                widget.petID);
                                            sl<TreatProvider>()
                                                .getData(petID: widget.petID);
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.delete),
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          );
                        }),
              ),
            ],
          ));
        }));
  }
}
