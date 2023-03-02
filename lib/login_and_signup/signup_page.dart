// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_and_signup/controllers/login_controller.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/navbar/view/navbar.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/view/profile_screen.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final controller = LoginController();
  @override
  Widget build(BuildContext context) {
    final width = Get.size.width;
    final height = Get.size.height;

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
              SizedBox(
                height: height * 0.027,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 8,
                  top: 8,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      "Email",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.020,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 8,
                  top: 8,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      "Password",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.020,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 8,
                  top: 8,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      "Confirm Password",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.020,
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
                    onPressed: () {
                      Get.to(NavBar());
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
                      elevation: 0.3,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      controller.googleLogin();
                    },
                    child: Image.network(
                      "https://png.monster/wp-content/uploads/2020/11/Google-Amblem-7c49bdf3.png",
                    ),
                  ),
                ),
              ),
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
