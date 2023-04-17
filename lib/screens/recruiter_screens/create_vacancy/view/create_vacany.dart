import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/recruiter_model.dart';
import 'package:flutter_application_1/screens/recruiter_screens/create_vacancy/controller/create_vacancy_controller.dart';
import 'package:get/get.dart';

class CreateVacancyScreen extends StatelessWidget {
  CreateVacancyScreen({super.key});
  final controller = Get.put(VacancyController());

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create vacancy",
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
      body: GetBuilder<VacancyController>(
        builder: (controller) => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
                controller.textField("Position", controller.positionController,
                    TextInputType.text, "Job role"),
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
                controller.textField("Salary", controller.salaryController,
                    TextInputType.number, "Annual salary LPA eg: 5 "),
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
                controller.textField("Location ", controller.locationController,
                    TextInputType.text, "Location"),
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
                controller.textField("Type ", controller.typeController,
                    TextInputType.text, "Full time, part time etc..."),
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
                controller.textField(
                    "Company Name",
                    controller.companyController,
                    TextInputType.text,
                    "Company Name"),
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
                controller.jobDescriptionBox(),
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('recruiter')
                        .doc(currentUser)
                        .snapshots(),
                    builder: (context, snapshot) {
                      {
                        if (!snapshot.hasData) return const SizedBox();
                      }
                      RecruiterModel recruiterModel =
                          RecruiterModel.fromMap(snapshot.data!.data()!);
                          return controller.button(recruiterModel);
                    }),
                SizedBox(
                  height: AppSize.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
