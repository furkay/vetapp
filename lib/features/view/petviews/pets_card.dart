import 'package:flutter/material.dart';
import 'package:vetapp/core/router.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/core/view/widget/TextFormField/build_custom_field.dart';
import 'package:vetapp/core/view/widget/TextFormField/text_form_field_object.dart';
import 'package:vetapp/features/model/pet.dart';
import 'package:vetapp/features/service/pet_db.dart';

class PetsCard extends StatefulWidget {
  @override
  _PetsCardState createState() => _PetsCardState();
}

class _PetsCardState extends BaseState<PetsCard> {
  TextEditingController petType = TextEditingController();
  TextEditingController petYear = TextEditingController();
  @override
  void initState() {
    PetDB().fetchPet().then((value) => model = value);
  
    super.initState();
  }

  var model;
  @override
  Widget build(BuildContext context) {
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
          FutureBuilder(future: PetDB().fetchPet(),builder: (context,snapshot){
            if(snapshot.hasData){
              return Center(child:GestureDetector(
                      child: Card(

                        margin: insetSymmetric(width: 0.04, height: 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("resim gelcek buradalara"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text(model.petType, style: TextStyle(fontSize: 20),),
                              Text( "Yaşı : "+ model.year,style: TextStyle(fontSize: 16),)
                            ],)
                            
                          ],
                        ),
                      ),
                     onTap: ()=>Navigator.of(context).pushNamed(petTab, arguments:model.petID),
                    ));
            }
            return Center(
              child: model == null
                  ? Text(
                      "Şu anda hiç evcil hayvanınız yok !!! \n Sağ üstteki butondan ekleyebilirsiniz..",
                      textAlign: TextAlign.center,
                    )
                  : GestureDetector(
                      child: Card(

                        margin: insetSymmetric(width: 0.04, height: 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("resim gelcek buradalara"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text(model.petType, style: TextStyle(fontSize: 20),),
                              Text( "Yaşı : "+ model.year,style: TextStyle(fontSize: 16),)
                            ],)
                            
                          ],
                        ),
                      ),
                     onTap: ()=>Navigator.of(context).pushNamed(petTab, arguments:model.petID),
                    ));
          })


         
        ],
      ),
    );
  }

  AlertDialog petDialog() {
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
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      actions: <Widget>[
        RaisedButton.icon(
            onPressed: () {
              Pet pet = Pet(petType: petType.text, year: petYear.text);
              PetDB().addPet(pet).then((value) {
                Navigator.of(context).pop();
              });

              setState(() {
                model = pet;
              });
            },
            icon: Icon(Icons.save),
            label: Text("Kaydet"))
      ],
    );
  }
}
