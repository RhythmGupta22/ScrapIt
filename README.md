 # ScrapIt

ScrapIt is a mobile application that connects users with scrap collectors based on their location, simplifying and digitizing waste management. The app aims to promote an eco-friendly and socially responsible recycling experience by making it easier for users to dispose of their waste while ensuring efficient collection.

## Features

- *User Registration & Authentication*: Secure sign-up and login using Firebase authentication.
- *Location-Based Matching*: Connects users with nearby scrap collectors similar to ride-hailing platforms like Uber or Rapido.
- *Real-Time Notifications*: Users receive notifications regarding pickup requests and status updates.
- *Booking System*: Users can schedule pickups, set preferred times, and track assigned collectors.
- *Payment Integration*: Supports digital payments for services.
- *Eco-Friendly Rewards*: Users earn points or rewards for responsible recycling.
- *Admin Dashboard*: Allows for efficient management of users and scrap collectors.

## Tech Stack

- *Frontend*: Flutter (Dart)
- *Backend*: Firebase (Authentication, Firestore, Cloud Functions)
- *DevOps*: AWS CodePipeline, CodeBuild, Amazon S3, Containers, Docker
- *Maps & Location Services*: Google Maps API for real-time location tracking
- *Notifications*: Firebase Cloud Messaging (FCM)

## Installation

### Prerequisites
- Flutter SDK installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- Firebase setup with your project ([Firebase Console](https://console.firebase.google.com/))
- Android Studio or VS Code for development

### Steps
1. Clone the repository:
   sh
   git clone https://github.com/your-repo/scrapit.git
   cd scrapit
   
2. Install dependencies:
   sh
   flutter pub get
   
3. Configure Firebase:
   - Add your google-services.json (Android) and GoogleService-Info.plist (iOS) files inside the android/app and ios/Runner directories respectively.
   
4. Run the application:
   sh
   flutter run
   
