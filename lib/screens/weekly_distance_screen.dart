import 'package:flutter/material.dart';

class WeeklyDistanceScreen extends StatelessWidget {
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
              // Handle "New" action
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
            _buildBarChart(),
            SizedBox(height: 20),
            Text(
              'Average activity: 17.5km/day',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildDailyDistanceList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    List<double> dailyDistances = [20, 15, 20, 15, 21, 15, 20];
    List<String> days = ['M', 'T', 'W', 'TH', 'F', 'SA', 'SU'];

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
                color: Color(0xFF3A6186), // Corrected color here
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
            SizedBox(height: 8),
            Text(days[index]),
          ],
        );
      }),
    );
  }

  Widget _buildDailyDistanceList() {
    List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    List<String> distances = ['20km', '15km', '20km', '15km', '21km', '15km', '20km'];

    return Column(
      children: List.generate(7, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.circle, size: 10, color: Color(0xFF3A6186)), // Corrected color here
              SizedBox(width: 16),
              Text(days[index]),
              Spacer(),
              Text(distances[index]),
            ],
          ),
        );
      }),
    );
  }
}
