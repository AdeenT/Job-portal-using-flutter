import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController {
final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  Icon visibilityIcon = const Icon(
    Icons.visibility_off,
    color: Colors.black,
  );

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
