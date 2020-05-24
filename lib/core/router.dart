import 'package:flutter/material.dart';
import 'package:vetapp/features/view/homeviews/home_page.dart';
import 'package:vetapp/features/view/homeviews/user_home.dart';
import 'package:vetapp/features/view/homeviews/vet_home.dart';
import 'package:vetapp/features/view/petviews/pet_tab.dart';
import 'package:vetapp/features/view/profileviews/user_profile_page.dart';
import 'package:vetapp/features/view/treatmentviews/treatment_add_page.dart';
import 'package:vetapp/features/view/userviews/user_add_page.dart';
import 'package:vetapp/features/view/userviews/user_edit.dart';
import 'package:vetapp/features/view/vaccineviews/vaccine_add_page.dart';

const String homeRoute = '/home';
const String addVaccine = '/add_vaccine';
const String addTreatment = '/add_treatment';
const String addUser = "/add_user";
const String petTab = "/pet_tab";
const String userProfile = "/user_profile";
const String editProfile = "/edit_profile";

const String userHome = "/userHome";
const String vetHome = "/vetHome";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MyHomePage());
        break;
      case addVaccine:
        return MaterialPageRoute(builder: (_) => VaccineAdd());
        break;
      case addTreatment:
        return MaterialPageRoute(
            builder: (_) => TreatmentAdd(
                  petID: settings.arguments,
                ));
        break;
      case addUser:
        return MaterialPageRoute(builder: (_) => UserAdd());
      case petTab:
        return MaterialPageRoute(
            builder: (_) => PetTab(petID: settings.arguments));
      case userProfile:
        return MaterialPageRoute(builder: (_) => UserProfile());
      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case userHome:
        return MaterialPageRoute(builder: (_) => UserHome());
      case vetHome:
        return MaterialPageRoute(builder: (_) => VetHome());
    }
  }
}
