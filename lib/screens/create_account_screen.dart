import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'personal_informations_screen.dart'; // Your next screen

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  bool _newsletter = false;

  // Firebase instances for Auth and Database
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');

  // Handle account creation and data saving
  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user using Firebase Authentication
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // Store additional user information in Firebase Realtime Database
        await _dbRef.child(userCredential.user!.uid).set({
          'name': _name,
          'email': _email,
          'newsletter': _newsletter,
        });

        // Navigate to the Personal Information screen after account creation
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonalInformationsScreen()),
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
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => _password = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
              ),
              const SizedBox(height: 16.0),
              // Newsletter Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _newsletter,
                    onChanged: (bool? value) {
                      setState(() {
                        _newsletter = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                        'I would like to receive your newsletter and other promotional information.'),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              // Create Account Button
              ElevatedButton(
                onPressed: _createAccount,
                child: const Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
