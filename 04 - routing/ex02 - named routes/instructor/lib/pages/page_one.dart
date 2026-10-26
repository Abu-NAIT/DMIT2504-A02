import 'package:flutter/material.dart';


class PageOne extends StatefulWidget {

  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();

}



class _PageOneState extends State<PageOne> {

  late String data = ''; // this is a stateful value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          const Text("You have shown up to class with underwear on your head.\nPlease explain yourself."),

          const SizedBox(height: 48),

          ElevatedButton(
            onPressed: () async {
              // General idea: I can return data from where I'm routing to, capture it here, have it ready when user comes back.
              // An enormous amount of engineering/building for mobile involves making data/UI ready ahead of time in order to make the experience
              // feel as instant/snappy as possible.
              final excuse = await Navigator.of(context).pushNamed('/page-two') as String?; // the data I'm expecting to be returned back is a string

              setState(() { 
                data = excuse ?? "No excuse given; bold strategy."; 
              });
            },
            child: const Text('Select an excuse.'),
          ),

          Text(data.isEmpty ? "Awaiting excuse..." : data),

        ],
      ),
    );
  }

}