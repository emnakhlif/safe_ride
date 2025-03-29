/*import 'package:flutter/material.dart';

class GoalsScreen extends StatelessWidget {
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
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9, // Adjust width as needed
          height: MediaQuery.of(context).size.width * 0.9, // Make it square
          decoration: BoxDecoration(
            color: Color(0xFF3A6186),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Congratulations!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'you have attend your objective of 20Km',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Click Me" action
                    },
                    child: Text('Click Me'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Handle "Secondary Action"
                    },
                    child: Text('Secondary Action'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

class GoalsScreen extends StatelessWidget {
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

  Widget _buildGoalDialog(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85, // Slightly wider
      padding: EdgeInsets.all(24), // Increased padding
      decoration: BoxDecoration(
        color: Color(0xFF3A6186),
        borderRadius: BorderRadius.circular(12), // Slightly more rounded corners
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Congratulations!',
            style: TextStyle(
              fontSize: 28, // Larger font
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text
            ),
          ),
          SizedBox(height: 20), // Increased spacing
          Text(
            'you have attend your objective of 20Km',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18, // Slightly larger font
              color: Colors.white, // White text
            ),
          ),
          SizedBox(height: 32), // Increased spacing
          ElevatedButton(
            onPressed: () {
              // Handle "Click Me" action
            },
            child: Text(
              'Click Me',
              style: TextStyle(fontSize: 16), // Slightly larger font
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 14), // Slightly larger button
              backgroundColor: Colors.white, // White background
              foregroundColor: Color(0xFF3A6186), // Blue text
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              // Handle "Secondary Action"
            },
            child: Text(
              'Secondary Action',
              style: TextStyle(color: Colors.white), // White text
            ),
          ),
        ],
      ),
    );
  }
}
