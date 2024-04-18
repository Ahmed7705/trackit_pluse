import 'package:flutter/material.dart';
import 'package:trackit_pluse/screen/LoginPage.dart';
import 'package:trackit_pluse/screen/HomePage.dart';
import 'package:trackit_pluse/screen/Settings.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/settings': (context) => Settings(),
      },
    ),
  );
}

