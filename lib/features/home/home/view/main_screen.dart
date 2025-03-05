import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: HomeScreen(),
      items: [
        KFDrawerItem(
          text: const Text('Home', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            _drawerController.close!();
          },
        ),
        KFDrawerItem(
          text: const Text('Settings', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            _drawerController.close!();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KFDrawer(
      controller: _drawerController,
      header: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Menu',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      footer: KFDrawerItem(
        text: const Text('Logout', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.logout, color: Colors.white),
        onPressed: () {},
      ),
      decoration: BoxDecoration(
        color: Colors.orange.shade800,
      ),
    );
  }
}
