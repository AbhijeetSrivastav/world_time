import 'package:flutter/material.dart';
import 'package:worldtime/pages/home.dart';
import 'package:worldtime/pages/loading.dart';
import 'package:worldtime/pages/choose_location.dart';

void main() {
  runApp(MaterialApp(
    //initialRoute is used to declare the default screen of the app
    //it is the alternate of the home property of the material app
    //home property can also be used for the same purpose

    initialRoute: '/',

    //routes is used to move between the screens
    //route works like dictionary in python with routes as key and context as value
    //context locates the current position of the widget in the widget tree
    //on a route as a key and context as value it routes return the class of the screen
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}
