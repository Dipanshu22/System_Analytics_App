import 'package:flutter/material.dart';

// A custom feedback button widget that uses an icon and text
class CustomFeedbackButton extends StatelessWidget {
  // The callback function that will be triggered when the button is pressed
  final VoidCallback onPressed;

  // Constructor to initialize the onPressed callback
  CustomFeedbackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed, // Trigger the callback when the button is pressed
      icon: const Icon(
        Icons.feedback, // Feedback icon to be displayed on the button
        color: Colors.white, // Set the color of the icon to white
      ),
      label: const Text(
        'Feedback', // The text label for the button
        style: TextStyle(
          color: Colors.white, // Set the text color to white
          fontSize: 16, // Set the text size
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Set the button's background color to transparent
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners for the button
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20, // Horizontal padding inside the button
          vertical: 10,   // Vertical padding inside the button
        ),
      ),
    );
  }
}
