// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/job_seeker_screens/navbar/view/navbar.dart';
import 'package:get/get.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
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
                height: 10,
              ),
              Text(
                "Lets create your profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Full Name"),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      "Full Name",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Email"),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      "Email",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Date of birth"),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      "Date of birth",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Address"),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      "Address",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Occupation"),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      "Current occupation",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Get.to(NavBar());
                    },
                    child: const Text(
                      "Confirm",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
