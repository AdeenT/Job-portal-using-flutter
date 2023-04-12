import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/home_screen/controller/home_screen_controller.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/job_details_screen/view/job_details.dart';
import 'package:flutter_application_1/screens/login_and_signup/login_page.dart';
import 'package:flutter_application_1/widgets/Text/text.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const JText(
              text: 'Hello User',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  JSpace.vertical(30),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: CupertinoTextField(
                            padding: const EdgeInsets.all(10),
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 10),
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
                              border: Border.all(
                                  color: Colors.cyan.withOpacity(0.2)),
                            ),
                            placeholder: 'Search',
                            placeholderStyle: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await controller.logout();
                          Get.offAll(LoginPage());
                        },
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.blue.withOpacity(0.4),
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  JSpace.vertical(40),
                  const Text("Available Jobs"),
                  JSpace.vertical(20),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('recruiter')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var recruitersList = snapshot.data!.docs;
                      if (recruitersList.isEmpty) {
                        log(recruitersList.length.toString());
                        return const Text("Error");
                      } else if (recruitersList.isNotEmpty) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 6),
                            shrinkWrap: true,
                            itemCount: recruitersList.length,
                            itemBuilder: (context, index) {
                              String recruiterUID = recruitersList[index].id;
                              var vacanciesCollectionRef = FirebaseFirestore
                                  .instance
                                  .collection('recruiter')
                                  .doc(recruiterUID)
                                  .collection('vacancies');
                              return jobCard(
                                vacanciesCollectionRef,
                              );
                            });
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
      },
    );
  }

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
              padding: EdgeInsets.only(bottom: AppSize.width * 0.03),
              itemBuilder: (context, index) {
                VacancyModel addJobModel =
                    VacancyModel.fromJson(vacancyList[index].data());
                return GestureDetector(
                  onTap: () {
                    Get.to(JobDetailsScreen(
                      currentJobId: vacancyList[index].id,
                      vacancyModel: addJobModel,
                    ));
                  },
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addJobModel.position,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  JSpace.vertical(10),
                                  Text(
                                    addJobModel.companyName,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  JSpace.vertical(10),
                                  Text(
                                    "${addJobModel.location} - ${addJobModel.type}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            JSpace.horizontal(10),
                            Column(
                              children: [
                                Text(
                                  "${addJobModel.salary} LPA",
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
                );
              });
        });
  }

  Widget jobCategory(String category) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColor.primary,
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
