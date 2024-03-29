import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_create_profile_screen/controller/recrter_create_prof_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RecruiterCreateProfile extends StatelessWidget {
  RecruiterCreateProfile({super.key});
  final controller = Get.put(RecruiterCreateProfileController());
  @override
  Widget build(BuildContext context) {
    RxString imageUrl = " ".obs;
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
      body: GetBuilder<RecruiterCreateProfileController>(
        builder: (controller) => SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.height * 0.025,
                  ),
                  controller.subHeading("Let's create your profile"),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: imageUrl == " "
                                    ? const NetworkImage(
                                        "https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/person-profile-image-icon.png")
                                    : NetworkImage(imageUrl.toString()),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColor.primary,
                              ),
                              child: IconButton(
                                  onPressed: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? image = await imagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      File profilePic = File(image.path);
                                      imageUrl.value =
                                          await uploadDp(profilePic);
                                    }
                                  },
                                  icon: const Icon(Icons.camera_alt_rounded)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.height * 0.025,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: AppSize.height * 0.025,
                  ),
                  controller.subHeading("Name of the company"),
                  controller.textField("Name of the company",
                      controller.nameController, TextInputType.name),
                  SizedBox(
                    height: AppSize.height * 0.025,
                  ),
                  controller.subHeading("Email"),
                  controller.textField("Company's Email",
                      controller.emailController, TextInputType.emailAddress),
                  SizedBox(
                    height: AppSize.height * 0.025,
                  ),
                  controller.subHeading("Established date"),
                  controller.textField("Established date",
                      controller.dateController, TextInputType.datetime),
                  SizedBox(
                    height: AppSize.height * 0.025,
                  ),
                  controller.subHeading("Country"),
                  controller.textField("Country", controller.countryController,
                      TextInputType.text),
                  SizedBox(
                    height: AppSize.height * 0.025,
                  ),
                  controller.subHeading("Address"),
                  controller.textField("Company address",
                      controller.addressController, TextInputType.text),
                  SizedBox(
                    height: AppSize.height * 0.045,
                  ),
                  SizedBox(
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

  Future<String> uploadDp(File dP) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var storageRef =
        FirebaseStorage.instance.ref().child('recruite/dp/$currentUserId.jpg');
    await storageRef.putFile(dP);
    String seekerDp = await storageRef.getDownloadURL();
    controller.imageUrl = seekerDp.toString();
    return seekerDp;
  }
}
