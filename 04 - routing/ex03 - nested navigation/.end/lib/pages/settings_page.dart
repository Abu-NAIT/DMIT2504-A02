import 'package:flutter/material.dart';
import 'package:week_05_nested_navigation/pages/settings/routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Settings Page'),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(settingsOption1Route),
              child: const Text('Option 1'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(settingsOption2Route),
              child: const Text('Option 2'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(settingsOption3Route),
              child: const Text('Option 3'),
            ),
          ],
        ),
      ),
    );
  }
}
