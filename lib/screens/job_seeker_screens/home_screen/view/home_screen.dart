// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    final width = Get.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello, User!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text("All jobs"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text("Developer"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text("Designer"),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 6),
                itemBuilder: (context, index) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    color: Colors.orange,
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: Text("logo"),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "UI/UX Designer",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text(
                                        "AirBNB",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text(
                                        "India - Full Time",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.bookmark_border_rounded,
                                              size: 25,
                                              color:
                                                  Colors.blue.withOpacity(0.4),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "3-6 lpa",
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
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
