import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'selectService.dart';
import 'mainlogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vijerama',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: _checkIfLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator
          }
          if (snapshot.data == true) {
            return SelectServiceScreen(); // User is logged in
          }
          return MainLogin(); // User is not logged in
        },
      ),
    );
  }

  Future<bool> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // If not set, return false
  }
}