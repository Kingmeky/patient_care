/*import 'package:flutter/material.dart';
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

class Test {
  final String id;
  final String patientId;
  final String date;
  final String type;
  final String result;

  Test({
    required this.id,
    required this.patientId,
    required this.date,
    required this.type,
    required this.result,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['_id'],
      patientId: json['patient_id'],
      date: json['date'],
      type: json['type'],
      result: json['result'],
    );
  }
}

class ViewPatientTest extends StatefulWidget {
  @override
  _ViewPatientTestState createState() => _ViewPatientTestState();
}

class _ViewPatientTestState extends State<ViewPatientTest> {
  List<Patient> patients = [];
  List<Test> tests = [];
  String selectedPatientId = '';

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

  Future<void> fetchTests(String patientId) async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/patients/$patientId/tests'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        tests = responseData.map((data) => Test.fromJson(data)).toList();
      });
    } else {
      // Handle error
      print('Failed to fetch tests');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Patient Test'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return ListTile(
                  title: Text(patient.name),
                  subtitle:
                      Text('DOB: ${patient.dob} | Gender: ${patient.gender}'),
                  onTap: () async {
                    setState(() {
                      selectedPatientId = patient.id;
                    });
                    await fetchTests(selectedPatientId);
                  },
                  selected: selectedPatientId == patient.id,
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tests.length,
              itemBuilder: (context, index) {
                final test = tests[index];
                return ListTile(
                  title: Text(test.date),
                  subtitle: Text('Type: ${test.type} | Result: ${test.result}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Add functionality to edit test result
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ViewPatientTest(),
  ));
}*/

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

class Test {
  String id;
  String patientId;
  String date;
  String type;
  String result;

  Test({
    required this.id,
    required this.patientId,
    required this.date,
    required this.type,
    required this.result,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['_id'],
      patientId: json['patient_id'],
      date: json['date'],
      type: json['type'],
      result: json['result'],
    );
  }
}

class ViewPatientTest extends StatefulWidget {
  @override
  _ViewPatientTestState createState() => _ViewPatientTestState();
}

class _ViewPatientTestState extends State<ViewPatientTest> {
  List<Patient> patients = [];
  List<Test> tests = [];
  String selectedPatientId = '';

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
      print('Failed to fetch patients');
    }
  }

  Future<void> fetchTests(String patientId) async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/patients/$patientId/tests'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        tests = responseData.map((data) => Test.fromJson(data)).toList();
      });
    } else {
      print('Failed to fetch tests');
    }
  }

  Future<void> updateTest(String patientId, String testId, String date,
      String type, String result) async {
    final url =
        Uri.parse('http://localhost:3000/patients/$patientId/tests/$testId');
    final response = await http.put(
      url,
      body: jsonEncode({
        'date': date,
        'type': type,
        'result': result,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Test updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      await fetchTests(patientId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update test'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> deleteTest(String patientId, String testId) async {
    final url =
        Uri.parse('http://localhost:3000/patients/$patientId/tests/$testId');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Test deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      await fetchTests(patientId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete test'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void editTestResult(Test test) {
    TextEditingController typeController =
        TextEditingController(text: test.type);
    TextEditingController dateController =
        TextEditingController(text: test.date);
    TextEditingController resultController =
        TextEditingController(text: test.result);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Test Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: typeController,
                onChanged: (value) {
                  test.type = value;
                },
                decoration: InputDecoration(labelText: 'Type'),
              ),
              TextField(
                controller: dateController,
                onChanged: (value) {
                  test.date = value;
                },
                decoration: InputDecoration(labelText: 'Date'),
              ),
              TextField(
                controller: resultController,
                onChanged: (value) {
                  test.result = value;
                },
                decoration: InputDecoration(labelText: 'Result'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await updateTest(
                    test.patientId, test.id, test.date, test.type, test.result);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Patient Test'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.1),
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        selectedPatientId = patient.id;
                      });
                      await fetchTests(selectedPatientId);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: selectedPatientId == patient.id
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rockwell',
                              fontSize: 16,
                              color: selectedPatientId == patient.id
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'DOB: ${patient.dob}',
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedPatientId == patient.id
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Gender: ${patient.gender}',
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedPatientId == patient.id
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: tests.length,
              itemBuilder: (context, index) {
                final test = tests[index];
                return GestureDetector(
                  onTap: () {
                    editTestResult(test);
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${test.date}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rockwell',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Type: ${test.type}',
                          style: TextStyle(
                            fontFamily: 'Rockwell',
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Result: ${test.result}',
                          style: TextStyle(
                            fontFamily: 'Rockwell',
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                editTestResult(test);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteTest(test.patientId, test.id);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ViewPatientTest(),
  ));
}
