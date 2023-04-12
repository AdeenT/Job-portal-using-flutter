import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/recruiter_model.dart';
import 'package:flutter_application_1/screens/recruiter_screens/edit_profile/edit_profile.dart';
import 'package:flutter_application_1/screens/settings_screen/view/settings_screen.dart';
import 'package:flutter_application_1/widgets/Text/text.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RecruiterProfileScreen extends StatelessWidget {
  RecruiterProfileScreen({super.key});

  final recruiterDp = ' '.obs;

  @override
  Widget build(BuildContext context) {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const JText(
          text: "Profile",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              size: 30,
              color: Colors.blue.withOpacity(0.65),
            ),
            onPressed: () {
              Get.to(const SettingsScreen());
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('recruiter')
            .doc(currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          {
            if (!snapshot.hasData) return const SizedBox();
          }
          RecruiterModel recruiterModel =
              RecruiterModel.fromMap(snapshot.data!.data()!);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: AppSize.width * 0.1,
                    top: AppSize.height * 0.05,
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                              recruiterModel.recruiterDp.toString(),
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
                                  color: AppColor.primary),
                              child: IconButton(
                                onPressed: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? image = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image != null) {
                                    File profilePic = File(image.path);
                                    recruiterDp.value =
                                        await uploadDp(profilePic);
                                    FirebaseFirestore.instance
                                        .collection('recruiter')
                                        .doc(currentUserId)
                                        .update(
                                            {'recruiterDp': recruiterDp.value});
                                  }
                                },
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: AppSize.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            JText(
                              text: recruiterModel.recruiterName,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: AppSize.height * 0.005,
                            ),
                            JText(
                              text: recruiterModel.recruiterEmail,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: AppSize.height * 0.005,
                            ),
                            JText(
                              text: recruiterModel.recruiterAddress,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 118.0,
                    ),
                    child: JButton(
                      onPress: () {
                        Get.to(RecruiterEditProfile(
                            recruiterModel: recruiterModel));
                      },
                      text: 'Edit',
                      borderRadius: 4,
                      suffixIcon: const Icon(Icons.edit),
                    ),
                  ),
                ),
                JSpace.vertical(20),
                jSubHeading("Name"),
                jTextFields(recruiterModel.recruiterName),
                const SizedBox(
                  height: 10,
                ),
                jSubHeading("Email"),
                jTextFields(recruiterModel.recruiterEmail),
                const SizedBox(
                  height: 10,
                ),
                jSubHeading("Established"),
                jTextFields(recruiterModel.recruiterDate),
                const SizedBox(
                  height: 10,
                ),
                jSubHeading("Address"),
                jTextFields(recruiterModel.recruiterAddress),
                const SizedBox(
                  height: 10,
                ),
                jSubHeading("country"),
                jTextFields(recruiterModel.recruiterPlace),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding jSubHeading(String subheading) {
    return Padding(
      padding: EdgeInsets.only(left: AppSize.width * 0.11, bottom: 5),
      child: Text(
        subheading,
        style:
            const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding jTextFields(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18,
      ),
      child: JContainer(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 230, 230, 230),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadDp(File dP) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var storageRef =
        FirebaseStorage.instance.ref().child('recruiter/dp/$currentUserId.jpg');
    await storageRef.putFile(dP);
    String seekerDp = await storageRef.getDownloadURL();
    return seekerDp;
  }
}
