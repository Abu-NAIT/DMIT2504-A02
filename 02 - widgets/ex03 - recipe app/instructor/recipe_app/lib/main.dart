import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    const headingStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // like a flexbox!
                              // .stretch alignment means children fill the entire width
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: const Text(
                'My Recipe App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
            Image.asset(
              'assets/images/cool.jpg',
              height: 480,
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // default x-axis align will be centering
                children: [
                  Text(
                    'Ingredients',
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                  Text('- some ingredient'),
                  Text('- some ingredient'),
                  Text('- some ingredient'),
                  Text('- some ingredient'),
                  Text('- some ingredient'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // default x-axis align will be centering
                children: [
                  Text('Instructions',
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                  Text('1. take your cream and behold it'),
                  Text('2. whip it good'),
                  Text('3. dip a strawberry'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

