import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/core/utils/logger.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/job_details_screen/view/job_details.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';

class SavedJobs extends StatelessWidget {
  const SavedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Jobs",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.chat,
              size: 30,
              color: Colors.blue.withOpacity(0.65),
            ),
            onPressed: () {
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SavedJobs')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var savedJobsList = snapshot.data!.data()!['savedJobs'];
          
            if (savedJobsList.isNotEmpty) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 6),
              shrinkWrap: true,
              itemCount: savedJobsList.length,
              itemBuilder: (context, index) {
                // var savedJobsCollectionRefs = FirebaseFirestore.instance
                //     .collection('SavedJobs')
                //     .doc(userId);
                return getSavedJobList(userId);
              },
            );
          } else {
            return const SizedBox();
          }
        },
      )),
    );
  }

  getSavedJobList(
      user) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
                    .collection('SavedJobs')
                    .doc(user).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        log(user);
        Logger.info(snapshot.data!.data()!['savedJobs'].toString());
        var savedJobList = snapshot.data!.data()!['savedJobs'];
        
        return ListView.separated(
          itemCount: savedJobList!.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.transparent,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: AppSize.width * 0.03),
          itemBuilder: (context, index) {
            VacancyModel addSavedJobs =
                VacancyModel.fromJson(savedJobList[index]);
            return GestureDetector(
              onTap: () {
                Get.to(JobDetailsScreen(
                  currentJobId: savedJobList[index].id,
                  vacancyModel: addSavedJobs,
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
                                addSavedJobs.position,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              JSpace.vertical(10),
                              Text(
                                addSavedJobs.companyName,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              JSpace.vertical(10),
                              Text(
                                "${addSavedJobs.location} - ${addSavedJobs.type}",
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
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark_rounded,
                                size: 30,
                                color: AppColor.primary,
                              ),
                            ),
                            Text(
                              "${addSavedJobs.salary} LPA",
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
          },
        );
      },
    );
  }
}
