import 'package:flutter/material.dart';
import 'package:kuis/pages/home_page.dart';
import 'package:kuis/pages/profile_page.dart';

void main() {
  runApp(MainApp());
  print("here");
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _selectedPageIndex = 0;

  final _navigationPages = [MenuPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Toko alat tulis", style: TextStyle(color: Colors.white)),
        ),
        body: _navigationPages[_selectedPageIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedPageIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          indicatorColor: Colors.blue,
          destinations: [
            NavigationDestination(icon: Icon(Icons.flatware), label: "menu"),
            NavigationDestination(icon: Icon(Icons.person), label: "profile"),
          ],
        ),
      ),
    );
  }
}
