import 'package:get_it/get_it.dart';
import 'package:vetapp/features/service/pet_db.dart';
import 'package:vetapp/features/service/treatment_db.dart';
import 'package:vetapp/features/service/vaccine_db.dart';
import 'package:vetapp/features/viewmodel/pet_provider.dart';
import 'package:vetapp/features/viewmodel/treat_provider.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';
import 'package:vetapp/features/viewmodel/vaccine_provider.dart';

var sl = GetIt.I;

Future setupLocator() async {
  sl.registerSingleton<TreatmentDB>(TreatmentDB());
  sl.registerSingleton<VaccineDB>(VaccineDB());
  sl.registerSingleton<PetDB>(PetDB());
  sl.registerSingleton<TreatProvider>(TreatProvider());
  sl.registerSingleton<UserProvider>(UserProvider());
  sl.registerSingleton<PetProvider>(PetProvider());
  sl.registerSingleton<VaccineProvider>(VaccineProvider());
}
