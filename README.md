# Plantist Case

A new Flutter project named **Plantist Case**. This project implements features related to task management, including creating, updating, and displaying TODO items with various functionalities.

## Features

- **Task Management**: Create, update, and delete TODO items.
- **State Management**: Manage state using `GetX`.
- **Firebase Integration**: 
  - Authentication using Firebase Auth.
  - Data storage with Firestore.
  - File uploads using Firebase Storage.
- **Responsive UI**: Built to be responsive using `flutter_screenutil`.
- **Custom Fonts and Icons**: Integrated with Google Fonts and Cupertino Icons.
- **Image Picker**: Select images from the gallery.
- **SVG Support**: Display SVG images using `flutter_svg`.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>=3.4.3 <4.0.0)
- [Dart](https://dart.dev/get-dart)
- [Firebase CLI](https://firebase.google.com/docs/cli)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/plantist_case.git
   cd plantist_case
2. **Install dependencies:**

   ```bash
   flutter pub get

3. Set up Firebase
- Create a Firebase project in your Firebase Console.
- Add Android and iOS apps to your Firebase project..
- **Download the google-services.json for Android and GoogleService-Info.plist for iOS and place them in their respective directories:* 
  - android/app/
  - ios/Runner/

4. Run the project

   ```bash
   flutter run

#Folder Structure
![Ekran görüntüsü 2024-08-30 194258](https://github.com/user-attachments/assets/87969e0e-7a37-4366-8282-4cd76fa04cae)

#App Screenshots 
![Group 2](https://github.com/user-attachments/assets/ca14a4b7-e7ff-42a7-8d26-23c93e06f120)


# Dependencies
The project uses the following key dependencies:

State Management: get - For efficient state management.
#Firebase:
  - <p>&nbsp; - <a data-fr-linked="true" href="https://pub.dev/packages/firebase_auth">Firebase Auth</a> - Authentication management.</p>
  - <p>&nbsp; - <a href="https://pub.dev/packages/firebase_core">Firebase Core</a> - Firebase core functionalities.</p>
  - <p>&nbsp; - <a data-fr-linked="true" href="https://pub.dev/packages/cloud_firestore">Cloud Firestore</a> - Firestore database.</p>
  - <p>&nbsp; - <a data-fr-linked="true" href="https://pub.dev/packages/firebase_storage">Firebase storage</a> - Cloud storage for images and files.</p>
#UI and Styling:
  - <p>&nbsp; - <a href="https://pub.dev/packages/google_fonts">Google fonts</a>: Font bundling in assets. Matching font files found in assets are prioritized over HTTP 
  fetching. Useful for offline-first apps.</p>
  - <p>&nbsp; -<a href="https://pub.dev/packages/google_fonts">&nbsp;Flutter SVG</a>: Basic usage (to create an SVG rendering widget from an asset.&nbsp;</p>
  - <p>&nbsp; - <a href="https://pub.dev/packages/flutter_screenutil">Flutter ScreenUtil</a>: A flutter plugin for adapting screen and font size. Let your UI display a reasonable layout on different screen sizes.</p>
  - <p>&nbsp; -<a href="https://pub.dev/packages/intl">&nbsp;Intl:</a> Provides internationalization and localization facilities, incluıding message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.</p>
  - <p>&nbsp; - <a href="https://pub.dev/packages/permission_handler">Permission handler:</a> On most operating systems, permissions aren&apos;t just granted top apps at install time. Rather, developers have to ask the user for permission while the app is running.</p>

</pre>
</div>
<p><br></p>
# Utilities:
  - intl - Date and number formatting.
  - permission_handler - Requesting permissions.

# Contributing
  **Contributions are welcome! Please follow these steps:*

# Fork the repository.
  - Create a new branch (git checkout -b feature-branch).
  - Make your changes.
  - Commit your changes (git commit -am 'Add new feature').
  - Push to the branch (git push origin feature-branch).
  - Create a new Pull Request.

# Contact
**For more information, feel free to reach out at kadircelikogluu@gmail.com.*
