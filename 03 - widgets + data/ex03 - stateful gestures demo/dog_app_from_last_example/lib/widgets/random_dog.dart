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

  Widget _buildDogImage() {
    // 1. we'll use a SizedBox to control the position of image + button,
    // so that button doesn't jump around the UI while image is loading
    return SizedBox(
      height: 300,
      // ternary gang: conditionally return loading text OR dog image
      child: GestureDetector(
        // One thing I notice: I can spam-tap and the likes will only update when a new dog image arrives.
        // Is this good? Bad? It's a decision! Consider whether you'd want to update for every tap, or just when a new dog arrives, and *why*.
        onTap: () { // this is a callback function: what *should* fire *for* a tap; it's NOT a functionCall()
          // print("got a tap");
          getRandomDogUrl().then( // anyFunc().then( (result) { stuffToRun } ); -> take the result of anyFunc (when it's ready), then run stuff with it
            (url) {
              setState( // still ez
                () {
                  dogImageUrl = url;
                  likes      += 1;
                }
              );
            }
          );
          // print('likes: $likes');
        },
        onLongPress: () { // () {} is equivalent to () => {} in JS
          // print('got a long press');
          getRandomDogUrl().then((url) {
            setState(() {
              dogImageUrl = url;
              dislikes      += 1;
            });
          });
        },
        child: dogImageUrl.isEmpty ? const Text("Loading dog...") : Image.network(dogImageUrl),
      ),
    );
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
        
        _buildDogImage(),

        // 2. another fixed-height box for some spacing
        const SizedBox(height: 16),
        const Text("press image for new dog"),

        DisplayLikes(numLikes: likes),
        DisplayLikes(forDislikes: true, numLikes: dislikes),

      ]
    );

  }

}