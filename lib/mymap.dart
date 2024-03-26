import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveLocationTracker extends StatefulWidget {
  const LiveLocationTracker({Key? key}) : super(key: key);
  // jsonData = await fetchJsonData();
  // print("****************************************");
  // print("****************************************");
  // print("****************************************");
  // print("****************************************");
  // print("****************************************");
  // print("****************************************");
  // print("****************************************");
  // print("****************************************");
  @override
  State<LiveLocationTracker> createState() => _LiveLocationTrackerState();
}

class _LiveLocationTrackerState extends State<LiveLocationTracker> {
  final String _thingSpeakApiKey = 'YCL781SUPFDY9DLO'; // Replace with your actual API key
  final String _thingSpeakChannelId = '2471033';
  final List<LatLng> _locations = [];
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    final url = Uri.parse(
        'https://api.thingspeak.com/channels/$_thingSpeakChannelId/fields/1.json?api_key=$_thingSpeakApiKey&results=6');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (final location in jsonData['feeds']) {
        final latitude = double.parse(location['field1']);
        final longitude = double.parse(location['field2']);
        _locations.add(LatLng(latitude, longitude));
      }
      setState(() {});
    } else {
      // Handle API request error
      print('Error fetching locations: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _locations.isNotEmpty ? _locations.first : LatLng(0, 0), // Handle empty list
        zoom: 15,
      ),
      polylines: {
        Polyline(
          polylineId: const PolylineId('path'),
          points: _locations,
          color: Colors.blue,
          width: 5,
        ),
      },
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
