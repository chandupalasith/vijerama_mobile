import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import the qr_flutter package

class QRShow extends StatefulWidget {
  @override
  _QRShowState createState() => _QRShowState();
}

class _QRShowState extends State<QRShow> {
  String userId = ''; // Variable to store the user ID

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Load user ID when the widget is initialized
  }

  // Asynchronous function to load user ID from SharedPreferences
  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id')?.toString(); // Fetch user ID from SharedPreferences
    if (id != null) {
      setState(() {
        userId = id; // Update the userId state with the retrieved value
      });
    } else {
      setState(() {
        userId = 'Unknown'; // Default value if no user ID is found
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your QR"),
        backgroundColor: Colors.red[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the QR code dynamically based on the user ID
            userId != 'Unknown' // Only show the QR code if userId is valid
                ? QrImageView(
        data: userId.toString(),
          version: QrVersions.auto,
          size: 300.0,
        )
                : CircularProgressIndicator(), // Show loading indicator if userId is not loaded yet

            SizedBox(height: 20), // Add space between the QR code and the text

            // Centered Text Below the QR Code
            /*Text(
              "ID: $userId", // Display the user ID
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),*/
          ],
        ),
      ),
    );
  }
}