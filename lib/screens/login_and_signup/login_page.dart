// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/screens/login_and_signup/controllers/login_controller.dart';
import 'package:flutter_application_1/screens/login_and_signup/signup_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.27,
              ),
              const Text(
                "Sign in to your account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
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
                true,
                (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot the password?",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async{
                     await controller.onSignInButtonClicked();
                      controller.update();
                    },
                    child: const Text(
                      "Sign in",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                      controller.onGoogleSignInClicked();
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
                    "Don't have any account?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 3),
                  TextButton(
                    onPressed: () {
                      Get.to(SignUpPage());
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
