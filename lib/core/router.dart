

import 'package:flutter/material.dart';
import 'package:vetapp/features/view/homeviews/home_page.dart';
import 'package:vetapp/features/view/treatmentviews/treatment_add_page.dart';
import 'package:vetapp/features/view/vaccineviews/vaccine_add_page.dart';

const String homeRoute = '/home';
const String addVaccine = '/add_vaccine';
const String addTreatment = '/add_treatment';
class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (_)=>MyHomePage());
        break;
      case addVaccine: 
        return MaterialPageRoute(builder: (_)=>VaccineAdd());
        break;
      case addTreatment: 
        return MaterialPageRoute(builder: (_)=>TreatmentAdd());
        break;  
    }
  } 

}