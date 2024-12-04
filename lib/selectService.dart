import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services/auth_service.dart';
import 'mainlogin.dart'; // Import your Dhamma school screen
import 'qrScan.dart';
import 'webview_screen.dart'; // Import WebViewScreen
import 'package:vajirarama/UserPermission.dart';
import 'registerScreen.dart';
import 'showQR.dart';
import 'constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'attendance_report.dart';

class SelectServiceScreen extends StatefulWidget {
  @override
  _SelectServiceScreenState createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  bool showLibraryButton = false;
  bool showDhammaSchoolButton = false;
  bool showViewQRCodeButton = false;
  bool showScanQRCodeButton = false;
  bool showrReportButton = false;
  String useremail = '';

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final userId = await AuthService.getUserId(); // Assuming this function gets the stored user ID

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/user/user/$userId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = data['data']['user'];
      final libMemberOpen = data['data']['libMemberOpen'];
      final libMemberStudent = data['data']['libMemberStudent'];
      final libMemberThero = data['data']['libMemberThero'];
      final dammaStudent = data['data']['dhamStudent'];
      final dhamTeacher = data['data']['dhamTeacher'];
      final dhamStaff = data['data']['dhamStaff'];
      final email = data['data']['user']['email'];
      useremail = email;

      setState(() {
        showLibraryButton = libMemberOpen != null || libMemberStudent != null || libMemberThero != null;
        showDhammaSchoolButton = dammaStudent != null;
        showViewQRCodeButton = dammaStudent != null;
        showScanQRCodeButton = dhamStaff != null || dhamTeacher != null;
        showrReportButton = dhamStaff != null || dhamTeacher != null;
      });
    } else {
      print('Failed to fetch user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Service'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select an Option'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit Profile'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen(email: useremail)),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                          onTap: () async {
                            await AuthService.logout();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MainLogin()),
                                  (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/liblogo.jpeg',
              height: 150,
            ),
            SizedBox(height: 16),
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

            // Display Library button conditionally
            if (showLibraryButton)
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(url: 'https://opac.vajirarama.lk'), // Add your Library URL
                      ),
                    );
                  },
                  child: Text('Library'),
                ),
              ),
            SizedBox(height: 10),

            if (showDhammaSchoolButton)
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(url: 'https://ab56-192-248-22-102.ngrok-free.app'), // Add your Dhamma School URL
                      ),
                    );
                  },
                  child: Text('Dhamma School'),
                ),
              ),
            SizedBox(height: 10),

            if (showViewQRCodeButton)
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRShow()),
                    );
                  },
                  child: Text('View QR Code'),
                ),
              ),
            SizedBox(height: 10),
            if (showScanQRCodeButton)
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRScreen()),
                    );
                  },
                  child: Text('Scan QR Code'),
                ),
              ),
            SizedBox(height: 10),

            if (showrReportButton)
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AttendanceScreen()),
                    );
                  },
                  child: Text('View Attendance'),
                ),
              ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}