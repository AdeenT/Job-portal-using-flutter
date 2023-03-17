import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/global.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/job_details_screen/view/job_details.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreenController extends GetxController {
  final googleSignIn = GoogleSignIn();

  jobCard(CollectionReference<Map<String, dynamic>> vacancieCollectionRef) {
    return FutureBuilder(
        future: vacancieCollectionRef.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          var vacancyList = snapshot.data!.docs;
          return ListView.separated(
              itemCount: vacancyList.length,
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                  ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: width * 0.03),
              itemBuilder: (context, index) {
                VacancyModel addJobModel =
                    VacancyModel.fromJson(vacancyList[index].data());

                log(addJobModel.companyName);

                return GestureDetector(
                  onTap: () {
                    Get.to(JobDetailsScreen(
                      currentJobId: vacancyList[index].id,
                      vacancyModel: addJobModel,
                    ));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                    ),
                    child: Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  color: Colors.orange,
                                  height: 100,
                                  width: 100,
                                  child: const Center(
                                    child: Text("logo"),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      addJobModel.position,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      addJobModel.companyName,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      "${addJobModel.location} - ${addJobModel.type}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bookmark_border_rounded,
                                            size: 25,
                                            color: Colors.blue.withOpacity(0.4),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${addJobModel.salary} lpa",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  Future logout() async {
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  userName(String name) {
    return Text(
      "Hello, $name!",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget jobCategory(String category) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.blue.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
