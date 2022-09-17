import 'package:flutter/material.dart';
import 'package:rave_fm_app/src/app.dart';
import 'package:rave_fm_app/src/settings/settings_controller.dart';
import 'package:splashscreen/splashscreen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key, required this.controller}) : super(key: key);
  final SettingsController controller;
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 14,
      navigateAfterSeconds:  MyApp(
        settingsController: widget.controller,
      ),
      title: const Text(
        'WSTV',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
    );
  }
}
