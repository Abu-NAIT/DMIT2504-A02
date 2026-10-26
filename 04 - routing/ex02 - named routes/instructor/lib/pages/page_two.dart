import 'package:flutter/material.dart';


class PageTwo extends StatelessWidget {

  const PageTwo({super.key});

  static const excuses = [
    'my cat walked (and peed) all over my keyboard',
    'the bus was late (yes i was on the bus)',
    'i thought it was tomorrow',
    'i thought it was yesterday',
    'my code was working fine before class',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

          for (final excuse in excuses)
            Card(
              child: ListTile(
                title: Text(excuse),
                onTap: () => Navigator.of(context).pop(excuse),
              )
            )

        ],
      ),
    );
  }

}