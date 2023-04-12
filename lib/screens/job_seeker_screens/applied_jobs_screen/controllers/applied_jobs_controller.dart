import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/job_details_screen/view/job_details.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';

class AppliedJobsController extends GetxController {
  final height = Get.size.height;
  final width = Get.size.width;
  Widget appliedStatus(String status) {
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
        status,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget appliedJobs(
      CollectionReference<Map<String, dynamic>> vacancieCollectionRef) {
    return GestureDetector(
      onTap: () {},
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.orange,
                      height: 100,
                      width: 100,
                      child: const Center(
                        child: Text("logo"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "UI/UX Designer",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        const Text(
                          "AirBNB",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "3-6 L",
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
                SizedBox(
                  height: height * 0.05,
                ),
                const Divider(
                  color: Colors.black54,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Center(
                  child: SizedBox(
                    width: width * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.orange.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Pending",
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
        ),
      ),
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
                                backgroundColor: Colors.orange.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Pending",
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
        });
  }
}
