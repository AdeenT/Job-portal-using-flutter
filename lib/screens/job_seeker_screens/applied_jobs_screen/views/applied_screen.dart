// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/core/utils/logger.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/applied_jobs_screen/controllers/applied_jobs_controller.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/home_screen/controller/home_screen_controller.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
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
              JSpace.vertical(30),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('AppliedUsers')
                    .doc(currentUserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<dynamic> appliedJobIds =
                      snapshot.data!.get('appliedJobs');
                  if (appliedJobIds.isEmpty) {
                    return const Text("Error");
                  } else {
                    return ListView.separated(
                        itemCount: appliedJobIds.length,
                        separatorBuilder: (context, index) => const Divider(
                              color: Colors.transparent,
                            ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: AppSize.width * 0.03),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: JContainer(
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSize.width * 0.05,
                              ),
                              elevation: 1,
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: Colors.orange,
                                        height: 75,
                                        width: 75,
                                        child: const Center(
                                          child: Text("logo"),
                                        ),
                                      ),
                                      JSpace.horizontal(10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            JText(
                                              text: appliedJobIds[index]
                                                  ['JobTitle'],
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            JSpace.vertical(10),
                                            JText(
                                              text: appliedJobIds[index]
                                                  ['companyName'],
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            JSpace.vertical(10),
                                            JText(
                                              text: appliedJobIds[index]
                                                  ['JobLocation'],
                                              fontSize: 13,
                                            ),
                                          ],
                                        ),
                                      ),
                                      JSpace.horizontal(10),
                                      Column(
                                        children: [
                                          JText(
                                            text:
                                                "${appliedJobIds[index]['JobSalary']} LPA",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  JSpace.vertical(10),
                                  const Divider(
                                    color: Colors.black54,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: width * 0.7,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              Colors.orange.withOpacity(0.2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          appliedJobIds[index]['status'],
                                          style: TextStyle(
                                              color: Colors.orange.shade300,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
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
