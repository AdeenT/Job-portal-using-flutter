import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/accepted_model.dart';
import 'package:flutter_application_1/widgets/Text/text.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/state_manager.dart';

class AcceptedController extends GetxController {
  String userUID = FirebaseAuth.instance.currentUser!.uid;

  showCandidatesList(int length,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> candidateList) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 6),
        itemBuilder: (context, index) {
          final acceptedModel =
              AcceptedModel.fromMap(candidateList[index].data());
          return JContainer(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: AppSize.width * 0.05),
            elevation: 1,
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JSpace.horizontal(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JText(
                          text: acceptedModel.candidateName,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        JSpace.vertical(10),
                        JText(
                          text: acceptedModel.candidateEmail,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        JSpace.vertical(10),
                        JText(
                          text: acceptedModel.candidateOccupation,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        JSpace.vertical(10),
                        JText(
                          text:
                              "applied job : ${acceptedModel.candidateAppliedJob.toUpperCase()}",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
            ),
        itemCount: length);
  }
}
