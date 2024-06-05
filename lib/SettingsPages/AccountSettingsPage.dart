import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: buildAccountSettingsList(),
    );
  }

  Widget buildAccountSettingsList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          title: Text(
            'Edit Profile',
            style: TextStyle(fontSize: 18),
          ),
          leading: Icon(Icons.edit),
          onTap: () {
            Navigator.pushNamed(context, '/edit_profile');
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            'Change Password',
            style: TextStyle(fontSize: 18),
          ),
          leading: Icon(Icons.lock),
          onTap: () {
            Navigator.pushNamed(context, '/change_password');
          },
        ),
        Divider(),
      ],
    );
  }
}
