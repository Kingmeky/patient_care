import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  String gender = 'Male'; // Default gender
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController medicalCaseController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    medicalCaseController.dispose();
    super.dispose();
  }
//  updating add patient screen UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade500,
                ],
              ),
            ),
          ),
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: Text(
              'Add Patient',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
                fontFamily: 'Rockwell',
              ),
            ),
          ),
          elevation: 0.0,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/greenandwhitejpg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextInputField('Name', nameController),
                  SizedBox(height: 20.0),
                  _buildTextInputField('Date of Birth', dobController),
                  SizedBox(height: 20.0),
                  _buildGenderSelection(),
                  SizedBox(height: 20.0),
                  _buildTextInputField('Medical Case', medicalCaseController),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality to add a patient
                        _addPatient();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Add Patient',
                          style:
                              TextStyle(fontFamily: 'Rockwell', fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputField(
      String labelText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender:',
          style: TextStyle(fontSize: 18.0, fontFamily: 'Rockwell'),
        ),
        Row(
          children: [
            Radio(
              value: 'Male',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            Text('Male', style: TextStyle(fontFamily: 'Rockwell')),
            Radio(
              value: 'Female',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            Text('Female', style: TextStyle(fontFamily: 'Rockwell')),
          ],
        ),
      ],
    );
  }

  void _addPatient() async {
    final String name = nameController.text;
    final String dob = dobController.text;
    final String medicalCase = medicalCaseController.text;

    final Uri uri = Uri.parse('http://localhost:3000/patients');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'dob': dob,
        'gender': gender,
        'medicalCase': medicalCase,
      }),
    );

    if (response.statusCode == 201) {
      // Patient added successfully
      _showSuccessDialog();
      print('Patient added successfully');
      // You can navigate to another screen or perform other actions here
    } else {
      // Failed to add patient
      print('Failed to add patient');
      // Handle error or display error message
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Patient added successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
