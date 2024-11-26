import 'package:flutter/material.dart';
import 'webview_screen.dart';

class ButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose an Option'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add space between image and text
            Text(
              'I am a',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
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
                child: Text('Member'),
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
                child: Text('Bikku'),
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
                child: Text('Student'),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
