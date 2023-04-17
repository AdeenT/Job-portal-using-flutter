import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/seeker/seeker_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/controllers/resume_controller.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/view/view_resume.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';

import '../../../../widgets/Text/text.dart';

class UploadCV extends StatelessWidget {
  UploadCV({super.key});

  final resumeController = Get.put(ResumeController());

  @override
  Widget build(BuildContext context) {
    String fileName = '';
    String resumeUrl = '';
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return GetBuilder<ResumeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const JText(
            text: "Upload Cv",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('seeker')
                  .doc(currentUserId)
                  .snapshots(),
              builder: (context, snapshot) {
                SeekerModel seekerModel =
                    SeekerModel.fromMap(snapshot.data!.data()!);
                if (snapshot.data!.data()!['cv'] == null) {
                  fileName = 'No File Selected';
                } else {
                  fileName = '${seekerModel.seekerName}_cv.pdf';
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    JButton(
                      onPress: () async {
                        if (resumeController.noResume == true.obs) {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            File file = File(
                              result.files.single.path.toString(),
                            );
                            resumeUrl =
                                await resumeController.userUploadCV(file);
                            FirebaseFirestore.instance
                                .collection('seeker')
                                .doc(currentUserId)
                                .update({'cv': resumeUrl});
                            resumeController.noResume == false.obs;
                          } else {}
                        } else {
                          Get.snackbar('Already Uploaded',
                              'delete the existing filee to upload a new file',
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      text: resumeController.noResume == false.obs
                          ? "File Uploaded"
                          : "Select File",
                      prefixIcon: const Icon(Icons.attach_file),
                      borderRadius: 5,
                      height: 40,
                    ),
                    JSpace.vertical(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        JText(
                          text: fileName,
                        ),
                        IconButton(
                          onPressed: () {
                            if (snapshot.data!.data()!['cv'] == null) {
                              Get.snackbar('File Not Found',
                                  'please select a file and upload to view the file',
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              Get.to(ResumeViewPage(resumeUrl: resumeUrl));
                            }
                          },
                          icon: const Icon(Icons.remove_red_eye),
                        )
                      ],
                    ),
                    JSpace.vertical(30),
                    Obx(() {
                      return resumeController.noResume == false.obs
                          ? const SizedBox()
                          : JButton(
                              onPress: () {
                                if (resumeController.noResume == false.obs) {
                                  return;
                                } else {
                                  resumeController.deleteCV();
                                }
                              },
                              text: "Delete File",
                              prefixIcon: const Icon(Icons.delete_forever),
                              borderRadius: 5,
                              height: 40,
                            );
                    })
                  ],
                );
              }),
        ),
      ),
    );
  }
}
