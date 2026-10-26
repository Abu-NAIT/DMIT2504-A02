import 'package:flutter/material.dart';

/* 
  Our goal: instead of having components directly aware of one another,
            we want to centralise routing responsibility to some logic layer
            or top-level component.import
*/
import 'pages/page_one.dart';
import 'pages/page_two.dart';
// still a little icky, but at least awareness of components happens in one go.


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':         (context) => const PageOne(),
        '/page-two': (context) => const PageTwo(),  // leading slash for absolute routes, none for relative routes (i.e. appended to existing path)
      }
    );
  }
}
