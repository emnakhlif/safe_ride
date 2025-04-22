import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Assuming HomeScreen is where we navigate to after saving data

class PersonalInformationsScreen extends StatefulWidget {
  @override
  _PersonalInformationsScreenState createState() =>
      _PersonalInformationsScreenState();
}

class _PersonalInformationsScreenState
    extends State<PersonalInformationsScreen> {
  // Firebase reference for storing user data
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');

  final _nameController = TextEditingController();
  final _familyNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _emergencyController = TextEditingController();
  final _healthController = TextEditingController();

  String _selectedBloodType = 'A+'; // Default blood type
  final _formKey = GlobalKey<FormState>();

  // Function to save data to Firebase Realtime Database
  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Get the current user from Firebase Authentication
        User? user = FirebaseAuth.instance.currentUser;

        // Save user data to Firebase Realtime Database
        await _dbRef.child(user!.uid).set({
          'name': _nameController.text,
          'family_name': _familyNameController.text,
          'phone_number': _phoneController.text,
          'age': _ageController.text,
          'emergency_number': _emergencyController.text,
          'blood_type': _selectedBloodType,
          'about_health': _healthController.text,
        });

        // Navigate to the HomeScreen after saving data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Informations'),
        actions: [
          TextButton(
            onPressed: _saveUserData, // Save user data when "OK" button is pressed
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Image Placeholder
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              _buildInputField('Name', _nameController),
              SizedBox(height: 16.0),
              _buildInputField('Family Name', _familyNameController),
              SizedBox(height: 16.0),
              _buildInputField('Phone Number', _phoneController),
              SizedBox(height: 16.0),
              _buildInputField('Age', _ageController),
              SizedBox(height: 16.0),
              _buildInputField('Emergency Number', _emergencyController),
              SizedBox(height: 16.0),
              _buildDropdownField('Blood Type', ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']),
              SizedBox(height: 16.0),
              _buildInputField('About your Health', _healthController, maxLines: 3),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _saveUserData,
                child: Text('Save Information'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Text Form Field Widget for input fields
  Widget _buildInputField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      maxLines: maxLines,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Dropdown for blood type selection
  Widget _buildDropdownField(String label, List<String> items) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          value: _selectedBloodType,
          onChanged: (newValue) {
            setState(() {
              _selectedBloodType = newValue!;
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


