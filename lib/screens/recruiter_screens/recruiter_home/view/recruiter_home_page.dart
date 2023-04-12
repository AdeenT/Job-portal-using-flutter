import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_and_signup/login_page.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/controller/recr_home_controller.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/widgets/get_job_lists_widget.dart';
import 'package:get/get.dart';

class RecruiterHomePage extends StatelessWidget {
  RecruiterHomePage({super.key});
  final controller = Get.put(RecruiterHomeScreenController());

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    final width = Get.size.width;
    return Scaffold(
      floatingActionButton: controller.createVacancyButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: controller.companyName("TCS"),
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
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.85,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: CupertinoTextField(
                          padding: EdgeInsets.all(height * 0.01),
                          prefix: Padding(
                            padding: EdgeInsets.only(left: width * 0.02),
                            child: Icon(
                              CupertinoIcons.search,
                              color: Colors.grey.shade600,
                              size: 21,
                            ),
                          ),
                          clearButtonMode: OverlayVisibilityMode.editing,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: Colors.cyan.withOpacity(0.2)),
                          ),
                          placeholder: 'Search',
                          placeholderStyle:
                              TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await controller.logout();
                          Get.offAll(LoginPage());
                        },
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.blue.withOpacity(0.4),
                          size: 35,
                        ))
                  ],
                ),
                SizedBox(
                  height: height * 0.06,
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
                          length: jobList.length, jobList: jobList);
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
