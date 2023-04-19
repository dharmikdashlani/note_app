import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();

  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Anonymous() async {
    Map<String, dynamic> res = {};

    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();

      User? user = userCredential.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          res['error'] = "Working in progress.";
          break;
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> signUp(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};

    try {
      UserCredential userCrendetial = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCrendetial.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      print("==============================");
      print(e.code);
      print("==============================");

      switch (e.code) {
        case "email-already-in-use":
          res['error'] = "Email already exists...";
          break;
        case "weak-password":
          res['error'] = "Password must be lengthy...";
          break;
        case "operation-not-allowed":
          res['error'] = "Server is Temporary Disabled....";
          break;
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> signIn(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCrendetial = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCrendetial.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      print("====================================");
      print(e.code);
      print("====================================");

      switch (e.code) {
        case "wrong-password":
          res['error'] = "Password is wrong....";
          break;
        case "user-not-found":
          res['error'] = "User not found...";
          break;
        case "invalid-email":
          res['error'] = "User not found...";
          break;
        case "operation-not-allowed":
          res['error'] = "Server temperory disabled...";
          break;
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> SignInWithGoogle() async {
    Map<String, dynamic> res = {};

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential? userCredential =
          await firebaseAuth.signInWithCredential(credential);

      User? user = userCredential.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          res['error'] = "Server temperory disabled...";
          break;
      }
    }
    return res;
  }
}
