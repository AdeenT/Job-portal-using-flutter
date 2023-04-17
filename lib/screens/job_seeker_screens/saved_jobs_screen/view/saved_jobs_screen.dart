import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';
import 'package:flutter_application_1/models/seeker/saved_jobs.dart';
import 'package:flutter_application_1/widgets/container/container.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';

class SavedJobs extends StatelessWidget {
  const SavedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Jobs",
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
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('seeker')
            .doc(userId)
            .collection('SavedJobs')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var savedJobsList = snapshot.data!.docs;

          if (savedJobsList.isNotEmpty) {
            return getSavedJobList(
              userId,
            );
          } else {
            return const Center(
              child: Text("You don't have any saved jobs"),
            );
          }
        },
      )),
    );
  }

  getSavedJobList(
    user,
  ) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('seeker')
          .doc(user)
          .collection('SavedJobs')
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        log(user);
        var savedJobsId = snapshot.data!.docs;
        log(savedJobsId[0].data().toString());
        return ListView.separated(
          itemCount: savedJobsId.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.transparent,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: AppSize.width * 0.03),
          itemBuilder: (context, index) {
            Bookmark addSavedJobs = Bookmark.fromMap(savedJobsId[index].data());
            return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  JSpace.vertical(10),
                  JContainer(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppSize.width * 0.05,
                    ),
                    elevation: 1,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
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
                                  addSavedJobs.companyLogo,
                                  fit: BoxFit.cover,
                                )),
                            JSpace.horizontal(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addSavedJobs.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  JSpace.vertical(10),
                                  Text(
                                    addSavedJobs.companyName,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  JSpace.vertical(10),
                                  Text(
                                    "${addSavedJobs.location} - ${addSavedJobs.type}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            JSpace.horizontal(10),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.bookmark_rounded,
                                    size: 22,
                                    color: AppColor.tertiary,
                                  ),
                                ),
                                Text(
                                  "${addSavedJobs.salary} LPA",
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
                ],
              ),
            );
          },
        );
      },
    );
  }
}
