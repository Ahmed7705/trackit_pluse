import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 110,
            // Placeholder profile picture
            backgroundImage: AssetImage('assets/images/profile2.png'),
          ),
          SizedBox(height: 20),
          Text(
            'Ahmed Alhadadi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Ahme77666@outlook.sa",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            '+967 770545327',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Divider(),
          ListTile(
            title: Text('Password'),
            trailing: Text('******'), // Hidden password
          ),
          Divider(),
          ListTile(
            title: Text('Device Information'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Device Name: Device A'),
                Text('Device ID: ABC123'),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Logout logic
              Navigator.pop(context); // Navigate back to previous screen
            },
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.lightBlue[700], // Set the background color here
            ),
          ),
        ],
      ),
    );
  }
}
