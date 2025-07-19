# islamic_tools_app

A new Flutter project.

## Getting Started

1. 📱 Application Overview
   The Islamic Tools App is a Flutter-based mobile application that provides essential Islamic content and utilities. It includes access to the full Quran, a collection of Hadiths, a digital Tasbeeh counter, Islamic radio streams, and customizable settings – all in a lightweight, offline-first application.

2. 🚀 Features
   Feature	Description
   📖 Quran	Displays all 114 Surah's from separate .txt files stored in assets.
   🗣️ Hadiths	Displays 50 Hadiths from a static file.
   🧮 Tasbeeh	Digital counter with pre-defined Azkaar and customizable count.
   📻 Radio	Streams Islamic radio channels over the internet.
   ⚙️ Settings	Allows users to control UI preferences such as theme and language (if implemented).

3. 🧱 Architecture & Design
   Architecture Style: Simple MVC-like structure using setState() and basic widget hierarchy.

   Data Flow: Direct widget-to-widget interaction with minimal logic separation.

   Offline-first: Content like Quran and Hadiths is stored in the app assets.

   Online features: Radio channel streaming is online.

4. 📁 Project Structure
   graphql
   Copy
   Edit
   lib/
   ├── main.dart                    # App entry point
   ├── screens/                     # Different feature screens
   │   ├── quran_screen.dart
   │   ├── hadith_screen.dart
   │   ├── tasbeeh_screen.dart
   │   ├── radio_screen.dart
   │   └── settings_screen.dart
   ├── models/                      # Optional content models (if used)
   ├── widgets/                     # Reusable widgets like custom tiles, counters, etc.
   assets/
   ├── dataFiles/                   # 114 Quran Surah files (1.txt to 114.txt)
   ├── hadeeth/                     # Single file with 50 Hadiths
   └── radio_channels.json          # (if defined as static JSON for URLs)
5. 📦 Packages Used
   Package	Purpose
   http or audioplayers	Streaming radio audio
   flutter/material.dart	Core UI framework
   assets	Quran and Hadith content

   No use of state management libraries (e.g., Provider, Bloc) or local databases (e.g., Hive, SharedPreferences).

6. 💾 Data Handling
   Quran:

   Stored as 114 individual .txt files in assets/dataFiles/.

   Read using rootBundle.loadString() to display content per Surah.

   Hadiths:

   Stored in a single .txt file or formatted asset.

   Tasbeeh:

   Uses basic setState() logic to increment and reset the count.

   Radio:

   Streams live channels using HTTP/MP3 streams.

7. 🌐 Localization & Theming
   If multilingual support is added: easy_localization or custom approach using Intl and AppLocalizations.

   Theme switching and font adjustments likely managed through setState() in Settings.

8. 🧪 How to Run the App
  
   # 1. Get dependencies
   flutter pub get

   # 2. Run the app
   flutter run
No platform-specific setup is needed unless targeting radio stream permissions (see AndroidManifest).

9. 🛠️ How to Extend the App
   Enhancement	Description
   🌍 Add localization	Use easy_localization or Flutter's intl for Arabic/English UI.
   📚 Bookmarks	Add favorites/bookmarks using SharedPreferences.
   🎧 Audio Quran	Use just_audio to play Surah audio from MP3 URLs.
   🔄 State handling	Add provider or riverpod for cleaner separation.