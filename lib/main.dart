import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper_app/views/screens/NoteEditorPage/notes_editor_screen.dart';
import 'package:notekeeper_app/views/screens/homepage/homepage.dart';
import 'package:notekeeper_app/views/screens/loginpage/login_screen.dart';
import 'package:notekeeper_app/views/screens/signupPage/signup_screen.dart';
import 'package:notekeeper_app/views/screens/splashpage/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: 'splash_page',
      routes: {
        '/': (context) => HomePage(),
        'splash_page': (context) => SplashScreen(),
        'login_page': (context) => LoginPage(),
        'sinup_page': (context) => SignUpScreen(),
        'note_editor_page': (context) => NoteEditorScreen(),
      },
    ),
  );
}
