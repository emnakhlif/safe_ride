import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Navigate to HomeScreen after data is saved

class PersonalInformationsScreen extends StatefulWidget {
  final User user;

  // Constructor to pass the user object to this screen
  PersonalInformationsScreen({required this.user});

  @override
  _PersonalInformationsScreenState createState() =>
      _PersonalInformationsScreenState();
}

class _PersonalInformationsScreenState
    extends State<PersonalInformationsScreen> {
  // Firebase reference for storing user data
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');

  // Controllers for user input fields
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _emergencyController = TextEditingController();
  final _healthController = TextEditingController();

  String _selectedBloodType = 'A+'; // Default blood type
  final _formKey = GlobalKey<FormState>();

  // Save user data to Firebase
  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Save user data to Firebase Realtime Database
        await _dbRef.child(widget.user.uid).set({
          'name': _nameController.text,
          'phone_number': _phoneController.text,
          'age': _ageController.text,
          'blood_type': _selectedBloodType,
          'health_info': _healthController.text,
          'emergency_number': _emergencyController.text,
        });

        // Navigate to the HomeScreen after saving the data
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
        title: Text('Personal Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputField('Name', _nameController),
              SizedBox(height: 16.0),
              _buildInputField('Phone Number', _phoneController),
              SizedBox(height: 16.0),
              _buildInputField('Age', _ageController),
              SizedBox(height: 16.0),
              _buildInputField('Emergency Number', _emergencyController),
              SizedBox(height: 16.0),
              _buildDropdownField('Blood Type', ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']),
              SizedBox(height: 16.0),
              _buildInputField('Health Information', _healthController, maxLines: 3),
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

  // TextFormField widget for user input fields
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
