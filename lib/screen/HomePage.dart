
import 'package:flutter/cupertino.dart';

import '../utl/variable.dart';
import '../widgets/MapScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MapScreen();
  }
}
