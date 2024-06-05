import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

import '../models/utils.dart';

class AddDevice extends StatefulWidget {
  AddDevice();

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final controllerDeviceName = TextEditingController();
  final controllerIMEI = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerDescription = TextEditingController();

  bool validDeviceName = false;
  bool validIMEI = false;
  bool validPassword = false;
  bool validDescription = false;

  void scanBarcode() async {
    try {
      var barcodeScanRes = await BarcodeScanner.scan();
      if (barcodeScanRes.type == ResultType.Barcode) {
        setState(() {
          controllerIMEI.text = barcodeScanRes.rawContent;
        });
      }
    } catch (e) {
      setState(() {
        controllerIMEI.text = 'Failed to get the IMEI.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final deviceNameTF = TextField(
      keyboardType: TextInputType.text,
      controller: controllerDeviceName,
      decoration: InputDecoration(
        labelText: 'Device Name',
        filled: true,
        fillColor: Colors.black.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final imeiTF = Stack(
      children: [
        TextField(
          keyboardType: TextInputType.text,
          controller: controllerIMEI,
          decoration: InputDecoration(
            labelText: 'IMEI',
            filled: true,
            fillColor: Colors.black.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: "IMEI",
            hintStyle: TextStyle(color: Colors.grey[700]),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: scanBarcode,
          ),
        ),
      ],
    );
    final passwordTF = TextField(
      keyboardType: TextInputType.text,
      controller: controllerPassword,
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.black.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final descriptionTF = TextField(
      keyboardType: TextInputType.multiline,
      controller: controllerDescription,
      maxLines: null,
      decoration: InputDecoration(
        labelText: 'Description',
        filled: true,
        fillColor: Colors.black.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    void controllerClear() {
      controllerDeviceName.clear();
      controllerIMEI.clear();
      controllerPassword.clear();
      controllerDescription.clear();
    }

    void addingDevice() {
      FirebaseFirestore.instance.collection('devices').doc(controllerDeviceName.text).set({
        'name': controllerDeviceName.text,
        'imei': controllerIMEI.text,
        'password': controllerPassword.text,
        'description': controllerDescription.text,
      });

      controllerClear();
      Toast.show('Added Successfully!',
          backgroundRadius: 5, backgroundColor: Colors.blue, duration: 3);
      Navigator.pop(context);
    }

    final addBtn = Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue[800],
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          setState(() {
            controllerDeviceName.text.isEmpty ? validDeviceName = true : validDeviceName = false;
            controllerIMEI.text.isEmpty ? validIMEI = true : validIMEI = false;
            controllerPassword.text.isEmpty ? validPassword = true : validPassword = false;
            controllerDescription.text.isEmpty ? validDescription = true : validDescription = false;
          });
          if (!validDeviceName && !validIMEI && !validPassword && !validDescription) {
            addingDevice();
          } else {
            Toast.show("Empty Field(s) Found!",
                backgroundColor: Colors.red, backgroundRadius: 5, duration: 2);
          }
        },
        child: Text(
          'Add',
          style: SafeGoogleFont(
            'Kurale',
            fontSize: 30,
            fontWeight: FontWeight.w500,
            height: 1,
            color: Colors.white,
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Device'),
          backgroundColor: Colors.lightBlue[800],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: width,
              margin: EdgeInsets.fromLTRB(width * 0.025, 0, width * 0.025, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: height * 0.05),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Adding',
                          style: SafeGoogleFont(
                            'Kurale',
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: Colors.lightBlue[800],
                          ),
                        ),
                        SizedBox(width: height * 0.015),
                        Text(
                          'Device',
                          style: SafeGoogleFont(
                            'Kurale',
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: Color(0xff302121),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    'Enter the Following Information',
                    style: SafeGoogleFont(
                      'Kurale',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      color: Color(0xff302121),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  deviceNameTF,
                  SizedBox(height: height * 0.015),
                  imeiTF,
                  SizedBox(height: height * 0.015),
                  passwordTF,
                  SizedBox(height: height * 0.015),
                  descriptionTF,
                  SizedBox(height: height * 0.02),
                  addBtn,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
