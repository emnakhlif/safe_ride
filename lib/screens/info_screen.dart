import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView for scrolling
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/images/1st_aid.png', width: 100, height: 100), // Add the image here
            ),
            SizedBox(height: 16),
            Text(
              'First aid list',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildInfoText(
              '1. Assess the Situation',
              [
                'Stay calm and ensure the area is safe for both you and the injured person.',
                'Do not move the person unless there is an immediate danger (e.g., fire, risk of explosion).',
              ],
            ),
            SizedBox(height: 16),
            _buildInfoText(
              '2. Unconscious Person (Not Breathing)',
              [
                'Check for breathing and pulse.',
                'If not breathing, start CPR:',
                '  - Chest compressions: Push hard and fast (100-120 compressions per minute).',
                '  - Rescue breaths: Give two breaths after every 30 compressions.',
                '  - Continue until help arrives.',
              ],
            ),
            SizedBox(height: 16),
            _buildInfoText(
              '3. Bleeding Wounds',
              [
                'Apply direct pressure with a clean cloth or bandage.',
                'Elevate the injured limb (if possible).',
                'Apply a bandage, but avoid tying too tightly.',
              ],
            ),
            SizedBox(height: 16),
            _buildInfoText(
              '4. Burns',
              [
                'First-degree burns (red skin, no blisters): Cool the burn with running water for 10-15 minutes.',
                'Second/third-degree burns (blisters, white or charred skin): Do not pop blisters or apply ice. Cover the burn with a sterile, non-stick bandage and seek medical help.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String title, List<String> paragraphs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...paragraphs.map((paragraph) => Text(paragraph)).toList(),
      ],
    );
  }
}