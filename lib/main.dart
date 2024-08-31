import 'dart:io'; // Import the Dart IO library for handling HTTP and other IO operations
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import the login screen widget

// Custom class to override the default HTTP behavior, particularly for handling SSL certificate issues
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Override the default certificate validation to allow self-signed or untrusted certificates
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // Apply the custom HTTP override globally to handle SSL certificate issues
  HttpOverrides.global = MyHttpOverrides();
  
  // Run the main application
  runApp(const MyApp()); // Replace 'MyApp' with your app's main class if different
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Watch', // Set the title of the application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define the primary color theme of the app
      ),
      home: LoginScreen(), // Set the login screen as the initial screen to be displayed
    );
  }
}
