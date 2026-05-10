 Flutter Chat App
A real-time chat application built with Flutter and Firebase, supporting both group chat and private messaging between users.

📱 Screenshots
LoginRegisterUsers ListChatShow ImageShow ImageShow ImageShow Image

✨ Features

🔐 Authentication — Register & Login with Email and Password via Firebase Auth
💬 Group Chat — All users can chat together in a shared room
🔒 Private Chat — One-on-one messaging between users
🟡 Message Bubbles — Different colors for sent and received messages
⏱️ Real-time Messaging — Powered by Cloud Firestore live snapshots
📜 Auto Scroll — Automatically scrolls to the latest message


🛠️ Tech Stack
TechnologyUsageFlutterUI FrameworkFirebase AuthUser AuthenticationCloud FirestoreReal-time DatabaseFirebase CoreFirebase Initialization

📁 Project Structure
lib/
├── main.dart                  # App entry point & routes
├── Const.dart                 # Constants (keys, colors)
├── Models/
│   └── message.dart           # Message data model
├── views/
│   ├── login.dart             # Login screen
│   ├── register_screen.dart   # Register screen
│   ├── chtPage.dart           # Chat screen
│   └── users_list.dart        # Users list screen
└── widgets/
    └── chatbubl.dart          # Chat bubble widgets

🚀 Getting Started
Prerequisites

Flutter SDK >=3.0.0
Dart SDK >=3.0.0
Firebase project set up

Installation

Clone the repository

bashgit clone https://github.com/your-username/chat-app.git
cd chat-app

Install dependencies

bashflutter pub get

Set up Firebase

Go to Firebase Console
Create a new project
Enable Authentication (Email/Password)
Enable Cloud Firestore
Download google-services.json and place it in android/app/
Run:



bashflutterfire configure

Run the app

bashflutter run

🗄️ Firestore Structure
users/
  └── {userId}/
        ├── email: "user@example.com"

chats/
  └── {chatId}/          # chatId = email1_email2 (sorted)
        └── messages/
              └── {messageId}/
                    ├── message:   "Hello!"
                    ├── email:     "user@example.com"
                    └── createdAt: Timestamp

📦 Dependencies
yamldependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.x.x
  firebase_auth: ^4.x.x
  cloud_firestore: ^4.x.x

🔮 Future Improvements

 Push Notifications with Firebase Messaging
 Send Images in chat
 Voice Messages
 Message Read Receipts ✓✓
 User Profile Picture
 Typing Indicator...
 Delete & Edit Messages
 Dark Mode


👨‍💻 Author
Your Name

GitHub: @your-username
Email: your-email@example.com


📄 License
This project is licensed under the MIT License — see the LICENSE file for details.