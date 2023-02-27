// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/home_screen/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    final width = Get.size.width;
    return Scaffold(
      appBar: AppBar(
        title: controller.userName("User"),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<HomeScreenController>(
        builder: (controller) => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
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
                        onPressed: () {},
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
                Text("Job Recommendation"),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  children: [
                    controller.jobCategory("All jobs"),
                    SizedBox(
                      width: 10,
                    ),
                    controller.jobCategory("Designer"),
                    SizedBox(
                      width: 10,
                    ),
                    controller.jobCategory("Developer"),
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 6),
                  itemBuilder: (context, index) {
                    return controller.jobCard(
                      "logo",
                      "Designer",
                      "Google LLC",
                      "Hyderabad",
                      "Remote",
                      "5-7",
                    );
                  },
                  itemCount: 5,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
