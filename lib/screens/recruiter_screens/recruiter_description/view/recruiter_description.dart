import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_description/controller/recruiter_description_controller.dart';
import 'package:get/get.dart';

class RecruiterDescription extends StatelessWidget {
  RecruiterDescription({super.key});
  final controller = Get.put(RecruiterDescriptionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.button(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text(
          "Job Description",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.blue.shade400,
        ),
      ),
    );
  }
}
