import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  final String userType;

  FormScreen({required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form for $userType'),
      ),
      body: Center(
        child: Text('Form Screen for $userType'),
      ),
    );
  }
}
