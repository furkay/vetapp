import 'package:flutter/material.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/features/service/vaccine_db.dart';

class VaccineProvider extends ChangeNotifier{
 
  getData({@required int petID}) async{
    await sl<VaccineDB>().fetchVaccine(petID: petID);
    notifyListeners();
  }
  
}