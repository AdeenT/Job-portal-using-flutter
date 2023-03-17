import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_and_signup/login_page.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/navbar/view/navbar.dart';
import 'package:flutter_application_1/screens/recruiter_screens/recruiter_home/view/recruiter_home_page.dart';
import 'package:flutter_application_1/screens/selection_screen/view/selection_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              log('auth stream has data');
              return FutureBuilder(
                  future: isRoleExist(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      log('isRoleExists Completed');
                      if (snapshot.data == 'noRole') {
                        return SelectionScreen();
                      } else if (snapshot.data == 'seeker') {
                        return NavBar();
                      } else {
                        return RecruiterHomePage();
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  });
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!!'),
              );
            } else {
              return LoginPage();
            }
          },
        ),
      );

  Future<String> isRoleExist() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    var docSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userUID).get();
    if (docSnapshot.data() != null) {
      String? role = docSnapshot.data()!['role'];
      return role ?? 'noRole';
    }

    return 'noRole';
  }
}
