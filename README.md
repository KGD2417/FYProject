# FYProject - Vidyaniketan School Management App

## Overview
FYProject is a **Flutter-based** school management application developed as a **Final Year Diploma Project (2023-2024)** for **Vidyaniketan International School**. This app provides an efficient platform for managing student records, attendance, assignments, and communication between teachers, students, and parents.

## Features
- **User Authentication**
  - Secure login for admins, teachers, students, and parents.
  - Role-based access and permissions.

- **Student Management**
  - View student details and academic records.
  - Track attendance and generate reports.

- **Assignments & Notices**
  - Teachers can upload assignments and announcements.
  - Students can submit assignments online.

- **Parent-Teacher Communication**
  - Direct messaging between parents and teachers.
  - Notifications for updates and announcements.

- **Timetable & Exams**
  - Access class schedules.
  - View upcoming exams and results.

## Tech Stack
- **Framework:** Flutter (Dart)
- **Backend:** Firebase (Firestore & Authentication)
- **State Management:** Provider / Riverpod
- **Database:** Firestore (NoSQL Database)
- **Storage:** Firebase Storage (for document and image uploads)
- **Notifications:** Firebase Cloud Messaging (FCM)
- **UI Design:** Material Design (Flutter Widgets)

## Installation & Setup
### Prerequisites
Ensure you have the following installed:
- **Flutter SDK** (latest stable version)
- **Dart SDK**
- **Android Studio** or **VS Code** (with Flutter plugin)
- **Firebase Project** (set up in Firebase Console)

### Clone the Repository
```sh
git clone https://github.com/yourusername/FYProject.git
cd FYProject
```

### Install Dependencies
```sh
flutter pub get
```

### Configure Firebase
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Enable **Firestore Database, Authentication, and Cloud Storage**.
3. Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files.
4. Place them inside `android/app/` (for Android) and `ios/Runner/` (for iOS).

### Run the Application
```sh
flutter run
```

## Folder Structure
```
lib/
│── main.dart             # Entry point of the app
│── api/                  # Firebase interaction handlers
│── models/               # Data models (Student, Teacher, Assignment, etc.)
│── providers/            # State management using Provider
│── screens/              # UI screens (Login, Dashboard, Attendance, etc.)
│── widgets/              # Reusable UI components
│── utils/                # Helper functions and constants
```

## Contributing
1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`
3. Commit changes: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature-branch`
5. Open a Pull Request.

## License
This project is licensed under the MIT License.

## Contact
For any queries, contact [your email or GitHub profile link].

