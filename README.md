# System_Analytics_App

System Analytics App is a Flutter-based application designed to monitor and analyze system metrics like CPU and RAM usage. It features a responsive UI that adapts to both mobile and desktop layouts, providing an efficient way to track your system's performance. The application is integrated with a secure login system and offers real-time analytics.

## Cloning the Project

To get started with SecureWatch, you need to clone the repository to your local machine. Follow the steps below:

1. Open your terminal or command prompt.
2. Run the following command to clone the repository:

    ```bash
    git clone https://github.com/Dipanshu22/System_Analytics_App.git
    ```

3. Navigate to the project directory:

    ```bash
    cd SecureWatch
    ```

## Features

- **Responsive Design**: Optimized for both mobile and desktop platforms using a responsive layout.
- **Real-Time Analytics**: Monitors CPU and RAM usage, updating every 5 seconds.
- **Secure Login**: Implements a secure login system with terms and conditions agreement.
- **Custom Buttons**: Includes custom-designed buttons for Analytics and Feedback.
- **User Profile**: Displays user information with a profile image.
- **Secure HTTP Communication**: Handles HTTP requests with SSL/TLS certificate validation.

## Screenshots

*![image](https://github.com/user-attachments/assets/d25c0a25-e0cd-46bd-8e8c-be586b980927)
![image](https://github.com/user-attachments/assets/33c99f4c-aaa0-4ee4-a44a-78b742bdbce7)

*

## Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.5.1 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android/iOS emulator or a physical device

### Steps

1. Install dependencies:

    ```bash
    flutter pub get
    ```

2. Run the application:

    ```bash
    flutter run
    ```

## Usage

- **Login**: Enter your username and password to log in to the system.
- **View Analytics**: After logging in, view real-time CPU and RAM usage.
- **Responsive UI**: The application layout adjusts depending on the screen size, providing an optimal experience on both mobile and desktop devices.

## Project Structure

```plaintext
SecureWatch/
├── lib/
│   ├── main.dart                 # Entry point of the application
│   ├── login_screen.dart         # Login screen with secure authentication
│   ├── analytics_screen.dart     # Main analytics dashboard
│   ├── responsive_layout.dart    # Responsive layout for mobile and desktop
│   ├── custom_analytics_button.dart # Custom button for Analytics
│   ├── custom_feedback_button.dart  # Custom button for Feedback
├── assets/
│   ├── image.png                 # Logo image
│   ├── image1.png                # Graphic image used in the login screen
│   ├── profile.png               # User profile image
│   ├── other images...           # Additional images used in the app
├── pubspec.yaml                  # Flutter and Dart dependencies
├── README.md                     # Project documentation
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-name`.
3. Make your changes and commit them: `git commit -m 'Add feature-name'`.
4. Push to the branch: `git push origin feature-name`.
5. Create a pull request.
