import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackit_pluse/utl/variable.dart';

class PatientProfile extends StatefulWidget {
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  final FirebaseAuth? _auth = user4;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _username = "Loading...";
  String _email = "Loading...";
  String _profilePicUrl = "assets/images/profile.png"; // Default profile picture

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth?.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      print(user.email!);
      print('*******************************************************************************************');
      print('*******************************************************************************************');
      print('*******************************************************************************************');
      print('*******************************************************************************************');
      print('*******************************************************************************************');

      setState(() {
        _username = userDoc.get('username');
        _email = user.email!;
        _profilePicUrl = userDoc.get('profilePicUrl');
      });
    }
  }

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
                        backgroundImage: NetworkImage(_profilePicUrl),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text(
                      _username,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(height: height * 0.007),
                    Text(
                      _email,
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
