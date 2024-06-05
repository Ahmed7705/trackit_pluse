import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  Uint8List? _imageBytes;
  late XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _fetchUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final userData = await _firestore.collection('users').doc(currentUser.uid).get();
      if (userData.exists) {
        setState(() {
          _usernameController.text = userData['username'];
          _emailController.text = userData['email'];
          _phoneController.text = userData['phone'];
          _imageBytes = userData['profileImage'];
        });
      }
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = XFile(pickedFile.path);
        _imageBytes = null; // Reset image bytes when a new image is picked
      }
    });
  }

  Future<Uint8List> _getImageBytes() async {
    if (_imageFile == null) {
      return Uint8List(0);
    }
    final bytes = await _imageFile!.readAsBytes();
    return bytes;
  }

  Future<void> _saveProfileChanges() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        final imageBytes = _imageBytes ?? await _getImageBytes();
        await _firestore.collection('users').doc(currentUser.uid).update({
          'username': _usernameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'profileImage': imageBytes,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _getImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                        child: _imageBytes == null ? Icon(Icons.camera_alt, size: 40) : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _getImage,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 18,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfileChanges,
                  child: Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
