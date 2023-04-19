import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/firebase_auth_helper.dart';
import 'components/email.dart';
import 'components/password.dart';
import 'components/signin_button.dart';
import 'components/social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Image.asset("assets/images/top1.png"),
          // ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Image.asset("assets/images/top2.png"),
          // ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Image.asset(
          //     "assets/images/bottom1.png",
          //     color: Colors.blue.shade800.withOpacity(1),
          //   ),
          // ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Image.asset("assets/images/top2.png"),
          // ),
          Form(
            key: signInKey,
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
                        Center(
                          child: Text(
                            "LOGIN",
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
                        ),
                        SizedBox(
                          height: 50,
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
                        return "Please enter password";
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (val) {},
                          checkColor: Colors.white,
                          activeColor: Colors.amberAccent.withOpacity(0.8),
                        ),
                        Text(
                          "Remeber me",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        Spacer(),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Text(
                        //     "Forget Password",
                        //     style: GoogleFonts.poppins(
                        //       textStyle: TextStyle(
                        //           color: Colors.grey.shade600,
                        //           decoration: TextDecoration.underline),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  buildSignInButton(height, press: () async {
                    if (signInKey.currentState!.validate()) {
                      signInKey.currentState!.save();

                      Map<String, dynamic> res = await FirebaseAuthHelper
                          .firebaseAuthHelper
                          .signIn(email: email!, password: password!);

                      if (res['user'] != null) {
                        Navigator.pushNamed(context, '/',
                            arguments: res['user']);
                      } else if (res['error'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              res['error'],
                            ),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Sign in failed",
                            ),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                    emailController.clear();
                    passwordController.clear();

                    setState(() {
                      email = null;
                      password = null;
                    });
                  }, text: 'Login'),
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
                        press: () async {
                          await FirebaseAuthHelper.firebaseAuthHelper
                              .SignInWithGoogle();

                          Navigator.pushReplacementNamed(context, '/');
                        },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'sinup_page');
                        },
                        child: Text(
                          " Sign up",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.amberAccent.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
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
