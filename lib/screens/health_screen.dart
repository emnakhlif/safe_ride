import 'package:flutter/material.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/images/health_logo.png', width: 80, height: 80),
            ),
            SizedBox(height: 30), // Increased spacing
            _buildHealthItem(
              'assets/images/lung.png',
              'Your oxygen saturation',
              '97%',
              'very good',
            ),
            SizedBox(height: 20), // Increased spacing
            _buildHealthItem(
              'assets/images/heart_rate.png',
              'Your heart rate',
              '80%',
              '',
            ),
            SizedBox(height: 20), // Increased spacing
            _buildHealthItem(
              'assets/images/alcohol.png',
              'Your alcohol level is very low',
              'You can ride',
              '',
            ),
            SizedBox(height: 40), // Increased spacing
            Text(
              'Reminder:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12), // Increased spacing
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Don\'t forget to drink water!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Image.asset('assets/images/water.png', width: 40, height: 40), // Slightly larger icon
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthItem(String imagePath, String title, String value, String description) {
    return Row(
      children: [
        Image.asset(imagePath, width: 40, height: 40),
        SizedBox(width: 20), // Increased spacing
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (description.isNotEmpty)
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
