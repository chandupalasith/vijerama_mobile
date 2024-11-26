import 'package:flutter/material.dart';
import 'form_screen.dart';

class UserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormScreen(userType: 'Member')),
                );
              },
              child: Text('Member'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormScreen(userType: 'Bikku')),
                );
              },
              child: Text('Bikku'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormScreen(userType: 'Student')),
                );
              },
              child: Text('Student'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormScreen(userType: 'Contribution and Donation')),
                );
              },
              child: Text('Contribution and Donation'),
            ),
          ],
        ),
      ),
    );
  }
}
