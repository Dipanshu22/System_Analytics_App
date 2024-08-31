import 'package:flutter/material.dart';
import 'analytics_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding
import 'responsive_layout.dart'; // Import the responsive layout

// This is the main LoginScreen widget, which is a StatefulWidget to handle state changes
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// This is the state class for the LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final TextEditingController _usernameController = TextEditingController(); // Controller for the username field
  final TextEditingController _passwordController = TextEditingController(); // Controller for the password field
  bool _isLoading = false; // State to show loading indicator during login process
  bool _isChecked = false; // Track the checkbox state

  // Function to handle the login process
  Future<void> _login() async {
    try {
      print("Login button pressed");
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Make a POST request to the login endpoint
      final response = await http.post(
        Uri.parse('https://mfatest.wijungle.com:9084/auth.php?type=login'),
        body: {
          'username': _usernameController.text,
          'password': _passwordController.text,
        },
      );

      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      // If login is successful, navigate to the AnalyticsScreen
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnalyticsScreen(apiKey: jsonResponse['key']),
            ),
          );
        } else {
          _showErrorDialog(jsonResponse['errors']); // Show error message if login fails
        }
      } else {
        _showErrorDialog('An error occurred. Please try again.'); // Show general error message for non-200 status
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Hide loading indicator in case of exception
      });
      _showErrorDialog('An exception occurred: $e'); // Show exception error message
      print("Exception: $e");
    }
  }

  // Function to display error messages in a dialog
  void _showErrorDialog(String? message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: Text(message ?? 'An unknown error occurred.'), // Ensure non-nullable String
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to check if the login button can be activated
  bool _canActivateButton() {
    final canActivate = _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isChecked;
    print("Can activate button: $canActivate");
    print("Username: ${_usernameController.text}, Password: ${_passwordController.text}, Checkbox: $_isChecked");
    return canActivate;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: _buildMobileLayout(), // Build layout for mobile devices
      tabletDesktopLayout: _buildTabletDesktopLayout(), // Build layout for tablets and desktops
    );
  }

  // Build the layout for mobile devices
  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView( // Allows scrolling when the keyboard is open
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              onChanged: () {
                setState(() {}); // Rebuild the form on any change
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  // Username input field
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username'; // Validation message
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Password input field
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: true, // Hide the password text
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password'; // Validation message
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Row containing the checkbox and terms text
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked, // Link the checkbox state
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                          print("Checkbox state: $_isChecked");
                        },
                      ),
                      Expanded(
                        child: Text(
                          'By continuing, you agree to Terms & Conditions and Privacy Policy.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Show loading indicator or login button
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _canActivateButton() ? _login : null, // Enable/Disable button
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: const Color(0xFF333333),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text('Log In', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build the layout for tablet and desktop devices
  Widget _buildTabletDesktopLayout() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 1200, // Fixed width for the content container
          child: Row(
            children: [
              // Left Section - Image/Graphics
              Expanded(
                flex: 2, // Takes up 2/5th of the screen width
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo at the top
                        Image.asset(
                          'lib/assets/image.png', // Path to your logo image
                          fit: BoxFit.contain,
                          width: 210, // Adjust width to match the design
                          height: 88, // Adjust height to match the design
                        ),
                        const SizedBox(height: 40), // Space between the logo and the graphic image
                        // Graphic image below the logo
                        Image.asset(
                          'lib/assets/image1.png', // Path to your graphic image
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Right Section - Login Form
              Expanded(
                flex: 3, // Takes up 3/5th of the screen width
                child: Center(
                  child: Card(
                    elevation: 10, // Add shadow for the card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners for the card
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Let's Secure Your PC",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Username input field
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.grey[600]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username'; // Validation message
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {}); // Rebuild form on text change
                            },
                          ),
                          const SizedBox(height: 20),
                          // Password input field
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.grey[600]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            obscureText: true, // Hide the password text
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password'; // Validation message
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {}); // Rebuild form on text change
                            },
                          ),
                          const SizedBox(height: 20),
                          // Row containing the checkbox and terms text
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked, // Link the checkbox state
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                  print("Checkbox state: $_isChecked");
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'By continuing, you agree to Terms & Conditions and Privacy Policy.',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[700]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          // Show loading indicator or login button
                          _isLoading
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _canActivateButton() ? _login : null, // Enable/Disable button
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                      backgroundColor: const Color(0xFF333333),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text('Log In',
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
