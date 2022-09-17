import 'package:flutter/material.dart';
import 'package:rave_fm_app/src/live_radio/live_radio_screen.dart';
import 'package:rave_fm_app/src/live_tv/live_tv_screen.dart';
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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     final  List<Widget> widgetOptions = <Widget>[
    const Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    const LiveTvScreen(),
    const LiveRadioScreen(),
    SettingsView(controller:widget.controller),
  ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('WSTV'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SettingsView.routeName),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live TV',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            label: 'Live Radio',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
