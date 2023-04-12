// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/home_screen/controller/home_screen_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AppliedScreen extends StatelessWidget {
  AppliedScreen({super.key});

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final height = Get.size.height;
    final width = Get.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Applied Jobs",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                width: width * 0.9,
                child: CupertinoTextField(
                  padding: EdgeInsets.all(height * 0.01),
                  prefix: Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey.shade600,
                      size: 21,
                    ),
                  ),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.cyan.withOpacity(0.2)),
                  ),
                  placeholder: 'Search',
                  placeholderStyle: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('AppliedUser')
                    .doc(currentUserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var appliedJobsList = snapshot.data!.data()!['appliedJobs'];
                  if (appliedJobsList.isEmpty) {
                    log(appliedJobsList.length.toString());
                    return const Text("Error");
                  } else if (appliedJobsList.isNotEmpty) {
                    return SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
