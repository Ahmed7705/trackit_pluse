import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackit_pluse/screen/SignUpPage.dart';
import 'package:trackit_pluse/screen/ReportsPage.dart';
import 'package:trackit_pluse/screen/UserAccount.dart';
import 'package:trackit_pluse/widgets/rounded_container_widget.dart';

import '../SettingsPages/Settings.dart';
import '../screen/Devices.dart';
import '../screen/HomePage.dart';
import 'CustomAppBar.dart';
import '../screen/UserProfile.dart';
import '../models/CustomNavigationDrawer.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.user}) : super(key: key);

final User? user;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    Padding(
      padding: EdgeInsets.only(top: 0),
      child: HomePage(),
    ),
    Padding(
      padding: EdgeInsets.only(top: 0),
      child: ReportsPage(),
    ),
    SettingsPage(),
    Padding(
      padding: EdgeInsets.only(top: 0),
      child: Devices(),
    ),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Icon icon2 = const Icon(Icons.fiber_new, color: Colors.amber, size: 30);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[800],
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scafKey: _scaffoldKey,
        barHeight: 80,
      ),
      drawer: SafeArea(child: CustomNavigationDrawer()),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.lightBlue[800],
        elevation: 8,
        items: [
          const TabItem(icon: Icons.home, title: 'Home'),
          const TabItem(icon: Icons.file_copy, title: 'Reports'),
          const TabItem(icon: Icons.settings, title: 'Settings'),
          TabItem(icon: Icons.gps_fixed, title: 'Devices'),
        ],

        initialActiveIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
      body: RoundedContainer(
        roundedChild: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
