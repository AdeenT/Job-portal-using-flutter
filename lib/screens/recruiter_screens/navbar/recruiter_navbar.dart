import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recruiter_screens/navbar/controller.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class RecruiterNavBar extends StatelessWidget {
  RecruiterNavBar({super.key});
  final recruiterNavbarController = Get.put(RecruiterNavbarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GNav(
              padding: const EdgeInsets.all(9),
              backgroundColor: Colors.white,
              color: Colors.blue.withOpacity(0.6),
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blue.withOpacity(0.6),
              gap: 10,
              onTabChange: (value) {
                recruiterNavbarController.index.value = value;
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.person_pin,
                  text: "Profle",
                )
              ],
            ),
          ),
        ),
        body: recruiterNavbarController
            .getPage(recruiterNavbarController.index.value),
      ),
    );
  }
}
