import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/global.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:get/get.dart';

class JobDetailController extends GetxController {
  String applyingButton = "notApplied";

  jobCard(VacancyModel vacancyModel) {
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.05,
        left: width * 0.05,
        right: width * 0.05,
      ),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vacancyModel.position,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        vacancyModel.companyName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  jobDetails(VacancyModel vacancyModel) {
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.1,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.1,
              ),
              Text(
                "salary",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "type",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "location",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
            ],
          ),
          SizedBox(
            width: width * 0.38,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${vacancyModel.salary} lpa",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                vacancyModel.type,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                vacancyModel.location,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.withOpacity(0.6),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  jobDescription(VacancyModel vacancyModel) {
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.03,
        right: width * 0.05,
        left: width * 0.05,
      ),
      child: Column(
        children: [
          const Text(
            "Job Requirements",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            vacancyModel.description,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  applyButton(String currentJobId, VacancyModel vacancyModel) {
    return FutureBuilder(
      future: checkUserJobApplied(
          FirebaseAuth.instance.currentUser!.uid, currentJobId),
      builder: (context, snapshot) {
        return !(snapshot.connectionState == ConnectionState.done)
            ? const CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.only(
                  top: height * 0.03,
                  left: width * 0.05,
                  right: width * 0.05,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      backgroundColor: Colors.blue.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      String userID = FirebaseAuth.instance.currentUser!.uid;
                      String recruiterID = vacancyModel.recruiterId.toString();
                      FirebaseFirestore.instance
                          .collection('recruiter')
                          .doc(recruiterID)
                          .collection('vacancies')
                          .doc(currentJobId)
                          .update(
                        {
                          'applied': FieldValue.arrayUnion([
                            {'uid': userID, 'appliedTime': DateTime.now()}
                          ])
                        },
                      );
                      applyButtonClicked(userID, currentJobId);
                    },
                    child: Text(
                      applyingButton == 'notApplied' ? "Apply" : "Applied",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  Future<void> checkUserJobApplied(String userID, String currentJobId) async {
    log(currentJobId);
    log('Checking if user is applied');
    var appliedUsers =
        FirebaseFirestore.instance.collection('AppliedUsers').doc(userID);
    var appliedUsersRef = await appliedUsers.get();
    if (!appliedUsersRef.exists) {
      log('user not applied the job');
      update();
      return;
    }
    List<dynamic> appliedJobIds = appliedUsersRef.get('appliedJobs');
    if (appliedJobIds
        .where((element) => element.toString() == currentJobId)
        .isNotEmpty) {
      log('user applied the job');
      applyingButton = "applied";
      update();
    } else {
      log('user not applied the job');
      applyingButton;
      update();
    }
    log('Checking whether the user is applied or not');
  }

  applyButtonClicked(String userId, String currentJobId) async {
    var appliedUsers =
        FirebaseFirestore.instance.collection("AppliedUsers").doc(userId);
    var appliedUsersSnapshot = await appliedUsers.get();
    if (appliedUsersSnapshot.exists) {
      await appliedUsers.update({
        'appliedJobs': FieldValue.arrayUnion([currentJobId])
      });
    } else {
      appliedUsers.set({
        'appliedJobs': FieldValue.arrayUnion([currentJobId])
      });
    }

    var appliedUsersRef = await appliedUsers.get();
    List<dynamic> appliedJobIds = appliedUsersRef.get('appliedJobs');
    if (appliedJobIds
        .where((element) => element.toString() == currentJobId)
        .isNotEmpty) {
      log('user applied the job');
      applyingButton = 'applied';
      update();
    } else {
      log('user not applied the job');
    }

    log('Current Applide status: $applyingButton');
  }
}
