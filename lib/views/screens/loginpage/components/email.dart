import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Container buildEmailTextfield(
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
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amberAccent.withOpacity(0.8),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amberAccent,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Email",
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.amber,
          ),
        ),
        hintText: " Enter your email",
        hintStyle: GoogleFonts.poppins(textStyle: TextStyle()),
        // suffixIcon: Padding(
        //   padding: const EdgeInsets.only(top: 13, left: 13, right: 13),
        //   child: SvgPicture.asset(
        //     "assets/icons/Mail.svg",
        //     height: height * 0.02,
        //   ),
        // ),
      ),
    ),
  );
}
