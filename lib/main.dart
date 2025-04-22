import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home_screen.dart';
import 'screens/create_account_screen.dart'; // Import Create Account screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Ensure Firebase is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Ride',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2D4356),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: _getInitialScreen(),
    );
  }

  // Function to check if the user is logged in and return the appropriate screen
  Widget _getInitialScreen() {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      return const HomeScreen(); // If the user is logged in, show the HomeScreen
    } else {
      return const CreateAccountScreen(); // Otherwise, show the CreateAccountScreen
    }
  }
}

