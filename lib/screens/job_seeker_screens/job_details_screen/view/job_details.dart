import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/recruiter/vacancy_model.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/job_details_screen/controller/job_details_controller.dart';
import 'package:get/get.dart';

class JobDetailsScreen extends StatelessWidget {
  JobDetailsScreen({
    super.key,
    required this.vacancyModel,
    required this.currentJobId,
  });

  final controller = Get.put(JobDetailController());
  final VacancyModel vacancyModel;
  final String currentJobId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.applyButton(currentJobId, vacancyModel),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              height: AppSize.height * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}
