import 'package:flutter/material.dart';
import 'webview_screen.dart';
import 'button_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
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
              'Library Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebViewScreen(url: 'https://www.imigap.com')),
                  );
                },
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ButtonScreen()),
                  );
                },
                child: Text('Register'),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebViewScreen(url: 'https://www.example.com/contribution')),
                  );
                },
                child: Text('Contribution & Donation'),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
