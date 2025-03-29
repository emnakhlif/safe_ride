
import 'package:flutter/material.dart';
import 'create_account_screen.dart';
import 'package:safe_ride/screens/personal_informations_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
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
              ],
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalInformationsScreen()), // ✅ Navigates to Personal Information screen
                );
              },
              child: const Text('Log In'),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // Add forgot password navigation here
              },
              child: const Text('Forgot your password?'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to CreateAccountScreen
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

