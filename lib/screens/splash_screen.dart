import 'package:flutter/material.dart';
import 'package:safe_ride/screens/login_screen.dart';



class SplashScreen extends StatelessWidget {

  const SplashScreen({Key? key}) : super(key: key);



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

// Logo Safe Ride

            Image.asset(

              'assets/images/logo.png', // Changez cette ligne pour correspondre au nom exact du fichier

              width: 400,

              height: 400,

              fit: BoxFit.contain,

            ), const SizedBox(height: 20),

// Texte

            const Text(

              'Your Shield on the Road',

              style: TextStyle(

                fontSize: 24,

                color: Color(0xFF2D4356),

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 40),

// Bouton Next

            ElevatedButton(

              onPressed: () {

                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(builder: (context) => LoginScreen()),



                );

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