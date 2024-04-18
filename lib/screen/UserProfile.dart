import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientProfile extends StatelessWidget {
  PatientProfile();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: height * 0.05,
          ),
          Center(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'patPic',
                  child: CircleAvatar(
                    maxRadius: height * 0.20,
                    backgroundColor: Colors.black.withOpacity(0.2),
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  "Ahmed Alhadadi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(height: height * 0.007),
                Text(
                  "Ahme77666@outlook.sa",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _logOutAlertBox(context);
                  },
                  label: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.red),
                  ),
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                    size: height * 0.03,
                  ),
                ),
                SizedBox(height: height * 0.28),
                Text(
                  'Version',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('v 0.1')
              ],
            ),
          ),
        ],
      ),
    ));
  }

  void _logOutAlertBox(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: new Text(
            "Are you Sure?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("You are about to Log Out!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                "Close",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                "Log Out",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 3);
              },
            ),
          ],
        );
      },
    );
  }
}

class PatientDetails {}
