// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/navbar/controller/navbar_controller.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final navbarController = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GNav(
              padding: EdgeInsets.all(9),
              backgroundColor: Colors.white,
              color: Colors.blue.withOpacity(0.6),
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blue.withOpacity(0.6),
              gap: 10,
              onTabChange: (value) {
                navbarController.index.value = value;
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.list,
                  text: "Applied",
                ),
                GButton(
                  icon: Icons.bookmark_outlined,
                  text: "Saved",
                ),
                GButton(
                  icon: Icons.person_pin,
                  text: "Profle",
                )
              ],
            ),
          ),
        ),
        body: navbarController.getPage(navbarController.index.value),
      ),
    );
  }
}
