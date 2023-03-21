import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/core/utils/logger.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/controller/get_job_details_controller.dart';
import 'package:flutter_application_1/widgets/text/text.dart';
import 'package:get/get.dart';

class RecruiterJobDetailsScreen extends StatelessWidget {
  RecruiterJobDetailsScreen({
    super.key,
    required this.vacancyModel,
    required this.currentJobId,
  });

  final controller = Get.put(GetJobDetailController());
  final VacancyModel vacancyModel;
  final String currentJobId;

  @override
  Widget build(BuildContext context) {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Job Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColor.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            controller.jobCard(vacancyModel),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Divider(
                color: Colors.black54,
              ),
            ),
            controller.jobDetails(vacancyModel),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Divider(
                color: Colors.black54,
              ),
            ),
            controller.jobDescription(vacancyModel),
            SizedBox(
              height: AppSize.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Divider(
                color: Colors.black54,
              ),
            ),
            const Text(
              "Applied Candidates",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: AppSize.height * 0.02,
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('recruiter')
                    .doc(userUID)
                    .collection('vacancies')
                    .doc(currentJobId)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  List<dynamic> appliedUsersList =
                      snapshot.data!.data()?['applied'] ?? [];

                  if (appliedUsersList.isEmpty) {
                    return const JText(
                      text: 'No applied users available!',
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    );
                  }
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('seeker')
                            .doc(appliedUsersList[index]['uid'])
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return controller.appliedUsers(
                              snapshot.data!.get('seekerName').toString(),
                              snapshot.data!
                                  .get('seekerOccupation')
                                  .toString());
                        },
                      );
                    },
                    itemCount: appliedUsersList.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                  );
                }),
            SizedBox(
              height: AppSize.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
