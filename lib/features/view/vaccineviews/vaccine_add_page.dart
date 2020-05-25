import 'package:flutter/material.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/core/view/widget/TextFormField/build_custom_field.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';
import 'package:vetapp/features/model/vaccine.dart';
import 'package:vetapp/features/service/vaccine_db.dart';
import 'package:vetapp/features/viewmodel/vaccine_provider.dart';

class VaccineAdd extends StatefulWidget {
  final int petID;
  VaccineAdd({@required this.petID});
  @override
  _VaccineAddState createState() => _VaccineAddState();
}

class _VaccineAddState extends BaseState<VaccineAdd> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<TextFormFieldObject> fields = [
      TextFormFieldObject(
          hintText: "Aşı Adı", icon: Icons.colorize, controller: name),
      TextFormFieldObject(
          hintText: "Aşı Yapılan Tarih",
          icon: Icons.date_range,
          controller: date),
    ];

    List<Widget> children = [];
    fields.forEach((element) {
      children.add(
          buildTextFormField(field: element, padding: insetHorizontal(0.2)));
    });

    //end

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003D78),
        centerTitle: true,
        title: Text("Aşı Ekle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: Image(image: AssetImage("assets/vaccine.png"),height: dynamicHeight(.2),),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: RaisedButton.icon(
                color: Color(0xFF003D78),
                onPressed: () {
                  VaccineDB()
                      .addVaccine(Vaccine(
                          petID: widget.petID,
                          vaccineName: name.text,
                          vaccineDate: date.text))
                      .then((value) async {
                    sl<VaccineProvider>().getData(petID: widget.petID);
                    Navigator.of(context).pop();
                  });
                },
                icon: Icon(Icons.send, color: Colors.white),
                label: Text("Kaydet", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
