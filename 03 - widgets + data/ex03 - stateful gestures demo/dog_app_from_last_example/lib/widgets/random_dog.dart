import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter/material.dart';

import 'display_likes.dart';


class RandomDogImage extends StatefulWidget {
  const RandomDogImage({super.key});

  @override
  State<RandomDogImage> createState() => _RandomDogImageState();
}


class _RandomDogImageState extends State<RandomDogImage> {

  // all three of these are stateful
  String dogImageUrl = '';
  int    likes       = 0; 
  int    dislikes    = 0;

  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = 'https://dog.ceo/api/breeds/image/random';
    var response = await get(Uri.parse(dogEndpoint));
    return await jsonDecode(response.body)['message'];
  }

  Future<void> fetchNewDog() async {

    setState(() { dogImageUrl = ''; });  // reset the dog URL state first
    final url = await getRandomDogUrl(); // get new dog image URL

    if (!mounted) return;                // bail out if component isn't mounted into element tree

    setState(() { dogImageUrl = url; }); // overwrite dog image state

  }

  @override
  void initState() {
    super.initState();    
    fetchNewDog();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        
        // 1. we'll use a SizedBox to control the position of image + button,
        // so that button doesn't jump around the UI while image is loading
        SizedBox(
          height: 300,
          // ternary gang: conditionally return loading text OR dog image
          child: GestureDetector(
            onTap: () { // this is a callback function: what *should* fire *for* a tap; it's NOT a functionCall()
              // print("got a tap");
              setState( // ez
                () { likes += 1; }
              );
              // print('likes: $likes');
              fetchNewDog();
            },
            onLongPress: () { // () {} is equivalent to () => {} in JS
              // print('got a long press');
              setState(
                () { dislikes +=1; }
              );
              fetchNewDog();
            },
            child: dogImageUrl.isEmpty ? const Text("Loading dog...") : Image.network(dogImageUrl),
          ),
        ),
          


        // 2. another fixed-height box for some spacing
        const SizedBox(height: 16),

        const Text("press image for new dog"),

        DisplayLikes(numLikes: likes),
        DisplayLikes(forDislikes: true, numLikes: dislikes),

      ]
    );

  }

}