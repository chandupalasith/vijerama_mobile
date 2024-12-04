import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // For showing toast messages
import 'package:qr_code_scanner/qr_code_scanner.dart'; // For QR scanning
import 'package:intl/intl.dart'; // For formatting date and time
import 'package:http/http.dart' as http; // For making API calls
import 'dart:convert'; // For decoding JSON
import 'constants/api_constants.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // Key for QR scanner
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // Function to handle QR code scanning
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      final userId = scanData.code; // Get the scanned QR code data

      if (userId != null) {
        // Stop the QR scanner to avoid multiple calls
        controller.pauseCamera();

        // Get the current date and time
        final now = DateTime.now();
        final formattedDate = DateFormat('MM/dd/yyyy').format(now);
        final formattedTime = DateFormat('HH:mm:ss').format(now);

        // Call the API
        final response = await _markAttendance(userId, formattedDate, formattedTime+':');

        // Handle the response
        if (response['message'] == "Attendance marked successfully") {
          _showSuccessPopup(context);
        } else {
          _showToast(response['message']);
          controller.resumeCamera(); // Resume the QR scanner on failure
        }
      }
    });
  }

  // Function to mark attendance by sending data to the API
  Future<Map<String, dynamic>> _markAttendance(String userId, String date, String time) async {
    const apiUrl = '${ApiConstants.baseUrl}/attendance/mark';
    final body = {
      'user_id': int.parse(userId), // Convert userId to an integer
      'date': date,
      'time': time,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Decode and return the response
      } else {
        return {'message': 'Failed to mark attendance'};
      }
    } catch (e) {
      return {'message': 'Error: $e'};
    }
  }

  // Function to show a success popup
  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Attendance marked successfully."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show a toast message
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Marking"),
        backgroundColor: Colors.red[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the QR view and text vertically
          children: [
            Container(
              width: 300, // Set square dimensions
              height: 300, // Set square dimensions
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            SizedBox(height: 16), // Add some spacing between the QR view and the text
            Text(
              'Scanning...',
              style: TextStyle(
                fontSize: 18, // Text size
                color: Colors.grey[700], // Text color
                fontWeight: FontWeight.bold, // Bold style
              ),
            ),
          ],
        ),
      ),
    );
  }
}