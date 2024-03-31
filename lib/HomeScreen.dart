/*import 'package:flutter/material.dart';
import 'package:patient_care/AddPatientTest.dart';
import 'package:patient_care/ViewPatientTests.dart';
import 'AddPatientScreen.dart';
import 'ViewPatientScreens.dart';

// Home Screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/greenandwhitejpg.jpg'), // Change path to your image file
            fit: BoxFit.cover, // Adjust as needed
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 32.0), // Add space above the greeting message
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to the Home Screen!',
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
                height:
                    120.0), // Add space between the greeting message and icons
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle "Add Patient" icon tap
                      // Navigate to the screen where you can add a patient
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPatientScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.person_add, size: 48.0),
                        SizedBox(height: 8.0),
                        Text('Add Patient', style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "View Patient" icon tap
                      // Navigate to the screen where you can view patients
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewPatientScreens()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.view_list, size: 48.0),
                        SizedBox(height: 8.0),
                        Text('View Patient', style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0), // Add space between rows
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle "Add Patient Test" icon tap
                      // Navigate to the screen where you can add a patient test
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddPatientTest()), // You can replace AddPatientScreen with the appropriate screen for adding patient test
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.add_circle, size: 48.0),
                        SizedBox(height: 8.0),
                        Text('Add Patient Test',
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "View Patient Test" icon tap
                      // Navigate to the screen where you can view patient tests
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewPatientTest()), // You can replace ViewPatientTest with the appropriate screen for viewing patient tests
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.add_circle, size: 48.0),
                        SizedBox(height: 8.0),
                        Text('View Patient Test',
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:patient_care/AddPatientTest.dart';
import 'package:patient_care/ViewPatientTests.dart';
import 'AddPatientScreen.dart';
import 'ViewPatientScreens.dart';
import 'main.dart'; // Assuming the login screen is in main.dart

// Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle logout here
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp()), // Redirect to login screen
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/greenandwhitejpg.jpg'), // Change path to your image file
            fit: BoxFit.cover, // Adjust as needed
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 32.0), // Add space above the greeting message
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to the Home Screen!',
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
                height:
                    120.0), // Add space between the greeting message and icons
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle "Add Patient" icon tap
                      // Navigate to the screen where you can add a patient
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPatientScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.person_add, size: 48.0),
                        SizedBox(height: 8.0),
                        Text('Add Patient', style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "View Patient" icon tap
                      // Navigate to the screen where you can view patients
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewPatientScreens()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.view_list, size: 48.0),
                        SizedBox(height: 8.0),
                        Text('View Patient', style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0), // Add space between rows
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle "Add Patient Test" icon tap
                      // Navigate to the screen where you can add a patient test
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddPatientTest()), // You can replace AddPatientScreen with the appropriate screen for adding patient test
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.add_circle, size: 48.0),
                        SizedBox(height: 8.0),
                        Text('Add Patient Test',
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "View Patient Test" icon tap
                      // Navigate to the screen where you can view patient tests
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewPatientTest()), // You can replace ViewPatientTest with the appropriate screen for viewing patient tests
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.add_circle, size: 48.0),
                        SizedBox(height: 8.0),
                        Text('View Patient Test',
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
