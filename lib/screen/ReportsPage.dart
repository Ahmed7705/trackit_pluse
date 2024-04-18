import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportsPage> {
  String? selectedDevice;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedDevice,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDevice = newValue;
                });
              },
              items: <String?>['Device A', 'Device B', 'Device C', 'Device D']
                  .map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value ?? ''),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('From: ${fromDate.toString()}'),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: fromDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      fromDate = value;
                    });
                  }
                });
              },
              child: Text('Select From Date'),
            ),
            SizedBox(height: 20),
            Text('To: ${toDate.toString()}'),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: toDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      toDate = value;
                    });
                  }
                });
              },
              child: Text('Select To Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle report generation logic
                // You can navigate to a new page or perform any action here
              },
              child: Text('Create Report'),
            ),
          ],
        ),
      ),
    );
  }
}
