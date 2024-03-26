import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  List<LatLng> _locations = [];
  int _locationIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    main2();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void main2() {
    fetchJsonData().then((data) {
      setState(() {
        jsonData = data;
      });
      _initializeLocations();
      // Start updating location every 5 seconds
      _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
        _updateLocation();
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  void _initializeLocations() {
    setState(() {
      _allLocations = [
        for (var location in filterJson(jsonData))
          LatLng(double.parse(location['field1']), double.parse(location['field2'])),
      ];
    });
  }

  void _updateLocation() {
    if (_allLocations.isEmpty) {
      // If _allLocations is empty, wait for 5 seconds and then try again
      Future.delayed(Duration(seconds: 5), () {
        _updateLocation();
      });
      return;
    }

    if (_locationIndex < _allLocations.length) {
      setState(() {
        _locations.add(_allLocations[_locationIndex]);
        _locationIndex++;
      });
    } else {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Location Tracker'),
      ),
      body: _locations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: _allLocations.isNotEmpty
            ? CameraPosition(target: _allLocations.first, zoom: 15.0)
            : CameraPosition(target: LatLng(0, 0), zoom: 15.0),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: _locations.map((LatLng location) {
          return Marker(
            markerId: MarkerId(location.toString()),
            position: location,
          );
        }).toSet(),
        polylines: {
          if (_locations.length > 1)
            Polyline(
              polylineId: PolylineId('route'),
              color: Colors.blue,
              points: _locations,
            ),
        },
      ),
    );
  }
}

List<LatLng> _allLocations = [];

List<Map<String, dynamic>> filterJson(Map<String, dynamic> jsonData) {
  List<Map<String, dynamic>> filteredList = [];
  List<dynamic> feeds = jsonData['feeds'];

  // Loop through each feed and extract field1 and field2
  for (var feed in feeds) {
    filteredList.add({
      "field1": feed["field1"],
      "field2": feed["field2"],
    });
  }

  return filteredList;
}

Future<Map<String, dynamic>> fetchJsonData() async {
  final url = Uri.parse(
      'https://api.thingspeak.com/channels/2471033/feeds.json?api_key=YCL781SUPFDY9DLO&results=6');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    // Decode JSON response
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  } else {
    // Handle error
    throw Exception('Failed to load data from ThingSpeak');
  }
}

// Define an empty Map to store the fetched data
Map<String, dynamic> jsonData = {};
