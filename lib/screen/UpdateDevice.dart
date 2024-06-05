import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class UpdateDevice extends StatefulWidget {
  final QueryDocumentSnapshot device;

  UpdateDevice({required this.device});

  @override
  _UpdateDeviceState createState() => _UpdateDeviceState();
}

class _UpdateDeviceState extends State<UpdateDevice> {
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
  void initState() {
    super.initState();
    controllerDeviceName.text = widget.device['name'];
    controllerIMEI.text = widget.device['imei'];
    controllerPassword.text = widget.device['password'];
    controllerDescription.text = widget.device['description'];
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

    void updateDevice() {
      FirebaseFirestore.instance.collection('devices').doc(widget.device.id).update({
        'name': controllerDeviceName.text,
        'imei': controllerIMEI.text,
        'password': controllerPassword.text,
        'description': controllerDescription.text,
      });

      Toast.show('Device Updated Successfully!',
          backgroundRadius: 5, backgroundColor: Colors.blue, duration: 3);
      Navigator.pop(context);
    }

    final updateBtn = Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue[800],
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          updateDevice();
        },
        child: Text(
          'Update',
          style: GoogleFonts.kurale(
            fontSize: 30,
            fontWeight: FontWeight.w500,
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
          title: const Text('Update Device'),
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
                    margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Updating',
                          style: GoogleFonts.kurale(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.lightBlue[800],
                          ),
                        ),
                        SizedBox(width: height * 0.015),
                        Text(
                          'Device',
                          style: GoogleFonts.kurale(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff302121),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    'Modify the Following Information',
                    style: GoogleFonts.kurale(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
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
                  updateBtn,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
