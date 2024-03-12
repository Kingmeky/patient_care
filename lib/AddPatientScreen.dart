import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Patient'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name:',
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Enter name'),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Date of Birth:',
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: dobController,
                  decoration: InputDecoration(hintText: 'Enter date of birth'),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Gender:',
                  style: TextStyle(fontSize: 18.0),
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
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  'Medical Case:',
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: medicalCaseController,
                  decoration:
                      InputDecoration(hintText: 'Enter medical case details'),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to add a patient
                    _addPatient();
                  },
                  child: Text('Add Patient'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addPatient() {}
}
