import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text('Account Settings'),
            leading: Icon(Icons.account_circle),
            onTap: () {
              // Toggle expansion
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: isExpanded ? 100.0 : 0.0,
            child: isExpanded
                ? Column(
                    children: [
                      ListTile(
                        title: Text('Edit Profile'),
                        leading: Icon(Icons.edit),
                        onTap: () {
                          // Navigate to edit profile page
                          Navigator.pushNamed(context, '/edit_profile');
                        },
                      ),
                      ListTile(
                        title: Text('Change Password'),
                        leading: Icon(Icons.lock),
                        onTap: () {
                          // Navigate to change password page
                          Navigator.pushNamed(context, '/change_password');
                        },
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ),
          Divider(),
          ListTile(
            title: Text('Notification Settings'),
            leading: Icon(Icons.notifications),
            onTap: () {
              // Navigate to notification settings page
              Navigator.pushNamed(context, '/notification_settings');
            },
          ),
          Divider(),
          ListTile(
            title: Text('Privacy Settings'),
            leading: Icon(Icons.privacy_tip),
            onTap: () {
              // Navigate to privacy settings page
              Navigator.pushNamed(context, '/privacy_settings');
            },
          ),
          Divider(),
          ListTile(
            title: Text('About'),
            leading: Icon(Icons.info),
            onTap: () {
              // Navigate to about page
              Navigator.pushNamed(context, '/about');
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
