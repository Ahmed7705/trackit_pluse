import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue[800],
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSettingsListItem(
              'Account Settings',
              Icons.account_circle,
              [
                buildSubSettingsListItem('Edit Profile', Icons.edit, '/edit_profile'),
                buildSubSettingsListItem('Change Password', Icons.lock, '/change_password'),
              ],
            ),
            buildSettingsListItem('Notification Settings', Icons.notifications, [], '/notification_settings'),
            buildSettingsListItem('Privacy Settings', Icons.privacy_tip, [], '/privacy_settings'),
            buildSettingsListItem('About', Icons.info, [], '/AboutPage'),
            buildSettingsListItem('Privacy Policy', Icons.privacy_tip, [], '/privacy_policy'),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsListItem(String title, IconData icon, List<Widget> subItems, [String route = '']) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (subItems.isNotEmpty) {
              _toggleExpansion();
            } else if (route.isNotEmpty) {
              Navigator.pushNamed(context, route);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.lightBlue[800],
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                if (subItems.isNotEmpty)
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(_animation),
                    child: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.lightBlue[800],
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          child: Column(children: subItems),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey[300],
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }

  Widget buildSubSettingsListItem(String title, IconData icon, String route) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.lightBlue[400],
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
