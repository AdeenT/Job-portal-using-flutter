// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    final width = Get.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.blue.shade400,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            ListTile(
                leading: Icon(Icons.notification_important),
                title: Text('Notifications'),
                trailing: Icon(Icons.arrow_forward_ios),
                tileColor: Colors.blue.withOpacity(0.05),
                iconColor: Colors.blue.withOpacity(0.6),
                onTap: () {}),
           
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Security'),
              trailing: Icon(Icons.arrow_forward_ios),
              tileColor: Colors.blue.withOpacity(0.05),
              iconColor: Colors.blue.withOpacity(0.6),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: const Text('App Theme'),
              trailing: Icon(Icons.arrow_forward_ios),
              tileColor: Colors.blue.withOpacity(0.05),
              iconColor: Colors.blue.withOpacity(0.6),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              trailing: Icon(Icons.arrow_forward_ios),
              tileColor: Colors.blue.withOpacity(0.05),
              iconColor: Colors.blue.withOpacity(0.6),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Help'),
              trailing: Icon(Icons.arrow_forward_ios),
              tileColor: Colors.blue.withOpacity(0.05),
              iconColor: Colors.blue.withOpacity(0.6),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.door_front_door_outlined),
              title: const Text('Exit'),
              tileColor: Colors.blue.withOpacity(0.05),
              iconColor: Colors.red.withOpacity(0.6),
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
