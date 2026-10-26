import 'package:flutter/material.dart';

// We'll build our pages as full pages for now (individual Scaffold per page) rather than
// doing an outer skeleton page with inner content just to keep things simple.
class PageTwo extends StatelessWidget {

  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          const Text("Page Two"),

          ElevatedButton(
            onPressed: () {
              // going back is easy: "just pop the last route off the top of the stack and show it"
              // you don't need to know what it is specifically!
              Navigator.of(context).pop();
            },
            child: const Text('Go back to Page One'),
          ),

        ],
      ),
    );
  }

}