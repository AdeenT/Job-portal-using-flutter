// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global.dart';
import '../controller/seeker_create_profile_controller.dart';

class CreateProfile extends StatelessWidget {
  CreateProfile({super.key});
  final controller = Get.put(CreateProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<CreateProfileController>(
        builder: (controller) => SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  controller.subHeading("Let's create your profile"),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    height: 130,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  controller.subHeading("Name"),
                  controller.textField("Full Name", controller.nameController,
                      TextInputType.name),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  controller.subHeading("Age"),
                  controller.textField(
                      "21", controller.ageController, TextInputType.number),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  controller.subHeading("Address"),
                  controller.textField("eg- Calicut, Kerala",
                      controller.addressController, TextInputType.text),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  controller.subHeading("Occupation"),
                  controller.textField("Current job",
                      controller.occupationController, TextInputType.text),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
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
                        controller.onConfirmClicked();
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
