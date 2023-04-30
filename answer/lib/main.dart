import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  File? _image;
  String? _name;
  int? _age;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _submitProfile() {
    setState(() {
      _name = _nameController.text;
      _age = int.tryParse(_ageController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Profile Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(fontSize: 25, color: Colors.blue),
            ),
          ),
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Age',
              labelStyle: TextStyle(fontSize: 25, color: Colors.blue),
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _submitProfile,
              child: Text('Submit'),
            ),
          ),
          SizedBox(height: 100),
          _name != null
              ? Text(
                  'Name: $_name',
                  style: TextStyle(fontSize: 30),
                )
              : Container(),
          _age != null
              ? Text(
                  'Age: $_age',
                  style: TextStyle(fontSize: 30),
                )
              : Container(),
        ],
      ),
    );
  }
}
