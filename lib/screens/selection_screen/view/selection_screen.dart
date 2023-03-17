import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/global.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/create_profile_screen/view/create_profile_screen.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_create_profile_screen/view/recr_create_prof.dart';
import 'package:flutter_application_1/screens/selection_screen/controller/selection_screen_controller.dart';
import 'package:get/get.dart';

class SelectionScreen extends StatelessWidget {
  SelectionScreen({super.key});

  final roleController = Get.put(SelectionScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.04,
          ),
          Icon(
            Icons.person_pin_rounded,
            color: Colors.blue.withOpacity(0.4),
            size: 28,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          const Text(
            'What are you looking for?',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          GetBuilder<SelectionScreenController>(
            builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    roleController.seekerButtonTap();
                  },
                  child: JobRoleButtonWidget(
                    icon: Icons.hail,
                    text: 'I want a Job',
                    elevation: roleController.elevation1,
                    visibility: roleController.checkVisibility1,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    roleController.recruterButtonTap();
                  },
                  child: JobRoleButtonWidget(
                    icon: Icons.person_search,
                    text: 'I want an employee',
                    elevation: roleController.elevation2,
                    visibility: roleController.checkVisibility2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    log("message");
                    String userUID = FirebaseAuth.instance.currentUser!.uid;
      
                    
                    if (roleController.selected == 1) {
                      FirebaseFirestore.instance.collection("seeker").doc(userUID).set({"role":"seeker"});
                      FirebaseFirestore.instance.collection("Users").doc(userUID).update({"role":"seeker"});
                      Get.to(CreateProfile());
                    } else if (roleController.selected == 2) {
                       FirebaseFirestore.instance.collection("recruiter").doc(userUID).set({"role":"recruiter"});
                      FirebaseFirestore.instance.collection("Users").doc(userUID).update({"role":"recruiter"});
                      
                      Get.to(RecruiterCreateProfile());
                    } else {
                      Get.snackbar(
                        'Select',
                        'Select your role to continue',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  color: Colors.blue.withOpacity(0.4),
                  elevation: 0.0,
                  child: const Text(
                    'Start',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobRoleButtonWidget extends StatelessWidget {
  JobRoleButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.elevation,
    required this.visibility,
  }) : super(key: key);

  final IconData icon;
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final elevation;
  final bool visibility;

  final rolecontrol = Get.put(SelectionScreenController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.41,
      height: height * 0.15,
      child: Material(
        elevation: elevation,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Colors.blue.withOpacity(0.5),
              ),
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: visibility,
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
