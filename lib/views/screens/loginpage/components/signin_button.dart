import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container buildSignInButton(double height,
    {required GestureTapCallback press, required String text}) {
  return Container(
    padding: EdgeInsets.only(right: 25, left: 25),
    width: double.infinity,
    height: height * 0.061,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amberAccent.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: press,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            shadows: [
              Shadow(
                  offset: Offset(3, 3), color: Colors.black12, blurRadius: 10),
            ],
          ),
        ),
      ),
    ),
  );
}
