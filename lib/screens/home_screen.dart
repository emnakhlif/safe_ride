import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'goals_screen.dart';
import 'health_screen.dart';
import 'weekly_distance_screen.dart';
import 'package:url_launcher/url_launcher.dart';

// Assuming you have LoginPage and InfoPage created
import 'login_screen.dart'; // Replace with your actual login page file
import 'info_screen.dart'; // Replace with your actual info page file

class HomeScreen extends StatelessWidget {
  // Firebase references for real-time data
  final DatabaseReference _alcoholRef = FirebaseDatabase.instance.ref('sensor_data/alcohol');
  final DatabaseReference _heartRateRef = FirebaseDatabase.instance.ref('sensor_data/max30100');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Safe Ride Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(context, 'Helmet Battery', 'assets/images/battery.png', _buildHelmetChargeStatus()),
            SizedBox(height: 16),
            _buildSection(context, 'Speed & Navigation', 'assets/images/speed.png', _buildVelocityNavigation(context)),
            SizedBox(height: 16),
            _buildSection(context, 'Health Metrics', 'assets/images/heart.png', _buildHealthMetrics(context)),
            SizedBox(height: 16),
            _buildSection(context, 'Distance Traveled', 'assets/images/distance.png', _buildDistanceTraveled(context)),
            SizedBox(height: 16),
            _buildSection(context, 'Weekly Goal', 'assets/images/goal.png', _buildWeeklyGoal(context)),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Back'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoScreen()),
                    );
                  },
                  child: Image.asset('assets/images/info.png', width: 40, height: 40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String imagePath, Widget content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imagePath, width: 40, height: 40),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF3A6186),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHelmetChargeStatus() {
    double batteryPercentage = 85;
    return ListTile(
      title: Text('Helmet Battery'),
      subtitle: Text('$batteryPercentage% Remaining'),
    );
  }

  Widget _buildVelocityNavigation(BuildContext context) {
    double velocity = 25;
    return ListTile(
      title: Text('Current Speed: $velocity km/h'),
      subtitle: Text('Tap to navigate on Google Maps'),
      onTap: () async {
        const url = 'http://google.com/maps';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch Google Maps')),
          );
        }
      },
    );
  }

  Widget _buildHealthMetrics(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: _heartRateRef.onValue, // Listen for heart rate changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return Text('No data available');
        }

        final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
        final timestamp = data.keys.first; // Get the first timestamp key
        final ir = data[timestamp]['ir'];
        final red = data[timestamp]['red'];

        return ListTile(
          title: Text('Heart Rate: $ir'),
          subtitle: Text('Red: $red\nTimestamp: $timestamp'),
        );
      },
    );
  }

  Widget _buildDistanceTraveled(BuildContext context) {
    double distanceToday = 12.5;
    return ListTile(
      title: Text('Distance Traveled: $distanceToday km'),
      subtitle: Text('Tap to see weekly progress'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WeeklyDistanceScreen()),
        );
      },
    );
  }

  Widget _buildWeeklyGoal(BuildContext context) {
    double weeklyGoal = 100;
    return ListTile(
      title: Text('Weekly Goal: $weeklyGoal km'),
      subtitle: Text('Tap to set or modify your goal'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoalsScreen()),
        );
      },
    );
  }
}

