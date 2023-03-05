// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/selection_screen/view/selection_screen.dart';
import 'package:get/get.dart';
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
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    update();
    Get.off(SelectionScreen());
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
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
