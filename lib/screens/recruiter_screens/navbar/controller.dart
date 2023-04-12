import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/view/recruiter_home_page.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_profile/view/recruiter_profile.dart';
import 'package:get/get.dart';

class RecruiterNavbarController extends GetxController{
    var index = 0.obs;
   Widget getPage(int index) {
    switch (index) {
      case 0:
        return RecruiterHomePage();
      case 1:
        return   RecruiterProfileScreen();
      default:
        return RecruiterHomePage();
    }
  }
}