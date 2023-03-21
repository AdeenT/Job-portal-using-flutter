// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_page/main_page.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  RxBool updateWidget = false.obs;
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
    Get.off(const MainPage());
  }

  onGoogleSignInClicked() async {
    await googleLogin();
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    var docRef = FirebaseFirestore.instance.collection('Users').doc(userUID);
    var docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      docRef.set({
        'Auth': {'email': userEmail}
      });
    }
  }

  Future logout() async {
    await googleSignIn.signOut();
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

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      update();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  Future<void> onSignInButtonClicked() async {
    var collectionRefrnce =
        await FirebaseFirestore.instance.collection("Users").get();

    //---------------checking user email is exist or not------------
    var matchingUsers = collectionRefrnce.docs
        .where((element) =>
            element.data()['Auth']['email'] == emailController.text)
        .toList();
    if (matchingUsers.isNotEmpty) {
      log('user exists');
      if (matchingUsers.first.data()['Auth']['password'] ==
          passwordController.text) {
        log(passwordController.text);
        log('sign in success');

        await signIn();
      } else {
        Get.snackbar(
          'Error',
          'password does not match',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      log("usernotfound");
      Get.snackbar(
        'Error',
        'User not exist. please sign in ',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    log("sign in button execution complete");
  }

  buildTextField(
      TextEditingController controller,
      String label,
      TextInputType keyboardType,
      bool obscure,
      String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 12,
        top: 18,
      ),
      child: TextFormField(
        obscureText: obscure,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            label,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
