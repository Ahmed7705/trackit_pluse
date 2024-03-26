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
