import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/widgets/get_job_details.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:get/get.dart';

class ShowJobListWidget extends StatelessWidget {
  const ShowJobListWidget({
    super.key,
    required this.length,
    required this.jobList,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> jobList;
  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.transparent,
      ),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 6),
      itemBuilder: (context, index) {
        final vacancyModel = VacancyModel.fromJson(jobList[index].data());
        return GestureDetector(
          onTap: () {
            Get.to(RecruiterJobDetailsScreen(
              vacancyModel: vacancyModel,
              currentJobId: jobList[index].id,
            ));
          },
          child: JContainer(
            margin: EdgeInsets.symmetric(horizontal: AppSize.width * 0.05),
            elevation: 1,
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 75,
                        width: 75,
                        child: Image.network(
                          vacancyModel.companyLogo,
                          fit: BoxFit.cover,
                        ),
                      ),
                      JSpace.horizontal(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vacancyModel.position.capitalizeFirst.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            JSpace.vertical(10),
                            Text(
                              vacancyModel.companyName.capitalizeFirst
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            JSpace.vertical(10),
                            Text(
                              "${vacancyModel.location.capitalizeFirst} - ${vacancyModel.type.capitalizeFirst}",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      JSpace.vertical(10),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        Colors.green.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    "Active",
                                    style: TextStyle(color: Colors.green),
                                  )),
                            ],
                          ),
                          Text(
                            "${vacancyModel.salary} LPA",
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
        );
      },
    );
  }
}
