import 'package:flutter/material.dart';

import '../screen/UserProfile.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double barHeight;
  final GlobalKey<ScaffoldState> scafKey;

  CustomAppBar({Key? key, required this.scafKey, required this.barHeight}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  Size get preferredSize => Size.fromHeight(barHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Stack(
          children:<Widget>[

            Container(
                color: Colors.lightBlue[700],

                child: Center(
                  child: Container(
                    child: const Text(
                      "TrackIt Plus",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 5
                      ),
                    ),
                  ),
                )


            ),
            Container(

              margin: EdgeInsets.fromLTRB(
                  10, height * 0.02, 0, 0),
              child: FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              PatientProfile()
                      )),
                child: CircleAvatar(
                  maxRadius: height * 0.03,
                  backgroundColor: Colors.black.withOpacity(0.2),
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),

              ),
            ),
          ]),
    );
  }
}
