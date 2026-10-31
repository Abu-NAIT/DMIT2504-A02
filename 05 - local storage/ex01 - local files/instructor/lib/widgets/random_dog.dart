import 'dart:io';  // for i/o with terminal and/or files
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';  // will have to `flutter pub add path_provider` in terminal in project root

/* 
    Step 1: implementing local file storage (goal: save dog pic to a file)

    We'll be using the `path_provider` plugin (https://pub.dev/packages/path_provider),
    which makes it easier for us to interact with filesystems (and not have to write manual code for each platform).

    Some abstractions it provides:
     - getTemporaryDirectory()             -> lets us create a temp dir for writing temporary files
     - getApplicationDocumentsDirectory()  -> access to a persistent local folder for storage, belonging to this app
     - getApplicationSupportDirectory()    -> internal app files, kept but not meant for user (kind of like AppData folders in Windows)
     - getDownloadsDirectory()             -> guess lol

    The reason the plugin gives us all these fairly specific abstractions is that all of them live/behave very differently
    depending on e.g. Windows, mobile, web, etc. so this just lets us write one high-level abstraction once, which will compile
    down to platform-specific implementation via this plugin/library.

    NOTE: Not all of these are available on every platform (esp. browser); see the chart on the plugin website for specifics.
*/

class RandomDogImage extends StatefulWidget {
  const RandomDogImage({super.key});

  @override
  State<RandomDogImage> createState() => _RandomDogImageState();
}

class _RandomDogImageState extends State<RandomDogImage> {
  String dogImageUrl = '';
  int likes = 0;
  int dislikes = 0;

  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = 'https://dog.ceo/api/breeds/image/random';
    var response = await get(Uri.parse(dogEndpoint));
    return await jsonDecode(response.body)['message'];
  }

  // we'll write two methods, one to return a file based on a path and another to save dog as local img
  // they'll both be async because they rely on async-fetching the dog image in the first place
  Future<File> _dogFile() async {
    // when called will create an empty dog.jpg in the platform's tempdir path
    final tempDir = await getTemporaryDirectory();
    return File('${tempDir.path}/dog.jpg');
    // assumes we're saving some dog image as 'dog.jpg'
  }

  Future<void> _saveDogImage(String url) async {
    final response = await get(Uri.parse(url));
    final file     = await _dogFile();  // creates that empty file {tempdir}/dog.jpg
    await file.writeAsBytes(response.bodyBytes);
    debugPrint('Saved dog pic to ${file.path}');
  }

  // common pattern in mobile apps: save app state locally on close, load local app state on reopen, overwrite with remote data as necessary
  // therefore, let's start our app by loading from our local file if there is one, and if not, fetching a new dog
  Future<void> _loadInitialDog() async {
    final file = await _dogFile(); // this may be null if it doesn't exist
    if (await file.exists()) {
      setState(() {
        dogImageUrl = file.path; // we'll need to change our rendering implementation to use Image.file instead of Image.network if our initial dog is local
      });
    } else {
      final url = await getRandomDogUrl();
      setState(() { dogImageUrl = url; });
      _saveDogImage(url);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInitialDog();  // initial state is also now very clean!
  }

  Widget _buildDogImage() {
    Widget childWidget;

    if (dogImageUrl.isNotEmpty) {
      // Image.network already downloads the image as bytes from URL to show the pic
      // Whyyyyy do we then need to re-download the image?
      // unfortunately, Image.network doesn't return, store, or otherwise give us access to the bytes
      // Therefore, (for now) we ask for the image a second time.

      // How could we solve this? Probably a workflow where you a) request the image,
      // b) save it as bytes in a tempfile, c) and also render from that tempfile
      
      // now, I need to render either from network path or from a file.
      // just for simplicity's sake, I'm going to check if my path starts with 'http' to determine that
      dogImageUrl.startsWith('http')
        ? childWidget = Image.network(dogImageUrl)
        : childWidget = Image.file(File(dogImageUrl));
        // when doing Image.file, you have to pass the actual file as bytes, not just the path to it
    } else {
      childWidget = const CircularProgressIndicator();
    }

    return GestureDetector(
      onTap: () {
        getRandomDogUrl().then((url) {
          _setDogImageUrl(url, true);
        });
      },
      onLongPress: () {
        getRandomDogUrl().then((url) {
          _setDogImageUrl(url, false);
        });
      },
      child: childWidget,
    );
  }

  void _setDogImageUrl(String url, bool liked) {
    setState(() {
      dogImageUrl = url;
      liked ? likes += 1 : dislikes += 1;
    });
    _saveDogImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildDogImage(),
        LikeText(like: true, number: likes),
        LikeText(like: false, number: dislikes),
      ],
    );
  }
}

class LikeText extends StatelessWidget {
  /// true to render "Likes: " and false to render "Dislikes: "
  final bool like;
  final int number;

  const LikeText({this.like = true, this.number = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
      ),
      child: Row(
        children: <Widget>[
          Text(
            like ? "Likes: " : "Dislikes: ",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$number',
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
