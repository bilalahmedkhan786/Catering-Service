**Catering Service Manager**

**Overview**

The Catering Service Manager is a mobile application built with Flutter, designed to help manage daigs (cooking pots) in a catering service. It allows users to add, update, and manage daig inventory, track status changes, and receive notifications for status changes and availability.

**Features**

User Authentication: Login and logout functionalities.
Daig Management: Add new daigs, update existing daigs, and view daig details.
Status Tracking: Track and update the status of daigs.
Notification Alerts: Receive notifications for status changes and availability.
Push Notifications: Integrated with Firebase Cloud Messaging for real-time updates.
Installation
Prerequisites
Flutter SDK
Dart SDK
Firebase Account
Setup
Clone the Repository

bash
Copy code
git clone https://github.com/yourusername/catering_service_manager.git
cd catering_service_manager
Install Dependencies

bash
Copy code
flutter pub get
Configure Firebase

Go to the Firebase Console.
Create a new project or use an existing one.
Follow the instructions to add your Android app to Firebase and download google-services.json.
Place google-services.json in the android/app directory of your project.
Update Android Configuration

Update your android/build.gradle file:

gradle
Copy code
buildscript {
  dependencies {
    classpath 'com.google.gms:google-services:4.3.14' // Check for latest version
  }
}
Update your android/app/build.gradle file:

gradle
Copy code
apply plugin: 'com.google.gms.google-services'
Configure Notifications

Ensure you have the following permissions in android/app/src/main/AndroidManifest.xml:

xml
Copy code
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
Run the Application

bash
Copy code
flutter run
Usage
Login Screen: Use the login screen to authenticate users.
Daig List Screen: View, edit, and delete daigs. You can also add new daigs from this screen.
Add Daig Screen: Fill in the details to add a new daig to the inventory.
Update Daig Screen: Update the information and status of existing daigs.
Notifications
Notifications are set up to alert users of status changes and availability updates. Ensure your app has the necessary permissions and Firebase Cloud Messaging is correctly configured.

Troubleshooting
Notification Issues: Ensure Firebase Cloud Messaging is correctly set up and your app has the necessary permissions.
Build Errors: Verify that all dependencies are correctly added and up-to-date. Ensure google-services.json is correctly placed.
Contributing
Contributions are welcome! Please submit a pull request with your proposed changes.

License
This project is licensed under the MIT License - see the LICENSE file for details.
