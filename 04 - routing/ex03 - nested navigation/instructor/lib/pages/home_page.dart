import 'package:flutter/material.dart';

import '../routes.dart';
// 1. anything that wants to route to stuff just has to import a routes table, NOT actual widgets
// 2. let's say subsections of our app have a ton of routes; we can make that submodule do
//    its own internal routing and our top-level routing stays clean

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("homepage")),
      body: const Center(child: Text("This is a homepage if you even care")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* You'll notice both this & nested_path's internal routing both call a
             Navigator.of(context) -- this call returns the *closest* Navigator above context
             in the element tree. So, when we're in nested_path pages, that would be its own 
             internal router, whereas when we're in the homepage, that will find the Navigator from our main.dart.
          */
          Navigator.of(context).pushNamed(nestedPathRoute);
        },
        child: const Icon(Icons.device_thermostat)
      ),
    );

  }

}