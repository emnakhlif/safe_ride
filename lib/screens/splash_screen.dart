import 'package:flutter/material.dart';
import 'package:safe_ride/screens/login_screen.dart';
import 'package:safe_ride/screens/home_screen.dart'; // Import HomeScreen
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check if user is logged in on SplashScreen
  }

  // Function to check if the user is logged in
  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Wait for 2 seconds for splash

    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If the user is logged in, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // If the user is not logged in, navigate to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/logo.png', // Update with your logo image path
              width: 400,
              height: 400,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Text
            const Text(
              'Your Shield on the Road',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF2D4356),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Next Button (Optional, can be removed since we have automatic navigation)
            ElevatedButton(
              onPressed: () {
                _checkLoginStatus(); // Manually call this if needed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D4356),
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
