

import 'package:flutter/material.dart';
import 'package:vetapp/features/view/homeview/home_page.dart';
import 'package:vetapp/features/view/vaccineviews/vaccine_add_page.dart';

const String homeRoute = '/home';
const String addVaccine = '/add_vaccine';
class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (_)=>MyHomePage());
        break;
      case addVaccine: 
        return MaterialPageRoute(builder: (_)=>VaccineAdd());
        break;
    }
  } 

}