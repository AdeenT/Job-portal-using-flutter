import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recruiter_screens/create_vacancy/view/create_vacany.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RecruiterHomeScreenController extends GetxController {
  final height = Get.size.height;
  final width = Get.size.width;
  final googleSignIn = GoogleSignIn();

  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  jobCard(
    String logo,
    String jobTitle,
    String companyName,
    String location,
    String jobType,
    String salary,
  ) {
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
                      child: Center(
                        child: Text(logo),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          companyName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          "$location - $jobType",
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
                          "$salary lpa",
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

  createVacancyButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: Colors.blue.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        Get.to(CreateVacancyScreen());
      },
      child: const Text(
        "Create Vacancy",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
