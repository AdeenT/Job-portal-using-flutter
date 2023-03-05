// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/global.dart';
import 'package:flutter_application_1/screens/selection_screen/view/selection_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  buildTextField(TextEditingController controller, String label,TextInputType keyboardType, bool obscure,
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
        keyboardType: keyboardType ,
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

  Future<void> signUpWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // User successfully signed up
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  onSignUPClicked() async {
    if (formKey.currentState!.validate()) {
      //checking the user email is already exist in the collection
      var collectionRef =
          await FirebaseFirestore.instance.collection("Users").get();
      if (collectionRef.docs
          .where(
            (element) =>
                element.data()['Auth']['email'].toString() ==
                emailController.text,
          )
          .isEmpty) {
        //sign up
        await signUpWithEmailAndPassword();

        //add user details to firebase users collection
        String uid = FirebaseAuth.instance.currentUser!.uid;
        log(uid);
        await FirebaseFirestore.instance.collection('Users').doc(uid).set({
          'Auth': {
            'email': emailController.text,
            'password': passwordController.text,
          },
        });

        emailController.clear();
        passwordController.clear();
        confirmController.clear();
      } else {
        Get.snackbar(
          'Email',
          'This user is already exist',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

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

  googleSignUpButton(
    IconData? icon,
    String text,
    Color bgColor,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.3,
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
            } else {
              Get.snackbar(
                'Error',
                'Please complete this form',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                color: Colors.red.withGreen(60),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
