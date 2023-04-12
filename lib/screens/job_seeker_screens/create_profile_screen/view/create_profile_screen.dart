import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';

import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/seeker_create_profile_controller.dart';

class CreateProfile extends StatelessWidget {
  CreateProfile({super.key});
  final controller = Get.put(CreateProfileController());
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
      body: Obx(
        () => SingleChildScrollView(
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
                  JSpace.vertical(AppSize.height * 0.02),
                  controller.subHeading("Name"),
                  controller.textField("Full Name", controller.nameController,
                      TextInputType.name),
                  JSpace.vertical(AppSize.height * 0.02),
                  controller.subHeading("Email"),
                  controller.textField("Email", controller.emailController,
                      TextInputType.emailAddress),
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

  Future<String> uploadDp(File dP) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var storageRef =
        FirebaseStorage.instance.ref().child('seeker/dp/$currentUserId.jpg');
    await storageRef.putFile(dP);
    String seekerDp = await storageRef.getDownloadURL();
    controller.imageUrl = seekerDp.toString();
    return seekerDp;
  }
}
