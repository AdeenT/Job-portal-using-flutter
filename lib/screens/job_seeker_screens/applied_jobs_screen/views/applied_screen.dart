// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/logger.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/applied_jobs_screen/controllers/applied_jobs_controller.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/home_screen/controller/home_screen_controller.dart';
import 'package:flutter_application_1/widgets/text/text.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AppliedScreen extends StatelessWidget {
  AppliedScreen({super.key});

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  final appliedController = Get.put(AppliedJobsController());
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
                height: height * 0.05,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('AppliedUsers')
                    .doc(currentUserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var appliedJobsList = snapshot.data!.data()!['appliedJobs'];
                  if (appliedJobsList == null) {
                    log(appliedJobsList.length.toString());
                    return const Text("Error");
                  } else if (appliedJobsList.isNotEmpty) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('recruiter')
                          .snapshots(),
                      builder: (context, snapshots) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        var recruiterList = snapshots.data!.docs;
                        if (recruiterList.isEmpty) {
                          return const Text("Error");
                        } else if (recruiterList.isNotEmpty) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 6),
                            shrinkWrap: true,
                            itemCount: appliedJobsList.length,
                            itemBuilder: (context, index) {
                              String jobId = appliedJobsList[index];
                              Logger.info(jobId);
                              String recruiterId = recruiterList[index].id;
                              var vacanciesCollections = FirebaseFirestore
                                  .instance
                                  .collection('recruiter')
                                  .doc(recruiterId)
                                  .collection('vacancies');

                              if (jobId == vacanciesCollections) {
                                return appliedController
                                    .jobCard(vacanciesCollections);
                              } else {
                                return Center(
                                  child: JText(
                                      text: "you haven't applied to any jobs"),
                                );
                              }
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
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
