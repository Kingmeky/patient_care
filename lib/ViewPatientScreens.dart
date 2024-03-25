import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewPatientScreens extends StatefulWidget {
  @override
  _ViewPatientScreensState createState() => _ViewPatientScreensState();
}

class _ViewPatientScreensState extends State<ViewPatientScreens> {
  List<dynamic> patients = [];

  Future<void> fetchPatients() async {
    final response = await http.get(Uri.parse(
        'http://localhost:3000/patients')); // Replace 'http://localhost:3000/patients' with your server address
    if (response.statusCode == 200) {
      setState(() {
        patients = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load patients');
    }
  }

  Future<void> deletePatient(String id) async {
    final response = await http.delete(Uri.parse(
        'http://localhost:3000/patients/$id')); // Replace with your server address
    if (response.statusCode == 200) {
      // If deletion is successful, fetch updated list of patients
      await fetchPatients();
    } else {
      throw Exception('Failed to delete patient');
    }
  }

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
              'View Patients',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
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
                image: AssetImage(
                    'images/greenandwhitejpg.jpg'), // Replace 'assets/background_image.jpg' with your image asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    fetchPatients(); // Call fetchPatients() when the button is pressed
                  },
                  child: Text('Fetch Patients'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: patients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        shadowColor:
                            Color.fromARGB(255, 70, 69, 70).withOpacity(1.0),
                        color: Colors.white.withOpacity(0.8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Handle edit button press
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    deletePatient(patients[index]['_id']);
                                  },
                                ),
                              ],
                            ),
                            ListTile(
                              title: Text(
                                patients[index]['name'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 8.0),
                                  Text(
                                    'DOB: ${patients[index]['dob']}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Gender: ${patients[index]['gender']}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Medical Case: ${patients[index]['medicalCase']}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
