import 'package:flutter/material.dart';

class PrivacySettingsPage extends StatefulWidget {
  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool isPrivateAccount = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: buildPrivacySettingsList(),
    );
  }

  Widget buildPrivacySettingsList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: Text(
            'Private Account',
            style: TextStyle(fontSize: 18),
          ),
          value: isPrivateAccount,
          onChanged: (value) {
            setState(() {
              isPrivateAccount = value;
            });
          },
        ),
      ],
    );
  }
}
