import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'responsive_layout.dart';  // Import the responsive layout
import 'custom_analytics_button.dart'; // Import the custom button
import 'custom_feedback_button.dart'; // Import the custom feedback button

class AnalyticsScreen extends StatefulWidget {
  final String apiKey;

  // Constructor to initialize the screen with an API key
  AnalyticsScreen({required this.apiKey});

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  double _cpuUsage = 0.0;
  double _ramUsage = 0.0;

  @override
  void initState() {
    super.initState();
    _startPolling(); // Start polling for CPU and RAM usage data
  }

  // Function to periodically read the CPU and RAM usage from a file
  void _startPolling() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      final file = File('cpu_ram_data.txt'); // The file containing the CPU and RAM usage data
      if (await file.exists()) {
        final contents = await file.readAsString(); // Read the file as a string
        final lines = contents.split('\n'); // Split the file content into lines

        // Update the CPU and RAM usage state with the parsed values
        setState(() {
          _cpuUsage = double.parse(lines[0].split(':')[1].trim());
          _ramUsage = double.parse(lines[1].split(':')[1].trim());
        });
      }
    });       
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: _buildMobileLayout(),
      tabletDesktopLayout: _buildTabletDesktopLayout(),
    );
  }

  // Mobile layout for smaller screens
  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Analytics'), // Title of the app bar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUsageCircle('CPU', _cpuUsage), // Display CPU usage as a circular progress indicator
          const SizedBox(height: 20),
          _buildUsageCircle('RAM', _ramUsage), // Display RAM usage as a circular progress indicator
        ],
      ),
    );
  }

  // Tablet and desktop layout for larger screens
  Widget _buildTabletDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar with navigation buttons
          Container(
            width: 250, // Sidebar width
            decoration: const BoxDecoration(
              color: Color(0xFF2C2F76), // Background color similar to the image
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0), // Padding inside the sidebar
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the elements
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'lib/assets/image2.png', // Path to the Wi-Jungle logo
                        width: 150, // Size of the logo
                      ),
                      const SizedBox(height: 50), // Space between logo and button
                      CustomAnalyticsButton(
                        onPressed: () {
                          // Handle the button press
                        },
                      ),
                    ],
                  ),
                  CustomFeedbackButton(
                    onPressed: () {
                      // Handle the feedback button press
                    },
                  ),
                ],
              ),
            ),
          ),
          // Main content area
          Expanded(
            child: Column(
              children: [
                // Top Bar with greeting text and user profile picture
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Analytics', // Title text
                        style: TextStyle(
                          fontSize: 28, // Adjusted font size for better visibility
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Hello', // Greeting text
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'User', // User name text
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('lib/assets/profile.png'), // Path to the user image
                            radius: 20, // Size of the profile picture
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Analytics Content displaying CPU and RAM usage
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildUsageCircle('CPU', _cpuUsage), // Display CPU usage
                          ],
                        ),
                      ),
                      const SizedBox(width: 100), // Increased spacing between CPU and RAM
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildUsageCircle('RAM', _ramUsage), // Display RAM usage
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the circular usage indicator for CPU and RAM
  Widget _buildUsageCircle(String label, double value) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 260, // Size of the circular progress indicator
          height: 260, // Size of the circular progress indicator
          child: CircularProgressIndicator(
            value: value / 100, // The usage value as a percentage
            strokeWidth: 22, // Thicker boundary for the circle
            backgroundColor: Colors.grey[300], // Background color of the progress indicator
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${value.toStringAsFixed(0)}%', // Display the percentage value
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold), // Make the percentage text bold and bigger
            ),
            Text(
              label, // Display the label (CPU or RAM)
              style: const TextStyle(fontSize: 20, color: Colors.black54), // Adjusted font size for better visibility
            ),
          ],
        ),
      ],
    );
  }
}
