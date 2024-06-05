import 'package:barcode_scan2/gen/protos/protos.pbenum.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackit_pluse/widgets/AppBottomNavigation.dart';

import 'LoginPage.dart';

class IMEIVerificationPage extends StatefulWidget {
  @override
  _IMEIVerificationPageState createState() => _IMEIVerificationPageState();
}

class _IMEIVerificationPageState extends State<IMEIVerificationPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _imeiController = TextEditingController();
  final TextEditingController _devicePasswordController = TextEditingController();

  Future<void> _scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        setState(() {
          _imeiController.text = result.rawContent;
        });
      }
    } catch (e) {
      setState(() {
        _imeiController.text = 'Failed to get the IMEI.';
      });
    }
  }

  Future<void> _verifyDevice(BuildContext context) async {
    try {
      String imei = _imeiController.text.trim();
      String devicePassword = _devicePasswordController.text.trim();

      DocumentSnapshot deviceSnapshot = await _firestore.collection('devices').doc(imei).get();

      if (deviceSnapshot.exists) {
        String storedPassword = deviceSnapshot.get('password');
        if (storedPassword == devicePassword) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect device password')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('IMEI not found')),
        );
      }
    } catch (e) {
      print('Device Verification Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Device Verification Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/light-1.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/light-2.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/clock.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "Verify Device",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromRGBO(143, 148, 251, 1)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(143, 148, 251, 1))),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _imeiController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "IMEI",
                                      hintStyle: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.qr_code_scanner),
                                  onPressed: _scanBarcode,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(143, 148, 251, 1))),
                            ),
                            child: TextField(
                              controller: _devicePasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Device Password",
                                hintStyle: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        _verifyDevice(context);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text("Verify",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
