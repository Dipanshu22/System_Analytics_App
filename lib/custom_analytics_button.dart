import 'package:flutter/material.dart';

// Custom button widget for "Analytics"
class CustomAnalyticsButton extends StatelessWidget {
  final VoidCallback onPressed; // Callback function to handle button press

  // Constructor to initialize the onPressed callback
  CustomAnalyticsButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the button
        borderRadius: BorderRadius.circular(20), // Rounded corners for the button
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 4.0, // How much the shadow should blur
            offset: Offset(0, 2), // Position of the shadow (x, y)
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25), // Padding inside the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Match the button's border radius
          ),
          backgroundColor: Colors.white, // Set the button's background color
        ),
        onPressed: onPressed, // Trigger the callback when the button is pressed
        child: Row(
          mainAxisSize: MainAxisSize.min, // Ensure the button's width is only as wide as its content
          children: [
            Image.asset(
              'lib/assets/image3.png', // Path to the icon image asset
              width: 30, // Set the width of the icon
              height: 30, // Set the height of the icon
            ),
            const SizedBox(width: 10), // Space between the icon and the text
            const Text(
              'Analytics',
              style: TextStyle(
                color: Color(0xFF1A1422), // Set the color of the text
                fontSize: 20, // Set the size of the text
                fontWeight: FontWeight.w600, // Set the weight (boldness) of the text
                fontFamily: 'YourFontFamily', // Optional: set a custom font family
              ),
            ),
          ],
        ),
      ),
    );
  }
}
