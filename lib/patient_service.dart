import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchPatients() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/patients'),
  );
  if (response.statusCode == 200) {
    // Handle response data
  } else {
    throw Exception('Failed to fetch patients');
  }
}
