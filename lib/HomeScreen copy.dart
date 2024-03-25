import 'package:flutter/material.dart';
import 'AddPatientScreen.dart';
import 'ViewPatientScreens.dart';

//Home Screen
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
          ],
        ),
      ),
    );
  }
}
