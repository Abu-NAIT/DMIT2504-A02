import 'package:flutter/material.dart';

import 'page_two.dart';
// this is objectively terrible/yucky: components should never know about each other.

// imagine if we had to route between 10 different components!
// each of them would need *their own* references & logic for referencing to EACH other one.


class PageOne extends StatelessWidget {

  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          const Text("Page One"),

          ElevatedButton(
            onPressed: () {
              // routing is a stack: first in, first out.
              // push something on top of the stack; pop something off of the top of the stack.
              // the Navigator (routing engine) holds the stack.
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PageTwo()
                )
              );
            },
            child: const Text('Go to Page Two'),
          ),

        ],
      ),
    );
  }

}