import 'package:flutter/material.dart';
import 'package:vetapp/core/view/base/base_state.dart';
import 'package:vetapp/features/view/petviews/pet_dialog.dart';

class PetsCard extends StatefulWidget {
  @override
  _PetsCardState createState() => _PetsCardState();
}

class _PetsCardState extends BaseState<PetsCard> {
 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: dynamicHeight(0.3),
      color: Colors.blueGrey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: insetsAll(0.02),
            child: Align(child: FloatingActionButton(onPressed: ()=>showDialog(context:context,
            child: Container( height: dynamicHeight(0.5), width: dynamicWidth(0.8), child: PetDialog()) 
            ),child: Icon(Icons.add), ),alignment: Alignment.topRight,),
          ),
         Center(child: Text("Şu anda hiç evcil hayvanınız yok !!! \n Sağ üstteki butondan ekleyebilirsiniz..", textAlign: TextAlign.center,))
          // Center(child: FutureBuilder(future:pet,builder: (context,snapshot){
          //   if(snapshot.hasData){
          //     print(snapshot.data.petType);
          //     return Text(snapshot.data.petType);
          //   }
          //   return Center(child: Text("Şu anda hiç evcil hayvanınız yok !!! \n Sağ üstteki butondan ekleyebilirsiniz..", textAlign: TextAlign.center,));
          // },),)
        ],
      ),
    );
  }
}