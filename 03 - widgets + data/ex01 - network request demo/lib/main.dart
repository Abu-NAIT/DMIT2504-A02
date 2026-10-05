import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

///TODO: create a stateful widget, override initState to fetch the initial
/// dog url. NOTE: will need to ensure a callback is used to be certain the
/// widget has been mounted before calling setState().

Future<void> main() async {
  // hot reload  ('r' in flutter console) will *not* rerun main()
  // hot restart ('R', i.e. shift+r ) will.
  // final response = await get(
  //   Uri.parse('https://dog.ceo/api/breeds/image/random')
  // );
  // print(response.body); // body is a JSON payload

  // final data = jsonDecode(response.body);
  // print(data);
  // print(data['message']);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.network('https://images.dog.ceo/breeds/spaniel-blenheim/n02086646_589.jpg'),
        ),
      ),
    );
  }
}

class RandomDogImage extends StatelessWidget {

  const RandomDogImage({super.key})

  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = 'https://dog.ceo/api/breeds/image/random';
    var response      = await get(Uri.parse(dogEndpoint));
    return jsonDecode(response.body)['message'];
  }

  @override
  Widget build(BuildContext context) {
    // I am not displaying the dog yet
    return const Placeholder();
  }
}

/*
String dogImageUrl = '';

Future<void> main() async {
  dogImageUrl = await RandomDogImage.getRandomDogUrl();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: RandomDogImage(),
        ),
      ),
    );
  }
}

class RandomDogImage extends StatelessWidget {
  const RandomDogImage({super.key});

  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = 'https://dog.ceo/api/breeds/image/random';
    var response = await get(Uri.parse(dogEndpoint));
    return await jsonDecode(response.body)['message'];
  }

  @override
  build(BuildContext context) {
    return Image.network(dogImageUrl);
  }
}
*/
