import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_ride/screens/personal_informations_screen.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();  // Controller for email
  final _passwordController = TextEditingController();  // Controller for password
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Handle login
  Future<void> _login() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to Personal Information screen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PersonalInformationsScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log in: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email input field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),

            // Password input field
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: _obscureText,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Text(_obscureText ? 'Show' : 'Hide'),
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // Log in button
            ElevatedButton(
              onPressed: _login, // Handle login action
              child: const Text('Log In'),
            ),
            const SizedBox(height: 8.0),

            // Forgot password button (optional)
            TextButton(
              onPressed: () {
                // Handle forgot password navigation here
              },
              child: const Text('Forgot your password?'),
            ),
            const SizedBox(height: 8.0),

            // Navigate to Create Account screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                );
              },
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
