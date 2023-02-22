// ignore_for_file: prefer_const_constructors

import 'package:flutter_application_1/screens/job_seeker_screens/applied_jobs_screen/views/applied_screen.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/home_screen/view/home_screen.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/view/profile_screen.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/saved_jobs_screen/view/saved_jobs_screen.dart';
import 'package:get/state_manager.dart';

class NavBarController extends GetxController {

var index = 0.obs;
final screens =[
  HomeScreen(),
  AppliedScreen(),
  SavedJobs(),
  ProfileScreen()
];

}
