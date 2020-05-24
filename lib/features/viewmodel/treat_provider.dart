import 'package:flutter/material.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/features/service/treatment_db.dart';

class TreatProvider extends ChangeNotifier {
  getData({@required int petID}) async {
    await sl<TreatmentDB>().fetchTreatments(petID: petID);
    notifyListeners();
  }
}
