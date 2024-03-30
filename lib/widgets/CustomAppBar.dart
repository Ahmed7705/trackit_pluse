import 'package:flutter/material.dart';

import 'UserProfile.dart';

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
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //       colors: [
                //         const Color(0xff1f83fe),
                //         const Color(0xff006bff),
                //         const Color(0xff006bff),
                //       ]),
                // ),
                child: Center(
                  child: Container(
                    child: Text(
                      "Safety",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 5
                      ),
                    ),
                  ),
                )

              // ListTile(
              //   contentPadding: EdgeInsets.only(left: 25, top: 8, bottom: 0),
              //   leading: CircleAvatar(
              //     radius: 25,
              //   ),
              //   // Icon(
              //   //   Icons.menu,
              //   //   size: 30,
              //   //   color: Colors.white,
              //   // ),
              //   title: Row(
              //     children: <Widget>[
              //       // Text(
              //       //   "Hello, ",
              //       //   style: TextStyle(
              //       //       color: Colors.white, fontSize: 20, letterSpacing: 2),
              //       // ),
              //       Text(
              //         "Faiz Ainur Rofiq",
              //         style: TextStyle(
              //           fontSize: 20,
              //           // fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //           letterSpacing: 2,
              //         ),
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //     ],
              //   ),
              //   subtitle: Text(
              //     "Owner",
              //     style: TextStyle(
              //       color: Colors.white70,
              //       letterSpacing: 1.7,
              //     ),
              //   ),
              //   onTap: () {
              //     setState(() {
              //       widget.scafKey.currentState.openDrawer();
              //     });
              //   },
              // ),
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
                    backgroundImage: NetworkImage("https://m.media-amazon.com/images/I/2128q5aAVQL._AC_UL320_.png"),

                    //photoUrl
                  )
              ),
            ),
          ]),
    );
  }
}
