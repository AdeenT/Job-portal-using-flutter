import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/view/recruiter_home_page.dart';
import 'package:get/get.dart';

class VacancyController extends GetxController {
  final TextEditingController positionController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();

  jobDescriptionBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18),
      child: TextFormField(
        controller: jobDescriptionController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Job Description',
          hintText: 'Enter job description',
          alignLabelWithHint: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter job description';
          }
          return null;
        },
      ),
    );
  }

  textField(String label, TextEditingController controller, TextInputType type,
      String hintText) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white54,
          hintText: hintText,
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  subHeading(String subheading) {
    return Padding(
      padding: EdgeInsets.only(left: AppSize.width * 0.05),
      child: Text(
        subheading,
        style:
            const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }

  button() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            onPostJobClicked();
          },
          child: const Text(
            "Post Job",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void onPostJobClicked() async {
    final jobPost = VacancyModel(
      recruiterId: FirebaseAuth.instance.currentUser!.uid,
      companyName: companyController.text,
      position: positionController.text,
      salary: salaryController.text,
      location: locationController.text,
      type: typeController.text,
      description: jobDescriptionController.text,
      createdTime: DateTime.now().toString(),
    );
    await postJob(jobPost);
    companyController.clear();
    positionController.clear();
    salaryController.clear();
    locationController.clear();
    typeController.clear();
    jobDescriptionController.clear();
    Get.off(() => RecruiterHomePage());
  }

  Future postJob(VacancyModel jobDetails) async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    final docVacancies = FirebaseFirestore.instance
        .collection("recruiter")
        .doc(userUID)
        .collection('vacancies')
        .doc();

    docVacancies.set(jobDetails.toMap());
  }
}
