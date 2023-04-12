import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/recruiter_screens/create_vacancy/view/create_vacany.dart';
import 'package:flutter_application_1/widgets/button/button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RecruiterHomeScreenController extends GetxController {
  final height = Get.size.height;
  final width = Get.size.width;
  final googleSignIn = GoogleSignIn();
  String userUID = FirebaseAuth.instance.currentUser!.uid;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? jobList;
  int? length;

  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  jobCard(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> jobList,
    int length,
  ) {
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
                            Text(
                              vacancyModel.position.capitalizeFirst.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              vacancyModel.companyName.capitalizeFirst
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              "${vacancyModel.location.capitalizeFirst} - ${vacancyModel.type.capitalizeFirst}",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
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
          ),
        );
      },
    );
  }

  companyName(String name) {
    return Text(
      "Welcome, $name!",
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

  createVacancyButton() {
    return JButton(
      onPress: () {
        Get.to(CreateVacancyScreen());
      },
      elevation: 1,
      text: 'Create Vacancy',
      backgroundColor: AppColor.primary,
      height: 50,
      width: AppSize.width * 0.8,
    );
  }

  Future getJobVacancies() async {}
}
