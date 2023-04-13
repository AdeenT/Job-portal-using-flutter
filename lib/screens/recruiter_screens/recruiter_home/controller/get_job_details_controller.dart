import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/profile_screen/view/view_resume.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:flutter_application_1/widgets/text/data_text.dart';
import 'package:get/get.dart';

class GetJobDetailController extends GetxController {
  String applyingButton = "notApplied";

  jobCard(VacancyModel vacancyModel) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSize.height * 0.05,
        left: AppSize.width * 0.05,
        right: AppSize.width * 0.05,
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
                    width: AppSize.width * 0.05,
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
                        height: AppSize.height * 0.01,
                      ),
                      Text(
                        vacancyModel.companyName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.height * 0.01,
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
        left: AppSize.width * 0.1,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppSize.width * 0.1,
              ),
              Text(
                "salary",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
              SizedBox(
                height: AppSize.height * 0.03,
              ),
              Text(
                "type",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
              SizedBox(
                height: AppSize.height * 0.03,
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
            width: AppSize.width * 0.38,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${vacancyModel.salary} LPA",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: AppSize.height * 0.03,
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
                height: AppSize.height * 0.03,
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

  appliedUsers(
      String name,
      String occupation,
      String image,
      String address,
      String email,
      String age,
      String resumeUrl,
      String currentJobId,
      Map<String, dynamic> appliedUsers) {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSize.width * 0.05,
        right: AppSize.width * 0.05,
      ),
      child: JContainer(
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
                  CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: NetworkImage(image.toString())),
                  SizedBox(
                    width: AppSize.width * 0.05,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: AppSize.height * 0.01,
                        ),
                        Text(
                          occupation,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: AppSize.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                    ),
                    onTap: () async {
                      final docRef = FirebaseFirestore.instance
                          .collection('recruiter')
                          .doc(currentUserId)
                          .collection('vacancies')
                          .doc(currentJobId);
                      var appliedUserss = FirebaseFirestore.instance
                          .collection('AppliedUsers')
                          .doc(appliedUsers['uid']);
                      var appliedUsersRef = await appliedUserss.get();

                      List<dynamic> appliedJobIds =
                          appliedUsersRef.get('appliedJobs');
                      update();
                      List<dynamic> newList = [];
                      for (var element in appliedJobIds) {
                        if (element['JobId'] == currentJobId) {
                          element['status'] = 'Rejected';
                        }
                        newList.add(element);
                      }
                      appliedUserss.set({'appliedJobs': newList});

                      docRef.update({
                        'applied': FieldValue.arrayRemove([appliedUsers])
                      });
                      update();
                    },
                  ),
                  JSpace.horizontal(30),
                  InkWell(
                    child: const Icon(
                      Icons.check,
                      color: Colors.greenAccent,
                    ),
                    onTap: () async {
                      // for updating the status in applied users
                      final docRef = FirebaseFirestore.instance
                          .collection('recruiter')
                          .doc(currentUserId)
                          .collection('vacancies')
                          .doc(currentJobId);
                      var appliedUserss = FirebaseFirestore.instance
                          .collection('AppliedUsers')
                          .doc(appliedUsers['uid']);
                      var appliedUsersRef = await appliedUserss.get();

                      List<dynamic> appliedJobIds =
                          appliedUsersRef.get('appliedJobs');
                      update();
                      // user is accepted
                      List<dynamic> newList = [];
                      for (var element in appliedJobIds) {
                        if (element['JobId'] == currentJobId) {
                          element['status'] = 'Accepted';
                        }
                        newList.add(element);
                      }
                      appliedUserss.set({'appliedJobs': newList});

                      // for creating a new collection for accepted users
                      var acceptedUsersRefs = FirebaseFirestore.instance
                          .collection('recruiter')
                          .doc(currentUserId)
                          .collection('acceptedUsers')
                          .doc(currentJobId);
                      acceptedUsersRefs.set({"id": appliedUsers['uid']});

                      // deleting the user details from the applied candidate section after accepting

                      docRef.update({
                        'applied': FieldValue.arrayRemove([appliedUsers])
                      });
                      update();
                    },
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(ResumeViewPage(resumeUrl: resumeUrl));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("See Resume"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appliedUserDetails(
                          name, age, email, occupation, address, image);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "See Details",
                      style: TextStyle(
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  appliedUserDetails(String name, String age, String email, String occupation,
      String address, String profilepic) {
    Get.bottomSheet(
      Container(
        height: 250.0,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profilepic.toString()),
              maxRadius: 40,
            ),
            JSpace.vertical(30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: JDataText(
                rows: [
                  JDataTextRow(label: 'name', value: name),
                  JDataTextRow(label: 'age', value: age),
                  JDataTextRow(label: 'email', value: email),
                  JDataTextRow(label: 'address', value: address),
                  JDataTextRow(label: 'occupation', value: occupation),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
