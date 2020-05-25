import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/core/view/widget/TextFormField/build_custom_field.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';
import 'package:vetapp/features/model/pet.dart';
import 'package:vetapp/features/service/pet_db.dart';
import 'package:vetapp/features/viewmodel/pet_provider.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';

class PetsCard extends StatefulWidget {
  final String userName;
  PetsCard({this.userName});
  @override
  _PetsCardState createState() => _PetsCardState();
}

class _PetsCardState extends BaseState<PetsCard> {
  TextEditingController petType = TextEditingController();
  TextEditingController petYear = TextEditingController();
  @override
  void initState() {
    print(widget.userName);
    getData();
    super.initState();
  }

  var user = sl<UserProvider>();
  var petsProvider = sl<PetProvider>();
  var getPets = sl<PetDB>();

  bool loading = false;
  getData() async {
    setState(() {
      loading = true;
    });
    await petsProvider.getData(widget.userName ?? user.getUser.name);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: sl<PetProvider>(),
        child: Consumer<PetProvider>(
          builder: (context, PetProvider petProvider, ___) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Pet Listesi",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFE6E6E6),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Spacer(),
                          Expanded(
                            child: Visibility(
                              visible:
                                  user.getUser.level == "Uye" ? true : false,
                              child: Padding(
                                padding: insetsAll(0.02),
                                child: FloatingActionButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      child: Container(
                                          height: dynamicHeight(0.5),
                                          width: dynamicWidth(0.8),
                                          child: petDialog())),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                          child: getPets.globalPets == null
                              ? Text(
                                  "Şu anda hiç evcil hayvanınız yok !!! \n Sağ üstteki butondan ekleyebilirsiniz..",
                                  textAlign: TextAlign.center,
                                )
                              : Container(
                                  height: dynamicHeight(0.35),
                                  child: buildListView(),
                                )),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: getPets.globalPets.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              margin: insetSymmetric(width: 0.03, height: 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Image.asset(
                    "assets/cat.png",
                    height: dynamicHeight(0.08),
                    width: dynamicHeight(0.08),
                  )),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Pet Tipi",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                getPets.globalPets[index].petType,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Yaş",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                getPets.globalPets[index].year,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.userName == null ? true : false,
                    child: Expanded(
                      flex: 1,
                      child: Padding(
                        padding: insetsAll(0.02),
                        child: GestureDetector(
                          onTap: () {
                            PetDB().deletePet(getPets.globalPets[index].petID);
                            sl<PetProvider>()
                                .getData(getPets.globalPets[index].userName);
                            // setState(() {});
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.delete),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              List list = [getPets.globalPets[index].petID, widget.userName];
              Navigator.of(context).pushNamed(petTab, arguments: list);
            },
          );
        });
  }

  AlertDialog petDialog() {
    var user = sl<UserProvider>();

    List<TextFormFieldObject> fields = [
      TextFormFieldObject(
          hintText: "Evcil Hayvan Tipi",
          icon: Icons.colorize,
          controller: petType),
      TextFormFieldObject(
          hintText: "Doğum Tarihi", icon: Icons.colorize, controller: petYear)
    ];
    List<Widget> children = [];
    fields.forEach((element) {
      children.add(
          buildTextFormField(field: element, padding: insetHorizontal(0.01)));
    });

    //print(user.getUser.userID);
    return AlertDialog(
      title: Text("Evcil Hayvan Bilgileri"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      actions: <Widget>[
        RaisedButton.icon(
            onPressed: () {
              Pet pet = Pet(
                  petType: petType.text,
                  year: petYear.text,
                  userName: user.getUser.name);
              PetDB().addPet(pet).then((value) {
                sl<PetProvider>().getData(user.getUser.name);
                Navigator.of(context).pop();
              });

              setState(() {});
            },
            icon: Icon(Icons.save),
            label: Text("Kaydet"))
      ],
    );
  }
}
