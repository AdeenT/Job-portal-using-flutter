import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/controller/recr_home_controller.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/widgets/get_job_lists_widget.dart';
import 'package:flutter_application_1/widgets/Text/text.dart';
import 'package:get/get.dart';

class RecruiterHomePage extends StatelessWidget {
  RecruiterHomePage({super.key});
  final controller = Get.put(RecruiterHomeScreenController());

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    return Scaffold(
      floatingActionButton: controller.createVacancyButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const JText(
          text: "My Jobs",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<RecruiterHomeScreenController>(
        builder: (controller) => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('recruiter')
                      .doc(controller.userUID)
                      .collection('vacancies')
                      .orderBy('createdTime', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var jobList = snapshot.data!.docs;
                    if (jobList.isEmpty) {
                      return const Center(
                          child: Text("You haven't posted any vacancies"));
                    } else if (jobList.isNotEmpty) {
                      return ShowJobListWidget(
                        length: jobList.length,
                        jobList: jobList,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
