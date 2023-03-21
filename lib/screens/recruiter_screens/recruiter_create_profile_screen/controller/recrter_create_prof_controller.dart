import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/view/recruiter_home_page.dart';
import 'package:get/get.dart';

import 'package:flutter_application_1/core/constants/app_size.dart';
import '../../../../models/recruiter/recruiter_model.dart';

class RecruiterCreateProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  textField(
    String label,
    TextEditingController controller,
    TextInputType type,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill this field";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white54,
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  subHeading(String subheading) {
    return Padding(
      padding: EdgeInsets.only(left: AppSize.width * 0.05),
      child: Text(
        subheading,
        style:
            const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }

  void onConfirmClicked() {
    final recruiter = RecruiterModel(
      recruiterName: nameController.text,
      recruiterEmail: emailController.text,
      recruiterAddress: addressController.text,
      recruiterPlace: countryController.text,
      recruiterDate: dateController.text,
    );
    createSeeker(recruiter);

    Get.off(RecruiterHomePage());
  }

  Future createSeeker(RecruiterModel seeker) async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    final docSeeker = FirebaseFirestore.instance.collection("recruiter");
    docSeeker.doc(userUID).set(({
          "user details": {seeker.toMap()}
        }));
  }
}
