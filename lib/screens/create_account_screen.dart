
import 'package:flutter/material.dart';
import 'package:safe_ride/screens/personal_informations_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _newsletter = false; // ✅ Declare & Initialize the variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalInformationsScreen()), // ✅ Navigates to Personal Information screen
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

