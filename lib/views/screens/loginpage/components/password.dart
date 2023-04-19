import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Container buildPasswordTextfield(
  double height,
  TextEditingController controller, {
  required Function(String?)? onSaved,
  required String? Function(String?)? validator,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, right: 20),
    margin: EdgeInsets.only(top: 10),
    child: TextFormField(
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.blueAccent,
      obscureText: true,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amberAccent.withOpacity(0.8),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amberAccent.withOpacity(0.8),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Password",
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.amber,
          ),
        ),
        hintText: " Enter your password",
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(),
        ),
        // suffixIcon: Padding(
        //   padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
        //   child: SvgPicture.asset(
        //     "assets/icons/Lock.svg",
        //     height: height * 0.02,
        //   ),
        // ),
        // Icon(Icons.lock)
      ),
    ),
  );
}
