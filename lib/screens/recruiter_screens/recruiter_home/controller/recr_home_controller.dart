import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/screens/recruiter_screens/create_vacancy/view/create_vacany.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RecruiterHomeScreenController extends GetxController {
  final height = Get.size.height;
  final width = Get.size.width;

  final googleSignIn = GoogleSignIn();
  String userUID = FirebaseAuth.instance.currentUser!.uid;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? jobList;
  int? length;

  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  createVacancyButton() {
    return JButton(
      onPress: () {
        Get.to(CreateVacancyScreen());
      },
      elevation: 1,
      text: 'Create Vacancy',
      backgroundColor: AppColor.primary,
      height: 50,
      width: AppSize.width * 0.8,
    );
  }

  final searchController = TextEditingController();

  listenSearchController() {
    searchController.addListener(() {
      update();
    });
  }
}
