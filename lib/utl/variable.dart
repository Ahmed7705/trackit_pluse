import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final titleController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Add data to Firestore
                    final firestoreInstance = FirebaseFirestore.instance;
                    final collectionReference = firestoreInstance.collection('data');
                    final documentReference = collectionReference.doc();

                    await documentReference.set({
                      'name': nameController.text,
                      'title': titleController.text,
                    });

                    // Clear form fields after successful addition
                    nameController.text = '';
                    titleController.text = '';

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data added successfully!')),
                    );
                  }
                },
                child: Text('Add Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
