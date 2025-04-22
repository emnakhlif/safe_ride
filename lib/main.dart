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
      home: const _SplashScreen(), // Add a SplashScreen to handle async loading
    );
  }
}

// SplashScreen to check for Firebase authentication state before showing HomeScreen or CreateAccountScreen
class _SplashScreen extends StatefulWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Check if the user is logged in
  Future<void> _checkLoginStatus() async {
    // Check Firebase Auth user state asynchronously
    User? user = FirebaseAuth.instance.currentUser;

    await Future.delayed(const Duration(seconds: 2)); // Optional: Add some delay for splash effect

    // Navigate to the appropriate screen based on login status
    if (user != null) {
      // If the user is logged in, navigate to the HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // If the user is not logged in, navigate to CreateAccountScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a splash screen while the authentication state is checked
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show loading indicator during Firebase initialization
      ),
    );
  }
}
