import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
// run `flutter pub add shared_preferences` to actually install the package into our project first

/*
  shared_preferences creates a local cache that can store key:value data.
  - keys are always strings
  - values can be bool, int, double (a.k.a. 'float' in other langs), string, List<String>
  - we get access to the following abstractions:
     a) getters and setters to read/write (e.g. setBool, getBool; setStringList, getStringList)
     b) remove(key) to reset a key's value to null
     c) clear()     to reset all cached data
  - initial values for all keys (if never specified/written to) is null

  NOTE: local storage & shared prefs won't work on browser emulation
*/


Future<void> main() async {
  // in order to prevent a 'flash' where we might see a very brief light-mode frame since 
  // build() renders an initial frame with _darkMode = false; before running _initState(),
  // we can pull the preference and set it before we even fire runApp()

  // this is just extra material, and it's very unlikely the user would see that frame before the 'right' one is redrawn;
  // and I'm just demoing to give you a sense of edge cases and how to deal with them.
 
  // kind of like the DOMContentLoaded listener in JS, we first want to make sure Flutter is properly initialised first
  WidgetsFlutterBinding.ensureInitialized();
  
  // now, we can get that pref and pass it to the main app
  final prefs = await SharedPreferences.getInstance();
  runApp(MainApp(darkMode: prefs.getBool('darkMode') ?? false));
}

class MainApp extends StatefulWidget {

  final bool darkMode;
  
  const MainApp({super.key, required this.darkMode});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late bool _darkMode = widget.darkMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shared Prefs Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildDarkModeSwitch(),
              const SizedBox(height: 20),
              Text(_darkMode ? 'Dark Mode is ON' : 'Dark Mode is OFF'),
            ],
          ),
        ),
      ),
    );
  }

  SwitchListTile _buildDarkModeSwitch() {
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: _darkMode,
      onChanged: (value) async {
        // I still change state first, to prioritise local re-render ahead of cache i/o
        setState(() {
          _darkMode = value;
        });
        // after doing that, write the new value to the cache
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('darkMode', value);
        // we aren't reading the cache yet, just writing to it whenever we change the setting
      },
    );
  }
}
