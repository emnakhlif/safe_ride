
import 'package:flutter/material.dart';
import 'home_screen.dart'; // 🔵 Import HomeScreen

class PersonalInformationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Informations'),
        actions: [ // 🔵 "OK" button at the top
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()), // 🔵 Navigate to HomeScreen
              );
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue, // 🔵 Blue background
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          SizedBox(width: 10), // Space before the app bar title
        ],
      ),
      body: SingleChildScrollView( // Make the content scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.grey[300], // Placeholder color
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 70, // Adjust the radius as needed
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with your image
                ),
              ),
            ),
            SizedBox(height: 24.0),
            _buildInputField('Name'),
            SizedBox(height: 16.0),
            _buildInputField('Family Name'),
            SizedBox(height: 16.0),
            _buildInputField('Phone Number'),
            SizedBox(height: 16.0),
            _buildInputField('Age'),
            SizedBox(height: 16.0),
            _buildInputField('Emergency Number'),
            SizedBox(height: 16.0),

            // 🔴 Blood Type Dropdown Field
            _buildDropdownField('Blood Type', ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']),
            SizedBox(height: 16.0),

            _buildInputField('About your Health', maxLines: 3), // Make it multiline
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Add logic for "Click Me" button
              },
              child: Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, {int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      maxLines: maxLines,
    );
  }

  // 🔴 Dropdown Field Widget for Blood Type
  Widget _buildDropdownField(String label, List<String> items) {
    String selectedValue = items[0]; // Default value

    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          value: selectedValue,
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        );
      },
    );
  }
}

