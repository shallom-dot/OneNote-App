import 'package:flutter/material.dart';
import 'package:one_note/features/add_note/add_note_page.dart';
import 'package:one_note/features/note_pages/home_page.dart';
import 'package:one_note/features/note_pages/note_page.dart';
import 'package:one_note/firebase_options.dart';
import 'package:one_note/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return WelcomePage();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MainHomePage();
          }
          return MainHomePage();
        },
      ),
      routes: {
        AddNoteScreen.id: (context) => const AddNoteScreen(),
        NotePageScreen.id: (context) => const NotePageScreen(),
        MainHomePage.id: (context) => const MainHomePage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const WelcomePage());
    );
  }
}
