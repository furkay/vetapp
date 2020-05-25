import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/features/service/vaccine_db.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';
import 'package:vetapp/features/viewmodel/vaccine_provider.dart';

class VaccineListPage extends StatefulWidget {
  final String userName;
  final int petID;
  VaccineListPage({@required this.petID, this.userName});
  @override
  _VaccineListPageState createState() => _VaccineListPageState();
}

class _VaccineListPageState extends BaseState<VaccineListPage> {
  var getVaccine = sl<VaccineDB>();
  var vaccineProvider = sl<VaccineProvider>();
  var user = sl<UserProvider>();
  bool loading = false;
  getData() async {
    setState(() {
      loading = true;
    });
    await vaccineProvider.getData(petID: widget.petID);
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
        value: sl<VaccineProvider>(),
        child: Consumer<VaccineProvider>(
            builder: (context, VaccineProvider vaccineProvider, ___) {
          return Container(
              child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Uygulanan Aşılar",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: insetsAll(0.02),
                      child: Visibility(
                        visible: widget.userName == null ? false : true,
                        //user.getUser.level == "Uye" ? false : true,
                        child: FloatingActionButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(addVaccine, arguments: widget.petID),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: insetSymmetric(width: 0.04, height: 0.02),
                decoration: BoxDecoration(
                    color: Color(0xFFefefef),
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
                                    "Aşı Adı",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Tarih",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Visibility(
                                    visible:
                                        widget.userName == null ? false : true,
                                    child:
                                        Expanded(flex: 1, child: SizedBox())),
                              ],
                            ),
                          ),
                          Container(
                            height: dynamicHeight(0.5),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: getVaccine.globalVaccineList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: insetSymmetric(
                                        width: 0.04, height: 0.011),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              getVaccine
                                                  .globalVaccineList[index]
                                                  .vaccineName,
                                              style: TextStyle(fontSize: 14),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              getVaccine
                                                  .globalVaccineList[index]
                                                  .vaccineDate,
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
                                              child: Padding(
                                                padding: insetsAll(0.02),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    VaccineDB().deleteVaccine(
                                                        getVaccine
                                                            .globalVaccineList[
                                                                index]
                                                            .vaccineName,
                                                        widget.petID);
                                                    sl<VaccineProvider>()
                                                        .getData(
                                                            petID:
                                                                widget.petID);
                                                  },
                                                  child: CircleAvatar(
                                                    child: Icon(Icons.delete),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
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
