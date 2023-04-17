import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/accepted_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/view/view_resume.dart';
import 'package:flutter_application_1/screens/recruiter_screens/accepted_candidates/controller/accepted_controller.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:flutter_application_1/widgets/text/text.dart';
import 'package:get/get.dart';

class AcceptedCandidates extends StatelessWidget {
  AcceptedCandidates({super.key});

  final controller = Get.put(AcceptedController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const JText(
            text: "Selected Candidates",
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: GetBuilder<AcceptedController>(
            builder: (controller) => SingleChildScrollView(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('recruiter')
                      .doc(controller.userUID)
                      .collection('acceptedUsers')
                      .orderBy('createdTime', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var acceptedCandidatesList = snapshot.data!.docs;
                    if (acceptedCandidatesList.isEmpty) {
                      return const Center(
                        child: Text("You haven't selected any candidates"),
                      );
                    } else if (acceptedCandidatesList.isNotEmpty) {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 6),
                          itemBuilder: (context, index) {
                            final acceptedModel = AcceptedModel.fromMap(
                                acceptedCandidatesList[index].data());
                            return GestureDetector(
                              onTap: () {
                                Get.to(ResumeViewPage(
                                    resumeUrl: acceptedModel.candidateCv));
                              },
                              child: JContainer(
                                margin: EdgeInsets.symmetric(
                                    horizontal: AppSize.width * 0.05),
                                elevation: 1,
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            maxRadius: 40,
                                            backgroundImage: NetworkImage(
                                              acceptedModel.candidatePhoto
                                                  .toString(),
                                            ),
                                          ),
                                          JSpace.horizontal(25),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                JText(
                                                  text: acceptedModel
                                                      .candidateName,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                JSpace.vertical(10),
                                                JText(
                                                  text: acceptedModel
                                                      .candidateEmail,
                                                  fontSize: 13,
                                                ),
                                                JText(
                                                  text: acceptedModel
                                                      .candidateOccupation,
                                                  fontSize: 13,
                                                ),
                                                JSpace.vertical(10),
                                                JText(
                                                  text:
                                                      "applied job : ${acceptedModel.candidateAppliedJob.toUpperCase()}",
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                                color: Colors.transparent,
                              ),
                          itemCount: acceptedCandidatesList.length);
                    } else {
                      return const SizedBox();
                    }
                  },
                ))));
  }
}
