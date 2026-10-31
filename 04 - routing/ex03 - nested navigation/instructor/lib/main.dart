import 'package:flutter/material.dart';

import "routes.dart";
import "pages/home_page.dart";
import "pages/nested_path/nested_path_manager.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Let's say I want additional things to happen/contextualise
      // my routing, e.g. app-level settings being (re)applied, etc.
      // I can use onGenerateRoute instead of a static routes table
      // and write all that logic in as necessary.

      // TLDR: If we go from a simple lookup table to a function, 
      //       we have more control over firing additional behaviour for all / specific routes.
      onGenerateRoute: (settings) {

        Widget page;

        // part A: map intended route to a widget, but also let us fire other logic as well
        // switch case(A, B, C, D, E, ..., default)   is like if-elif-elif-elif-elif-elif-...-else
        switch (settings.name) {
          case homeRoute:
            page = const HomePage();
            break;
          case nestedPathRoute:
            page = const NestedPathManager();
            break;
          default:
            throw Exception('Unknown route: ${settings.name}');
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) => page,
          settings: settings,
        );

      }
    );
  }
}
