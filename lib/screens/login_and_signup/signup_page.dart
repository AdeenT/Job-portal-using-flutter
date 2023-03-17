// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/global.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'controllers/sign_up_controller.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final controller = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.26,
              ),
              const Text(
                "Sign up for free",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              controller.buildTextField(
                controller.emailController,
                "Email",
                TextInputType.emailAddress,
                false,
                (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              controller.buildTextField(
                controller.passwordController,
                "Password",
                TextInputType.text,
                false,
                (value) {
                  if (value == null || value.isEmpty) {
                    return "Create a new password";
                  }
                  return null;
                },
              ),
              controller.buildTextField(
                controller.confirmController,
                "Confirm Password",
                TextInputType.text,
                false,
                (value) {
                  if (controller.confirmController !=
                          controller.passwordController &&
                      value!.isEmpty) {
                    return "Password should be same as above";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      await controller.onSignUpButtonClicked();
                    },
                    child: const Text(
                      "Sign up",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.027,
              ),
              const Text(
                "or continue with",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              controller.googleSignUpButton(FontAwesomeIcons.google, "Google",
                  Colors.white, Colors.black),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  TextButton(
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
