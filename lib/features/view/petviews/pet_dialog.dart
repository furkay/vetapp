import 'package:flutter/material.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/core/view/widget/TextFormField/build_custom_field.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';
import 'package:vetapp/features/model/pet.dart';
import 'package:vetapp/features/service/pet_db.dart';

class PetDialog extends StatefulWidget {
  PetDialog({Key key}) : super(key: key);

  @override
  _PetDialogState createState() => _PetDialogState();
}

class _PetDialogState extends BaseState<PetDialog> {
  TextEditingController petType = TextEditingController();
  TextEditingController petYear = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

    return AlertDialog(
      title: Text("Evcil Hayvan Bilgileri"),
      content: Container(
        height: dynamicHeight(0.25),
        child: Column(
          children: children,
        ),
      ),
      actions: <Widget>[
        RaisedButton.icon(
            onPressed: () {
              PetDB()
                  .addPet(Pet(petType: petType.text, year: petYear.text))
                  .then((value) {
                Navigator.of(context).pop();
              });
            },
            icon: Icon(Icons.save),
            label: Text("Kaydet"))
      ],
    );
  }
}
