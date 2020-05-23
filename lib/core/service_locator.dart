import 'package:get_it/get_it.dart';
import 'package:vetapp/features/model/user.dart';
import 'package:vetapp/features/service/treatment_db.dart';
import 'package:vetapp/features/service/user_db.dart';
import 'package:vetapp/features/viewmodel/treat_provider.dart';

var sl = GetIt.I;

Future setupLocator() async {
  sl.registerSingleton<TreatmentDB>(TreatmentDB());
  sl.registerSingleton<TreatProvider>(TreatProvider());
  sl.registerSingleton<UserDB>(UserDB());
}
