import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: buildNotificationSettingsList(),
    );
  }

  Widget buildNotificationSettingsList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: Text(
            'Enable Notifications',
            style: TextStyle(fontSize: 18),
          ),
          value: notificationsEnabled,
          onChanged: (value) {
            setState(() {
              notificationsEnabled = value;
            });
          },
        ),
      ],
    );
  }
}
