import 'package:flutter/material.dart';
import 'package:rave_fm_app/src/homescreen/videos_screen.dart';
import 'package:rave_fm_app/src/live_radio/live_radio_screen.dart';
import 'package:rave_fm_app/src/settings/settings_controller.dart';
import 'package:rave_fm_app/src/settings/settings_view.dart';

class HomeScreenWidget extends StatefulWidget {
  static const routeName = '/';
  const HomeScreenWidget({super.key, required this.controller});
  final SettingsController controller;
  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  int _selectedIndex = 0;
 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     final  List<Widget> widgetOptions = <Widget>[
   const VideosScreen(),
    const LiveRadioScreen(),
    SettingsView(controller:widget.controller),
  ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('WSTV'),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            label: 'Live Radio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
