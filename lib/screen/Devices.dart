import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

import 'AddDevice.dart';
import 'UpdateDevice.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
   ScrollController? _scrollController;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(() {
      setState(() {
        _isVisible = _scrollController?.position.userScrollDirection == ScrollDirection.forward;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Management'),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('devices').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var devices = snapshot.data!.docs;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue[100]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: devices.length,
              itemBuilder: (context, index) {
                var device = devices[index];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(device['name'], style: GoogleFonts.kurale()),
                    subtitle: Text(device['imei'], style: GoogleFonts.kurale()),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'update') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateDevice(device: device),
                            ),
                          );
                        } else if (value == 'delete') {
                          _showDeleteConfirmationDialog(device.id);
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return {'update', 'delete'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          margin: EdgeInsets.only(bottom: _isVisible ? 16.0 : 0.0, right: 16.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDevice()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.lightBlue[800],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(String deviceId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this device?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: GoogleFonts.kurale()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes', style: GoogleFonts.kurale()),
              onPressed: () {
                FirebaseFirestore.instance.collection('devices').doc(deviceId).delete();
                Navigator.of(context).pop();
                Toast.show('Deleted Successfully!',
                    backgroundRadius: 5, backgroundColor: Colors.blue, duration: 3);
              },
            ),
          ],
        );
      },
    );
  }
}
