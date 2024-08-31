import 'package:flutter/material.dart';

// A widget that provides a responsive layout depending on the screen size
class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;  // Widget to be displayed on mobile screens
  final Widget tabletDesktopLayout;  // Widget to be displayed on tablet/desktop screens

  ResponsiveLayout({required this.mobileLayout, required this.tabletDesktopLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // If the screen width is greater than 600 pixels, display the tablet/desktop layout
          return tabletDesktopLayout;
        } else {
          // Otherwise, display the mobile layout
          return mobileLayout;
        }
      },
    );
  }
}

// AdminDashboard class that uses ResponsiveLayout to adjust the UI based on the screen size
class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: _buildMobileLayout(),  // Layout for mobile screens
      tabletDesktopLayout: _buildTabletDesktopLayout(),  // Layout for tablet and desktop screens
    );
  }

  // Builds the layout for mobile screens
  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),  // App bar title
      ),
      drawer: Drawer(
        child: _buildSideMenu(),  // Side menu in a drawer for smaller screens
      ),
      body: _buildMainContent(),  // Main content area
    );
  }

  // Builds the layout for tablet and desktop screens
  Widget _buildTabletDesktopLayout() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),  // App bar title
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: _buildSideMenu(),  // Side menu that is always visible on larger screens
          ),
          Expanded(
            flex: 3,
            child: _buildMainContent(),  // Main content area
          ),
        ],
      ),
    );
  }

  // Builds the side menu for navigation
  Widget _buildSideMenu() {
    return ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,  // Background color of the drawer header
          ),
          child: Text(
            'Menu',  // Text inside the drawer header
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,  // Font size of the drawer header text
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),  // Icon for the Home menu item
          title: Text('Home'),  // Text for the Home menu item
          onTap: () {
            // Logic to navigate to the Home screen can be added here
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),  // Icon for the Settings menu item
          title: Text('Settings'),  // Text for the Settings menu item
          onTap: () {
            // Logic to navigate to the Settings screen can be added here
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_mail),  // Icon for the Contact Us menu item
          title: Text('Contact Us'),  // Text for the Contact Us menu item
          onTap: () {
            // Logic to navigate to the Contact Us screen can be added here
          },
        ),
      ],
    );
  }

  // Builds the main content area of the dashboard
  Widget _buildMainContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
        children: [
          Icon(Icons.dashboard, size: 100, color: Colors.red),  // A large dashboard icon
          SizedBox(height: 20),  // Space between the icon and the text
          Text(
            'Admin Content Area',  // Text below the icon
            style: TextStyle(fontSize: 24),  // Font size of the text
          ),
        ],
      ),
    );
  }
}
