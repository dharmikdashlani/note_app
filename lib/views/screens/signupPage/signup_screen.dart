import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/firebase_auth_helper.dart';
import '../loginpage/components/email.dart';
import '../loginpage/components/password.dart';
import '../loginpage/components/signin_button.dart';
import '../loginpage/components/social_button.dart';
import 'components/confirm_password.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? email;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: signUpKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.23,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "REGISTER",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.amberAccent.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              shadows: [
                                Shadow(
                                    offset: Offset(3, 3),
                                    color: Colors.black26,
                                    blurRadius: 10),
                                Shadow(
                                    offset: Offset(-3, -3),
                                    color: Colors.white.withOpacity(0.85),
                                    blurRadius: 10)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildEmailTextfield(
                    height,
                    emailController,
                    onSaved: (val) {
                      email = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter email";
                      }
                    },
                  ),
                  buildPasswordTextfield(
                    height,
                    passwordController,
                    onSaved: (val) {
                      password = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter Password";
                      }
                    },
                  ),
                  buildConfirmPassword(
                    height,
                    confirmPasswordController,
                    onSaved: (val) {
                      confirmPassword = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty && password == confirmPassword) {
                        return "Does't match your password";
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  buildSignInButton(height, press: () async {
                    if (signUpKey.currentState!.validate()) {
                      signUpKey.currentState!.save();

                      Map<String, dynamic> res = await FirebaseAuthHelper
                          .firebaseAuthHelper
                          .signUp(email: email!, password: password!);

                      if (res['user'] != null) {
                        Navigator.pushNamed(
                          context,
                          'login_page',
                        );
                      } else if (res['error'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              res['error'],
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Sign up failed",
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                    emailController.clear();
                    passwordController.clear();
                    confirmPasswordController.clear();

                    setState(() {
                      email = null;
                      password = null;
                      confirmPassword = null;
                    });
                  }, text: 'Sign Up'),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      SocialButton(
                        imageLocation: "assets/images/google logo.png",
                        press: () {},
                      ),
                      Spacer(),
                      SocialButton(
                        imageLocation: "assets/images/fb logo.png",
                        press: () {},
                      ),
                      Spacer(),
                      SocialButton(
                        imageLocation: "assets/images/twitter logo.png",
                        press: () {},
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
