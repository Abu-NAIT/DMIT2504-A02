import 'package:flutter/material.dart';
import 'package:week_05_nested_navigation/pages/settings/option1_page.dart';
import 'package:week_05_nested_navigation/pages/settings/option2_page.dart';
import 'package:week_05_nested_navigation/pages/settings/option3_page.dart';
import 'package:week_05_nested_navigation/pages/settings/routes.dart';
import 'package:week_05_nested_navigation/pages/settings_page.dart';

class SettingsManager extends StatefulWidget {
  final String optionPageRoute;

  const SettingsManager({required this.optionPageRoute, super.key});

  @override
  State<SettingsManager> createState() => _SettingsManagerState();
}

class _SettingsManagerState extends State<SettingsManager> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget.optionPageRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    Widget page = const SizedBox.shrink();

    switch (settings.name) {
      case settingsHomeRoute:
        page = const SettingsPage();
        break;
      case settingsOption1Route:
        page = const Option1Page();
        break;
      case settingsOption2Route:
        page = const Option2Page();
        break;
      case settingsOption3Route:
        page = const Option3Page();
        break;
    }

    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('App Settings'),
      // The following was added to override the default back button
      // behavior of the AppBar. We need to pop from the local navigator,
      // not the global one.
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (_navigatorKey.currentState!.canPop()) {
            _navigatorKey.currentState!.pop();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
