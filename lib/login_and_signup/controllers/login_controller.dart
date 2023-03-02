import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  Icon visibilityIcon = const Icon(
    Icons.visibility_off,
    color: Colors.black,
  );
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    update();
  }

  void visibility() {
    if (obscureText == false) {
      visibilityIcon = const Icon(
        Icons.visibility_off,
        color: Colors.grey,
      );
      obscureText = true;
      update();
    } else {
      visibilityIcon = const Icon(
        Icons.visibility,
        color: Colors.grey,
      );
      obscureText = false;
      update();
    }
  }
}
