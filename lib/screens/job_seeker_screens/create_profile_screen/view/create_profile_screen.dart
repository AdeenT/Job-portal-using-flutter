import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';

import 'package:flutter_application_1/core/constants/app_size.dart';
import '../controller/seeker_create_profile_controller.dart';

class CreateProfile extends StatelessWidget {
  CreateProfile({super.key});
  final controller = Get.put(CreateProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
                  JSpace.vertical(10),
                  controller.subHeading("Let's create your profile"),
                  JSpace.vertical(AppSize.height * 0.02),
                  Container(
                    height: 130,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  JSpace.vertical(AppSize.height * 0.02),
                  controller.subHeading("Name"),
                  controller.textField("Full Name", controller.nameController,
                      TextInputType.name),
                  JSpace.vertical(AppSize.height * 0.02),
                  controller.subHeading("Age"),
                  controller.textField(
                      "21", controller.ageController, TextInputType.number),
                  JSpace.vertical(AppSize.height * 0.02),
                  controller.subHeading("Address"),
                  controller.textField("eg- Calicut, Kerala",
                      controller.addressController, TextInputType.text),
                  JSpace.vertical(AppSize.height * 0.02),
                  controller.subHeading("Occupation"),
                  controller.textField("Current job",
                      controller.occupationController, TextInputType.text),
                  JSpace.vertical(AppSize.height * 0.02),
                  JButton(
                    width: double.infinity,
                    height: 50,
                    onPress: () async {
                      controller.onConfirmClicked();
                    },
                    backgroundColor: AppColor.primary,
                    text: "Confirm",
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
