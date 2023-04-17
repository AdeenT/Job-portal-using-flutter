import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/models/seeker/seeker_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/view/edit_profile_screen.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/view/upload_cv_screen.dart';
import 'package:flutter_application_1/screens/settings_screen/view/settings_screen.dart';
import 'package:flutter_application_1/widgets/Text/text.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final seekerDp = ''.obs;

  @override
  Widget build(BuildContext context) {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    String resumeUrl = "";

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
              Get.to(SettingsScreen());
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('seeker')
            .doc(currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          {
            if (!snapshot.hasData) return const SizedBox();
          }
          SeekerModel seekerModel = SeekerModel.fromMap(snapshot.data!.data()!);

          return SingleChildScrollView(
            child: Column(
              children: [
                JSpace.vertical(10.0),
                Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                            seekerModel.seekerDpUrl.toString(),
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
                                  seekerDp.value = await uploadDp(profilePic);
                                  FirebaseFirestore.instance
                                      .collection('seeker')
                                      .doc(currentUserId)
                                      .update({'seekerDpUrl': seekerDp.value});
                                }
                              },
                              icon: const Icon(Icons.camera_alt_rounded),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                JSpace.vertical(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(UploadCV());
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.blue.withOpacity(0.6),
                        ),
                      ),
                      child: const Text(
                        "Upload CV",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    JSpace.horizontal(50),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(EditProfile(
                          seekerModel: seekerModel,
                        ));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.blue.withOpacity(0.6),
                        ),
                      ),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                JSpace.vertical(20),
                jSubHeading("Name"),
                jTextFields(seekerModel.seekerName),
                const SizedBox(
                  height: 10,
                ),
                jSubHeading("Email"),
                jTextFields(seekerModel.seekerEmail),
                const SizedBox(
                  height: 10,
                ),
                jSubHeading("Age"),
                jTextFields(seekerModel.seekerAge),
                const SizedBox(
                  height: 10,
                ),
                jSubHeading("Address"),
                jTextFields(seekerModel.seekerAddress),
                const SizedBox(
                  height: 10,
                ),
                jSubHeading("occupation"),
                jTextFields(seekerModel.seekerOccupation),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            subheading,
            style: const TextStyle(
                color: Colors.black54, fontWeight: FontWeight.bold),
          ),
        ],
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
        FirebaseStorage.instance.ref().child('seeker/dp/$currentUserId.jpg');
    await storageRef.putFile(dP);
    String seekerDp = await storageRef.getDownloadURL();
    return seekerDp;
  }
}
