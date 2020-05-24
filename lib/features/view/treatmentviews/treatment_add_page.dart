import 'package:flutter/material.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/core/view/widget/TextFormField/build_custom_field.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';
import 'package:vetapp/features/model/treatment.dart';
import 'package:vetapp/features/service/treatment_db.dart';
import 'package:vetapp/features/viewmodel/treat_provider.dart';

class TreatmentAdd extends StatefulWidget {
  final int petID;
  TreatmentAdd({@required this.petID});
  @override
  _TreatmentAddState createState() => _TreatmentAddState();
}

class _TreatmentAddState extends BaseState<TreatmentAdd> {
  TextEditingController treatmentName = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController medicine = TextEditingController();
  @override
  void dispose() {
    //sl<TreatmentDB>().fetchTreatments(petID: widget.petID);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TextField Create

    List<TextFormFieldObject> fields = [
      TextFormFieldObject(
          hintText: "Tedavi Adı",
          icon: Icons.colorize,
          controller: treatmentName),
      TextFormFieldObject(
          hintText: "İlaç Adı", icon: Icons.colorize, controller: medicine),
      TextFormFieldObject(
          hintText: "Tedavi Tarihi", icon: Icons.date_range, controller: date),
    ];

    List<Widget> children = [];
    fields.forEach((element) {
      children.add(
          buildTextFormField(field: element, padding: insetHorizontal(0.2)));
    });

    //end

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: dynamicHeight(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                TreatmentDB()
                    .addTreatment(Treatment(
                        medicineNames: medicine.text,
                        petID: widget.petID,
                        treatmentDate: date.text,
                        treatmentName: treatmentName.text))
                    .then((value) async {
                  // await Provider.of<TreatProvider>(context)
                  //     .getData(petID: widget.petID);
                  sl<TreatProvider>().getData(petID: widget.petID);
                  Navigator.of(context).pop();
                });
              },
              icon: Icon(Icons.send),
              label: Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}
