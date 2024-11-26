import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import your login screen
import 'dhamma_school_screen.dart';
import 'webview_screen.dart';
import 'package:vajirarama/UserPermission.dart';// Import your Dhamma school screen

class SelectServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/liblogo.jpeg', // Replace with your image asset path
              height: 150, // Adjust the height as needed
            ),
            SizedBox(height: 16), // Add space between image and text
            Text(
              'Welcome to Vajirarama',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Select Your Service',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.blueGrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 23),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => UserPermission()),
                  );
                },
                child: Text('Library'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DhammaSchoolScreen()),
                  );
                },
                child: Text('Dhamma School'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
