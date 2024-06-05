import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: buildAboutContent(),
    );
  }

  Widget buildAboutContent() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              size: 100,
              color: Colors.grey[700],
            ),
            SizedBox(height: 20),
            Text(
              'This app is designed to manage your devices efficiently.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
