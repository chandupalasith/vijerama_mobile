import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants/api_constants.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final String _apiUrl = '${ApiConstants.baseUrl}/school/attendance-data';

  // All attendance data fetched from the API
  List<Map<String, dynamic>> _attendanceData = [];

  // Filtered data based on user selections
  List<Map<String, dynamic>> _filteredData = [];

  // Selected filters
  String? _selectedGrade;
  String? _selectedDate;

  // Predefined grades list
  final List<String> _grades = List<String>.generate(11, (index) => '${index + 1}');

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  // Function to fetch attendance data from the API
  Future<void> _fetchAttendanceData() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        setState(() {
          _attendanceData = List<Map<String, dynamic>>.from(responseData['data']);
          _filteredData = _attendanceData;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching data.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    }
  }

  // Function to filter data based on selected grade and date
  void _applyFilters() {
    setState(() {
      _filteredData = _attendanceData.where((entry) {
        final matchesGrade = _selectedGrade == null || entry['grade'] == _selectedGrade;
        final matchesDate = _selectedDate == null || entry['date'] == _selectedDate;
        return matchesGrade && matchesDate;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Data'),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Grade Dropdown
                DropdownButton<String>(
                  value: _selectedGrade,
                  hint: Text('Select Grade'),
                  items: _grades
                      .map((grade) => DropdownMenuItem<String>(
                    value: grade,
                    child: Text('Grade $grade'),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGrade = value;
                      _applyFilters();
                    });
                  },
                ),
                // Date Picker
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate =
                        '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                        _applyFilters();
                      });
                    }
                  },
                  child: Text(_selectedDate ?? 'Select Date'),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Attendance List
            Expanded(
              child: _filteredData.isEmpty
                  ? Center(child: Text('No data available'))
                  : ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                  final item = _filteredData[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${item['email']}'),
                          Text('Grade: ${item['grade']}'),
                          Text('Date: ${item['date']}'),
                          Text('Time: ${item['time']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}