import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/logger.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/text/data_text.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:flutter_application_1/widgets/text/text.dart';
import 'package:get/get.dart';

class JobDetailController extends GetxController {
  String applyingButton = "notApplied";

  jobCard(VacancyModel vacancyModel) {
    return JContainer(
      margin: EdgeInsets.only(
        top: AppSize.height * 0.05,
        left: AppSize.width * 0.05,
        right: AppSize.width * 0.05,
      ),
      elevation: 1,
      borderRadius: BorderRadius.circular(25),
      color: Colors.white,
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const JContainer(
            color: Colors.orange,
            height: 75,
            width: 75,
            child: Center(
              child: Text("Logo"),
            ),
          ),
          JSpace.horizontal(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JText(
                  text: vacancyModel.position,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                JSpace.vertical(10),
                JText(
                  text: vacancyModel.companyName,
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  jobDetails(VacancyModel vacancyModel) {
    return Padding(
      padding: EdgeInsets.only(left: AppSize.width * 0.1),
      child: JDataText(
        labelFontWeight: FontWeight.bold,
        valueFontWeight: FontWeight.bold,
        color: Colors.grey,
        fontSize: 16,
        rows: [
          JDataTextRow(
            label: 'Salary',
            value: "${vacancyModel.salary} LPA",
            color: AppColor.primary,
          ),
          JDataTextRow(
            label: 'Type',
            value: vacancyModel.type,
            color: AppColor.primary,
          ),
          JDataTextRow(
            label: 'Location',
            value: vacancyModel.location,
            color: AppColor.primary,
          ),
        ],
      ),
    );
  }

  jobDescription(VacancyModel vacancyModel) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSize.height * 0.03,
        right: AppSize.width * 0.05,
        left: AppSize.width * 0.05,
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
            height: AppSize.height * 0.03,
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
                  top: AppSize.height * 0.03,
                  left: AppSize.width * 0.05,
                  right: AppSize.width * 0.05,
                ),
                child: JButton(
                  width: double.infinity,
                  height: 50,
                  onPress: () async {
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
                  text: applyingButton == 'notApplied' ? "Apply" : "Applied",
                ),
              );
      },
    );
  }

  Future<void> checkUserJobApplied(String userID, String currentJobId) async {
    Logger.info(currentJobId);
    Logger.info('Checking if user is applied');
    var appliedUsers =
        FirebaseFirestore.instance.collection('AppliedUsers').doc(userID);
    var appliedUsersRef = await appliedUsers.get();
    if (!appliedUsersRef.exists) {
      Logger.success('user not applied the job');
      update();
      return;
    }
    List<dynamic> appliedJobIds = appliedUsersRef.get('appliedJobs');
    if (appliedJobIds
        .where((element) => element.toString() == currentJobId)
        .isNotEmpty) {
      Logger.success('user applied the job');
      applyingButton = "applied";
      update();
    } else {
      Logger.success('user not applied the job');
      applyingButton;
      update();
    }
    Logger.info('Checking whether the user is applied or not');
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
      Logger.success('user applied the job');
      applyingButton = 'applied';
      update();
    } else {
      Logger.success('user not applied the job');
    }

    Logger.info('Current Applide status: $applyingButton');
  }
}
