import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // After saving data, navigate to HomeScreen

class PersonalInformationsScreen extends StatefulWidget {
  final User user;  // Pass user object from Firebase Authentication

  PersonalInformationsScreen({required this.user});

  @override
  _PersonalInformationsScreenState createState() =>
      _PersonalInformationsScreenState();
}

class _PersonalInformationsScreenState
    extends State<PersonalInformationsScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _emergencyController = TextEditingController();
  final _healthController = TextEditingController();

  String _selectedBloodType = 'A+';
  final _formKey = GlobalKey<FormState>();

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _dbRef.child(widget.user.uid).set({
          'name': _nameController.text,
          'phone_number': _phoneController.text,
          'age': _ageController.text,
          'blood_type': _selectedBloodType,
          'health_info': _healthController.text,
          'emergency_number': _emergencyController.text,
        });

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
