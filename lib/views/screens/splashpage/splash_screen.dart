import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notekeeper_app/views/screens/loginpage/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54, spreadRadius: 1, blurRadius: 5),
                ],
              ),
              child: Image.asset("assets/icons/notes_logo.png"),
            ),
            Spacer(),
            Text(
              "Notes App",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
