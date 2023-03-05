

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/navbar/view/navbar.dart';
import 'package:get/get.dart';
import '../../../../core/global.dart';
import '../../../../models/seeker_model.dart';

class CreateProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final formKey = GlobalKey<FormState>();


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
      padding: EdgeInsets.only(left: width * 0.05),
      child: Text(
        subheading,
        style:
            const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }

  void onConfirmClicked()async{
      final seeker = SeekerModel(
    seekerName: nameController.text,
    seekerAge: ageController.text,
    seekerAddress: addressController.text,
    seekerOccupation: occupationController.text,
  );
    if (formKey.currentState!.validate()){
      await createSeeker(seeker);
      Get.off(NavBar());
    }else {
          Get.snackbar(
            'Error',
            'Please complete this form',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
  }

  Future createSeeker(SeekerModel seeker) async{
    try {
       String userUID = FirebaseAuth.instance.currentUser!.uid;
    final docSeeker = FirebaseFirestore.instance.collection("seeker");
    docSeeker.doc(userUID).update(seeker.toMap());
    log(seeker.toMap().toString());
      
    }on FirebaseException catch (e) {
      log(e.code);
      
    }
   
  }


}
