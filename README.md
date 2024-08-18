Catering Service Manager
Overview
The Catering Service Manager is a mobile application developed using Flutter, designed to streamline and manage catering services effectively. The app focuses on Daig (large cooking vessel) management, allowing administrators to track, allocate, and monitor the status of their inventory in real-time. The app also integrates Firebase Authentication and Firestore for secure data management and Firebase Cloud Messaging (FCM) for push notifications.

Features
Admin Registration and Authentication:

Secure login and registration for administrators using Firebase Authentication.
Daig Inventory Management:

Add, view, update, and delete Daig items in the inventory.
Track the status of each Daig (e.g., 'in use,' 'idle').
Daig Allocation and Status Tracking:

Allocate Daigs for events and update their status in real-time.
Monitor the availability of Daigs and avoid scheduling conflicts.
Basic Notifications:

Receive notifications about Daig status changes and allocation/unavailability alerts.
Push Notifications with FCM:

Get instant updates when a Daig status changes (e.g., from 'in use' to 'idle') or when a Daig is allocated or becomes unavailable.
Project Structure
The project follows a clean architecture with separate files for better code organization:

css
Copy code
lib/
│
├── authentication/
│   ├── login_screen.dart
│   └── registration_screen.dart
│
├── daig_management/
│   ├── daig_list_screen.dart
|   ├── add_daig_screen.dart
│   ├── update_daig_screen.dart
│   
│
├── notifications/
│   ├── notification_service.dart
│   └── fcm_listener.dart
│
├── models/
│   ├── daig_model.dart
│
├── services/
│   ├── firestore_service.dart
│   └── auth_service.dart
│
└── main.dart
Getting Started
Prerequisites
Flutter SDK: Flutter Installation Guide
Firebase Account: Firebase Console
Setup
Clone the repository:

bash
Copy code
git clone https://github.com/yourusername/catering-service-manager.git
cd catering-service-manager
Install dependencies:

bash
Copy code
flutter pub get
Configure Firebase:

Create a Firebase project in the Firebase Console.
Add your Android/iOS app and download the google-services.json or GoogleService-Info.plist.
Place the file(s) in the respective folders:
android/app/ for google-services.json
ios/Runner/ for GoogleService-Info.plist
Run the app:

bash
Copy code
flutter run
Key Functionalities
Admin Authentication:

Use the login and registration screens to create and authenticate admin accounts.
Manage Daig Inventory:

Add new Daigs, edit existing ones, and track their usage.
Allocate and Monitor Daigs:

Assign Daigs to events and monitor their availability using real-time updates.
Notifications:

Get alerts about Daig status changes and allocation issues.
Firebase Integration
Firebase Authentication: Handles user registration and login.
Firestore: Manages Daig data and user information.
Firebase Cloud Messaging (FCM): Sends push notifications to notify admins of important updates.
Contributing
Contributions are welcome! Please feel free to submit a Pull Request or raise issues for any bugs or feature requests.

License
This project is licensed under the MIT License.

