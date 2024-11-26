import 'package:flutter/material.dart';

class UserPermission extends StatefulWidget {
  @override
  _UserPermissionState createState() => _UserPermissionState();
}

class _UserPermissionState extends State<UserPermission> {
  bool isPhysicalLibraryActive = true;
  bool isDhammaSchoolActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Permissions'),

      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16),

              child: Text(
                'Change Permissions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,

                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Physical Library Switch
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Physical Library",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    value: isPhysicalLibraryActive,
                    onChanged: (newValue) {
                      setState(() {
                        isPhysicalLibraryActive = newValue;
                      });
                    },
                    activeColor: Colors.redAccent[800],
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey[600],
                  ),
                ],
              ),
            ),


            // Dhamma School Switch
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dhamma School",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    value: isDhammaSchoolActive,
                    onChanged: (newValue) {
                      setState(() {
                        isDhammaSchoolActive = newValue;
                      });
                    },
                    activeColor: Colors.redAccent[800],
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}