import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackit_pluse/login.dart';
import 'package:trackit_pluse/screen/ReportsPage.dart';
import 'package:trackit_pluse/screen/Settings.dart';
import 'package:trackit_pluse/screen/UserAccount.dart';

import 'CustomAppBar.dart';
import 'UserProfile.dart';
import 'models/CustomNavigationDrawer.dart';



class MainPage extends StatefulWidget {

  MainPage({Key? key, required this.title,required this.detailsUser2}) : super(key: key);

  final String title;
  final PatientDetails detailsUser2;

  @override
  _MainPageState createState() => _MainPageState();
}
//details.userName='Ahmed';
// details.userEmail='mm770545327@gmail.com';
// details.photoUrl=
// 'https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg';
// details.providerDetails='Ahmed Mohsen Alhdadi';
class _MainPageState extends State<MainPage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // static  PatientDetails detailsUser3=PatientDetails('Ahmed',
  //     'mm770545327@gmail.com',
  //     'https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg',
  //       'Ahmed Mohsen Alhdadi',
  //     providerData
  //
  // );
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    Padding(
      padding: EdgeInsets.only(top: 15),
      child: HomePage(
      ),
    ),
    Settings(),
    Padding(
      padding: EdgeInsets.only(top: 15),
      child:
      ReportsPage( ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 15),
      child:
      UserAccount(),
    ),
  ];

  void  onItemTapped(int index) {
    setState(() {

      _selectedIndex = index;

    });
  }
  Icon icon2= const Icon(
      Icons.fiber_new,
      color:Colors.amber,
      size: 30
  );
  @override
  Widget build(BuildContext context) {
    print("Application Launched");
    return Scaffold(
      backgroundColor:Colors.lightBlue[800] ,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scafKey: _scaffoldKey,
        barHeight: 80,
      ),
      drawer: SafeArea(child: CustomNavigationDrawer()),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.lightBlue[800],
        elevation: 8,
        // items: <BottomNavigationBarItem>[
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.home),
        //     label: "Home",
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.list),
        //     label: "Products",
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.history),
        //     label:"History",
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.add_shopping_cart),
        //     label:"New",
        //   ),
        // ],
        items: [
          const TabItem(icon: Icons.home, title: 'Home'),
          const TabItem(icon: Icons.report title: 'Disease'),
          const TabItem(icon: Icons.settings, title: 'Favorites'),
          TabItem(icon :Icons.account_circle, title: 'Recently '),
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