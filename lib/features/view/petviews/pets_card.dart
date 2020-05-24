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
  @override
  _PetsCardState createState() => _PetsCardState();
}

class _PetsCardState extends BaseState<PetsCard> {
  TextEditingController petType = TextEditingController();
  TextEditingController petYear = TextEditingController();
  @override
  void initState() {
    var user = sl<UserProvider>();
    var pets = sl<PetProvider>();

    PetDB()
        .fetchPet(userName: user.getUser.name)
        .then((value) => pets.addAllPet(value));

    super.initState();
  }

  var user = sl<UserProvider>();
  var pets = sl<PetProvider>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: sl<PetProvider>(),
        child: Consumer<PetProvider>(
          builder: (context, PetProvider treatProvider, ___) {
            return Container(
              height: dynamicHeight(0.3),
              color: Colors.blueGrey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: insetsAll(0.02),
                    child: Align(
                      child: FloatingActionButton(
                        onPressed: () => showDialog(
                            context: context,
                            child: Container(
                                height: dynamicHeight(0.5),
                                width: dynamicWidth(0.8),
                                child: petDialog())),
                        child: Icon(Icons.add),
                      ),
                      alignment: Alignment.topRight,
                    ),
                  ),
                  Center(
                      child: pets.getPetList == null
                          ? Text(
                              "Şu anda hiç evcil hayvanınız yok !!! \n Sağ üstteki butondan ekleyebilirsiniz..",
                              textAlign: TextAlign.center,
                            )
                          : Container(
                              height: dynamicHeight(0.15),
                              child: ListView.builder(
                                  itemCount: pets.getPetList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Card(
                                        margin: insetSymmetric(
                                            width: 0.04, height: 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text("resim gelcek buradalara"),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  pets.getPetList[index]
                                                      .petType,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Text(
                                                  "Yaşı : " +
                                                      pets.getPetList[index]
                                                          .year,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(petTab,
                                              arguments:
                                                  pets.getPetList[index].petID),
                                    );
                                  }),
                            )),
                ],
              ),
            );
          },
        ));
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
                pets.addPet(pet);
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
