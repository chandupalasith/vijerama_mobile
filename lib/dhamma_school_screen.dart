import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DhammaSchoolScreen extends StatefulWidget {
  @override
  _DhammaSchoolScreenState createState() => _DhammaSchoolScreenState();
}

class _DhammaSchoolScreenState extends State<DhammaSchoolScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    if (cameras != null && cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![0], // Use the first available camera
        ResolutionPreset.medium,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Camera Preview Box
            if (_isCameraInitialized && _cameraController != null)
              Container(
                width: 400,
                height: 500,
                margin: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CameraPreview(_cameraController!),
                ),
              )
            else
              Container(
                width: 300,
                height: 200,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: Center(
                  child: Text(
                    "Loading Camera...",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ),

            // Centered Text Below the Camera
            Text(
              "Scanning...",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}