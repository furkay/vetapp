

import 'package:flutter/material.dart';
import 'package:vetapp/features/view/homeview/home_page.dart';

const String homeRoute = '/home';
//const String listPage = '/list';
class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (_)=>MyHomePage());
        break;
      // case listPage: 
      //   return MaterialPageRoute(builder: (_)=>TestApp());
      //   break;
    }
  } 

}