import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/applied_jobs_screen/views/applied_screen.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/home_screen/view/home_screen.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/view/profile_screen.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/saved_jobs_screen/view/saved_jobs_screen.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  var index = 0.obs;
  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return const AppliedScreen();
      case 2:
        return const SavedJobs();
      case 3:
        return const ProfileScreen();
      default:
        return HomeScreen();
    }
  }
}
