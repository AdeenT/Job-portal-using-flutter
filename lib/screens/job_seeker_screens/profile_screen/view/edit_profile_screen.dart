import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/utils/logger.dart';
import 'package:flutter_application_1/models/seeker_model.dart';
import 'package:flutter_application_1/widgets/Text/text.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key, required this.seekerModel});

  final SeekerModel seekerModel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameController.text = seekerModel.seekerName;
      ageController.text = seekerModel.seekerAge;
      addressController.text = seekerModel.seekerAddress;
      occupationController.text = seekerModel.seekerOccupation;
      emailController.text = seekerModel.seekerEmail;
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
              jTextField(seekerModel.seekerName, nameController),
              JSpace.vertical(20),
              jSubHeading('Email'),
              jTextField(seekerModel.seekerEmail, emailController),
              JSpace.vertical(20),
              jSubHeading('Age'),
              jTextField(seekerModel.seekerAge, ageController),
              JSpace.vertical(20),
              jSubHeading('Address'),
              jTextField(seekerModel.seekerAddress, addressController),
              JSpace.vertical(20),
              jSubHeading('Occupation'),
              jTextField(seekerModel.seekerOccupation, occupationController),
              JSpace.vertical(35),
              JButton(
                onPress: () {
                  onConfirmClicked(
                      nameController.text,
                      ageController.text,
                      seekerModel.seekerDpUrl,
                      emailController.text,
                      occupationController.text,
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

  void onConfirmClicked(String name, String age, String dpurl, String email,
      String occupation, String address) async {
    final seeker = SeekerModel(
        seekerName: name,
        seekerAddress: address,
        seekerAge: age,
        seekerEmail: email,
        seekerOccupation: occupation,
        seekerDpUrl: dpurl);
    await createSeeker(seeker);
    Get.snackbar('Success', 'Your profile has been updated',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.greenAccent);
  }

  Future createSeeker(SeekerModel seeker) async {
    try {
      String userUID = FirebaseAuth.instance.currentUser!.uid;
      final docSeeker = FirebaseFirestore.instance.collection("seeker");
      docSeeker.doc(userUID).update(seeker.toMap());
      Logger.info(seeker.toMap().toString());
    } on FirebaseException catch (e) {
      Logger.error(e.code);
    }
  }
}
