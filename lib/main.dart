import 'package:flutter/material.dart';
import 'package:trackit_pluse/screen/LoginPage.dart';
import 'package:trackit_pluse/screen/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'SettingsPages/AboutPage.dart';
import 'SettingsPages/AccountSettingsPage.dart';
import 'SettingsPages/EditProfilePage.dart';
import 'SettingsPages/NotificationSettingsPage.dart';
import 'SettingsPages/PrivacySettingsPage.dart';
import 'SettingsPages/Settings.dart';

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/home': (context) => HomePage(),
      '/AboutPage': (context) => AboutPage(),
      '/settings': (context) => SettingsPage(),
      '/edit_profile': (context) => EditProfilePage(),
      '/change_password': (context) => EditProfilePage(),
      '/account_settings': (context) => AccountSettingsPage(),
      '/notification_settings': (context) => NotificationSettingsPage(),
      '/privacy_settings': (context) => PrivacySettingsPage(),
    },
  ),

  );
}

