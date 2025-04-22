import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GoalsScreen extends StatelessWidget {
  // Firebase reference to fetch distance data
  final DatabaseReference _goalRef = FirebaseDatabase.instance.ref('users/your_user_id/distance_traveled');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goal'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: _buildGoalDialog(context),
      ),
    );
  }

  // Builds the dialog showing the goal progress and a button
  Widget _buildGoalDialog(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: _goalRef.onValue,  // Listen for real-time updates
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();  // Show loading indicator
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return Text('No data available');
        }

        final distanceTraveled = snapshot.data!.snapshot.value as double;  // Get the distance from Firebase
        final goalDistance = 100.0;  // Set your goal (e.g., 100 km)

        // Calculate progress
        double progress = (distanceTraveled / goalDistance) * 100;

        return Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(0xFF3A6186),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'You have achieved your objective of ${distanceTraveled.toStringAsFixed(1)} km.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              // Show the goal progress in percentage
              LinearProgressIndicator(
                value: progress / 100,  // Update progress bar based on data
                backgroundColor: Colors.white30,
                color: Colors.green,
              ),
              SizedBox(height: 16),
              Text(
                '${progress.toStringAsFixed(1)}% of your goal reached',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Handle "Click Me" action (e.g., navigating to another screen)
                },
                child: Text('Click Me'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF3A6186),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Handle "Secondary Action"
                },
                child: Text(
                  'Secondary Action',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
