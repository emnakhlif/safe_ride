import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WeeklyDistanceScreen extends StatelessWidget {
  final DatabaseReference _distanceRef =
      FirebaseDatabase.instance.ref('users/userId1/weekly_distance'); // Path to user's weekly distance data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Distance'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle "New" action (e.g., reset or add new data)
            },
            child: Text(
              'New',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bar Chart for Weekly Distance
            _buildBarChart(),
            SizedBox(height: 20),
            // Average Activity
            Text(
              'Average activity: 17.5km/day',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Daily Distance List
            _buildDailyDistanceList(),
          ],
        ),
      ),
    );
  }

  // Bar Chart for Weekly Distance (using StreamBuilder to get data)
  Widget _buildBarChart() {
    return StreamBuilder<DatabaseEvent>(
      stream: _distanceRef.onValue, // Listen for real-time updates
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading while fetching data
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return Text('No data available');
        }

        final data = snapshot.data!.snapshot.value as Map;
        List<double> dailyDistances = [];
        List<String> days = ['M', 'T', 'W', 'TH', 'F', 'SA', 'SU'];

        data.forEach((key, value) {
          dailyDistances.add(double.parse(value.replaceAll('km', '')));
        });

        double maxDistance = dailyDistances.reduce((a, b) => a > b ? a : b);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (index) {
            double barHeight = (dailyDistances[index] / maxDistance) * 150;
            return Column(
              children: [
                Container(
                  width: 20,
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: Color(0xFF3A6186), // Bar color
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                ),
                SizedBox(height: 8),
                Text(days[index]),
              ],
            );
          }),
        );
      },
    );
  }

  // List of Daily Distances (using StreamBuilder to get data)
  Widget _buildDailyDistanceList() {
    return StreamBuilder<DatabaseEvent>(
      stream: _distanceRef.onValue, // Listen for real-time updates
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading while fetching data
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return Text('No data available');
        }

        final data = snapshot.data!.snapshot.value as Map;
        List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        List<String> distances = [];
        data.forEach((key, value) {
          distances.add(value); // Get distance data for each day
        });

        return Column(
          children: List.generate(7, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 10, color: Color(0xFF3A6186)),
                  SizedBox(width: 16),
                  Text(days[index]),
                  Spacer(),
                  Text(distances[index]),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
