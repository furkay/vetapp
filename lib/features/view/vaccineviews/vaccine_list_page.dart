import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/features/service/vaccine_db.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';
import 'package:vetapp/features/viewmodel/vaccine_provider.dart';

class VaccineListPage extends StatefulWidget {
  final int petID;
  VaccineListPage({@required this.petID});
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
              Visibility(
                visible: true,
                //user.getUser.level == "Uye" ? false : true,
                child: Padding(
                  padding: insetsAll(0.01),
                  child: Align(
                    child: FloatingActionButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(addVaccine, arguments: widget.petID),
                      child: Icon(Icons.add),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
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
                        itemCount: getVaccine.globalVaccineList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              VaccineDB().deleteVaccine(
                                  getVaccine
                                      .globalVaccineList[index].vaccineName,
                                  widget.petID);
                              sl<VaccineProvider>()
                                  .getData(petID: widget.petID);
                            },
                            child: ListTile(
                              title: Text(getVaccine
                                  .globalVaccineList[index].vaccineName),
                              subtitle: Text(getVaccine
                                  .globalVaccineList[index].vaccineDate),
                            ),
                          );
                        }),
              ),
            ],
          ));
        }));
  }
}
