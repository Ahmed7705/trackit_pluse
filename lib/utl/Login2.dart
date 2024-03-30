// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Live Location Tracker',
//       home: MapScreen(),
//     );
//   }
// }
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
//
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//
//   List<LatLng> _locations = [];
//   int _locationIndex = 0;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     main2();
//     super.initState();
//     // Start updating location every 5 seconds
//     _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       _updateLocation();
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   void _updateLocation() {
//     print("****************************************");
//     print("****************************************");
//     print("****************************************");
//     print("****************************************");
//     print("****************************************");
//     print("****************************************");
//     print("****************************************");
//     print("****************************************");
//     print(jsonData);
//     if (_locationIndex < _allLocations.length) {
//       setState(() {
//         _locations.add(_allLocations[_locationIndex]);
//         _locationIndex++;
//       });
//     } else {
//       _timer.cancel();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Live Location Tracker'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _allLocations.isNotEmpty ? _allLocations.first : LatLng(0, 0),
//           zoom: 15.0,
//         ),
//
//         onMapCreated: (GoogleMapController controller) {
//           mapController = controller;
//         },
//         markers: _locations.map((LatLng location) {
//           return Marker(
//             markerId: MarkerId(location.toString()),
//             position: location,
//           );
//         }).toSet(),
//         polylines: {
//           if (_locations.length > 1)
//             Polyline(
//               polylineId: PolylineId('route'),
//               color: Colors.blue,
//               points: _locations,
//             ),
//         },
//       ),
//     );
//   }
// }
//
// List<LatLng> _allLocations = [
//   for (var location in filterJson(jsonData))
//     LatLng(double.parse(location['field1']), double.parse(location['field2'])),
// ];
//
// List<Map<String, dynamic>> filterJson(Map<String, dynamic> jsonData) {
//   List<Map<String, dynamic>> filteredList = [];
//   List<dynamic> feeds = jsonData['feeds'];
//
//   // Loop through each feed and extract field1 and field2
//   for (var feed in feeds) {
//     filteredList.add({
//       "field1": feed["field1"],
//       "field2": feed["field2"],
//     });
//   }
//
//   return filteredList;
// }
//
//
//
// // Function to fetch data from ThingSpeak API
// Future<Map<String, dynamic>> fetchJsonData() async {
//   final url = Uri.parse(
//       'https://api.thingspeak.com/channels/2471033/feeds.json?api_key=YCL781SUPFDY9DLO&results=6');
//
//   final response = await http.get(url);
//
//   if (response.statusCode == 200) {
//     // Decode JSON response
//     final data = json.decode(response.body) as Map<String, dynamic>;
//     return data;
//   } else {
//     // Handle error
//     throw Exception('Failed to load data from ThingSpeak');
//   }
// }
//
// // Call the fetchJsonData function and store the result in jsonData
// Future<void> main2() async {
//   try {
//
//     jsonData = await fetchJsonData();
//     // Now you can use the 'jsonData' variable for further processing
//   } on Exception catch (e) {
//     print('Error: $e');
//   }
// }
//
// // Define an empty Map to store the fetched data
// Map<String, dynamic> jsonData = {};
//
// // Define the jsonData variable with the provided JSON structure
// // Map<String, dynamic> jsonData = {
// //   "channel": {
// //     "id": 2471033,
// //     "name": "Asset tracking",
// //     "description": "Track personal assets",
// //     "latitude": "14.5394453835",
// //     "longitude": "44.3989706039",
// //     "field1": "latitude",
// //     "field2": "longitude",
// //     "created_at": "2024-03-15T02:03:27Z",
// //     "updated_at": "2024-03-25T02:08:51Z",
// //     "last_entry_id": 6
// //   },
// //   "feeds": [
// //     {
// //       "created_at": "2024-03-25T02:01:56Z",
// //       "entry_id": 1,
// //       "field1": "14.539445383461455",
// //       "field2": "44.39897060394288"
// //     },
// //     {
// //       "created_at": "2024-03-25T02:02:29Z",
// //       "entry_id": 2,
// //       "field1": "14.539299989976957",
// //       "field2": "44.39904570579529"
// //     },
// //     {
// //       "created_at": "2024-03-25T02:03:03Z",
// //       "entry_id": 3,
// //       "field1": "14.539019587986639",
// //       "field2": "44.39914226531983"
// //     },
// //     {
// //       "created_at": "2024-03-25T02:03:26Z",
// //       "entry_id": 4,
// //       "field1": "14.53887419422192",
// //       "field2": "44.39920663833619"
// //     },
// //     {
// //       "created_at": "2024-03-25T02:04:03Z",
// //       "entry_id": 5,
// //       "field1": "14.538765148835596",
// //       "field2": "44.39923882484436"
// //     },
// //     {
// //       "created_at": "2024-03-25T02:04:29Z",
// //       "entry_id": 6,
// //       "field1": "14.53861456226122",
// //       "field2": "44.399281740188606"
// //     }
// //   ]
// // };
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

final _controllerName = TextEditingController();
final _controllerCNIC = TextEditingController();

class _DoctorLoginState extends State<DoctorLogin> {
  bool validateCNICVar = false;
  bool validateName = false;

  controllerClear() {
    _controllerName.clear();
    _controllerCNIC.clear();
  }

  validateCNIC(String idNumber) {
    if (!(idNumber.length == 13) && idNumber.isNotEmpty) {
      return "CNIC must be of 13-Digits";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final nameTextField = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLength: 30,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: _controllerName,
      decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.08),
          filled: true,
          labelText: 'Enter Name',
          prefixIcon: Icon(
            Icons.person,
            color: Colors.lightBlue[800],
          ),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(20)))),
    );

    final cnicTextField = TextField(
      keyboardType: TextInputType.number,
      autofocus: false,
      maxLength: 13,
      controller: _controllerCNIC,
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          filled: true,
          errorText: validateCNIC(_controllerCNIC.text),
          fillColor: Colors.white.withOpacity(0.08),
          labelText: 'NIC Number',
          prefixIcon: Icon(Icons.credit_card, color: Colors.lightBlue[800]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );

    double baseWidth = 360.5;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _HeaderWavesPainter(),
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  margin: EdgeInsets.fromLTRB(width * 0.03, 0, width * 0.03, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem + 70),
                          width: double.infinity,
                          child: Text(
                            'Sign-In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 64 * ffem,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Align(
                          child: SizedBox(
                            width: 190 * fem,
                            height: 71 * fem,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 48 * ffem,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffffffff),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Welco',
                                    style: TextStyle(
                                      fontSize: 48 * ffem,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.lightBlue[800],
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'me',
                                    style: TextStyle(
                                      fontSize: 48 * ffem,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff302121),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: nameTextField,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * fem, 10, 0 * fem, 50),
                        child: cnicTextField,
                      ),
                      SizedBox(
                        width: width,
                        height: height * 0.25,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(1.5 * fem, 0 * fem, 18 * fem, 0 * fem),
                          width: double.infinity,
                          height: 55 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15 * fem),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 171 * fem,
                                top: 0 * fem + 10,
                                child: Container(
                                  width: 148 * fem,
                                  height: 55 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15 * fem),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 55 * fem,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15 * fem),
                                          color: Color(0xff0b65b8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0 * fem + 4,
                                top: 0 * fem + 10,
                                child: Container(
                                  width: 303 * fem,
                                  height: 55 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0 * fem + 5, 0 * fem, 54 * fem, 0 * fem),
                                        width: 148 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xff302121),
                                          borderRadius: BorderRadius.circular(15 * fem),
                                        ),
                                        child: Center(
                                          child: TextButton(
                                            child: Text(
                                              'Back',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20 * ffem,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                          child: TextButton(
                                            child: Text(
                                              'Sign-Up',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20 * ffem,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _controllerCNIC.text.isEmpty
                                                    ? validateCNICVar = true
                                                    : validateCNICVar = false;
                                                _controllerName.text.isEmpty
                                                    ? validateName = true
                                                    : validateName = false;
                                              });
                                              Toast.show(
                                                  "Empty Field(s) Found!",
                                                  backgroundColor: Colors.red,
                                                  backgroundRadius: 5,
                                                  duration: Toast.lengthLong);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Do you forgot your Nic ?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff000000),
                                        )),
                                    onPressed: () {
                                      Toast.show(
                                          " حاول تتذكر",
                                          backgroundColor: Colors.red,
                                          backgroundRadius: 6,
                                          duration: Toast.lengthLong);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: height * 0.2 - 160,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.lightBlue[800]!;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final path = Path();

    path.lineTo(0, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.40, size.width * 0.5, size.height * 0.30);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.20, size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
