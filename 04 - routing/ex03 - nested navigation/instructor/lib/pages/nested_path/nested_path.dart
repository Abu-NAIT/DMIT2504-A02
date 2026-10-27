import 'package:flutter/material.dart';

import 'routes.dart';
// note: this nested path/file/widget holds the information to a bunch of routes for its submodule,
//       rather than eeeeeeverything always being stored in a top-level, global routes.dart


class NestedPathPage extends StatelessWidget {

  const NestedPathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[

            const Text("Welcome to the nested path!"),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(nestedPageOne),
              child: const Text("Nested Page One")
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(nestedPageTwo),
              child: const Text("Nested Page Two")
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(nestedPageThree),
              child: const Text("Nested Page Three")
            ),

          ],
        ),
      ),
    );
  }

}