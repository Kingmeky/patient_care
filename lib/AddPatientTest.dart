import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Patient {
  final String id;
  final String name;
  final String dob;
  final String gender;
  final String medicalCase;

  Patient({
    required this.id,
    required this.name,
    required this.dob,
    required this.gender,
    required this.medicalCase,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'],
      name: json['name'],
      dob: json['dob'],
      gender: json['gender'],
      medicalCase: json['medicalCase'],
    );
  }
}

class AddPatientTest extends StatefulWidget {
  @override
  _AddPatientTestState createState() => _AddPatientTestState();
}

class _AddPatientTestState extends State<AddPatientTest> {
  List<Patient> patients = [];
  String selectedPatientId = '';
  String testDate = '';
  String testType = '';
  String testResult = '';

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/patients'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        patients = responseData.map((data) => Patient.fromJson(data)).toList();
      });
    } else {
      // Handle error
      print('Failed to fetch patients');
    }
  }

  Future<void> addTest() async {
    if (selectedPatientId.isEmpty) {
      // No patient selected
      return;
    }

    final Uri uri =
        Uri.parse('http://localhost:3000/patients/$selectedPatientId/tests');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'date': testDate.toString(),
        'type': testType.toString(),
        'result': testResult.toString(),
      }),
    );

    if (response.statusCode == 201) {
      // Test added successfully
      // Refresh patient data to update tests
      await fetchPatients();
      // Reset test data fields
      setState(() {
        testDate = '';
        testType = '';
        testResult = '';
      });
      // You may want to show a success message
      print('Test added successfully');
    } else {
      // Failed to add test
      // Handle error or display error message
      print('Failed to add test');
    }
  }
// adding patient test UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Patient Test'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return Card(
                  color: selectedPatientId == patient.id
                      ? Colors.blue.withOpacity(0.2)
                      : null,
                  child: ListTile(
                    title: Text(patient.name),
                    subtitle:
                        Text('DOB: ${patient.dob} | Gender: ${patient.gender}'),
                    onTap: () {
                      setState(() {
                        selectedPatientId = patient.id;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Add Test',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) => testDate = value,
                  decoration: InputDecoration(
                      labelText: 'Date (YYYY-MM-DD)',
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) => testType = value,
                  decoration: InputDecoration(
                      labelText: 'Type', border: OutlineInputBorder()),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) => testResult = value,
                  decoration: InputDecoration(
                      labelText: 'Result', border: OutlineInputBorder()),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: addTest,
                  child: Text('Add Test'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddPatientTest(),
  ));
}
