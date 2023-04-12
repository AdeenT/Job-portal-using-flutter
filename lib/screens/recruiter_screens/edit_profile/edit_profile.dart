// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Text/text.dart';
import 'package:get/get.dart';

import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/utils/logger.dart';
import 'package:flutter_application_1/models/recruiter/recruiter_model.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';

class RecruiterEditProfile extends StatelessWidget {
  RecruiterEditProfile({
    Key? key,
    required this.recruiterModel,
  }) : super(key: key);

  final RecruiterModel recruiterModel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameController.text = recruiterModel.recruiterName;
      dateController.text = recruiterModel.recruiterDate;
      addressController.text = recruiterModel.recruiterAddress;
      placeController.text = recruiterModel.recruiterPlace;
      emailController.text = recruiterModel.recruiterEmail;
    });

    return Scaffold(
      appBar: AppBar(
        title: const JText(
          text: "Edit Profile",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const JText(text: "Let's edit your profile"),
              JSpace.vertical(10),
              const Divider(),
              JSpace.vertical(20),
              jSubHeading('Name'),
              jTextField(recruiterModel.recruiterName, nameController),
              JSpace.vertical(20),
              jSubHeading('Email'),
              jTextField(recruiterModel.recruiterEmail, emailController),
              JSpace.vertical(20),
              jSubHeading('Established Date'),
              jTextField(recruiterModel.recruiterDate, dateController),
              JSpace.vertical(20),
              jSubHeading('Address'),
              jTextField(recruiterModel.recruiterAddress, addressController),
              JSpace.vertical(20),
              jSubHeading('Occupation'),
              jTextField(recruiterModel.recruiterPlace, placeController),
              JSpace.vertical(35),
              JButton(
                onPress: () {
                  onConfirmClicked(
                      nameController.text,
                      dateController.text,
                      recruiterModel.recruiterDp,
                      emailController.text,
                      placeController.text,
                      addressController.text);
                  Get.back();
                },
                text: "done",
                backgroundColor: AppColor.primary,
                elevation: 3,
                height: 40,
                borderRadius: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  jSubHeading(String subheading) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Row(
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

  jTextField(
    String hint,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white54,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void onConfirmClicked(String name, String date, String dpurl, String email,
      String place, String address) async {
    final recruiter = RecruiterModel(
        recruiterName: name,
        recruiterAddress: address,
        recruiterDate: date,
        recruiterEmail: email,
        recruiterPlace: place,
        recruiterDp: dpurl);
    await createSeeker(recruiter);
    Get.snackbar('Success', 'Your profile has been updated',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.greenAccent);
  }

  Future createSeeker(RecruiterModel recruiter) async {
    try {
      String userUID = FirebaseAuth.instance.currentUser!.uid;
      final docRecruiter = FirebaseFirestore.instance.collection("seeker");
      docRecruiter.doc(userUID).update(recruiter.toMap());
      Logger.info(recruiter.toMap().toString());
    } on FirebaseException catch (e) {
      Logger.error(e.code);
    }
  }
}
