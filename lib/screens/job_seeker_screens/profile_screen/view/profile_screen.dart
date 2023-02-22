// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    final width = Get.size.width;
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              size: 30,
              color: Colors.blue.withOpacity(0.65),
            ),
            onPressed: () {
              // do somethin
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.1,
                top: height * 0.05,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: height * 0.06,
                    backgroundColor: Colors.blue.withOpacity(0.6),
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          "example@example.com",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          "Flutter Developer",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.11),
              child: Text(
                "Full Name",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Full Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.11),
              child: Text(
                "Email",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "example@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.11),
              child: Text(
                "DOB",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "DD/MM/YYYY",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.11),
              child: Text(
                "Address",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Kerala,India",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.11),
              child: Text(
                "Occupation",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Flutter Developer",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue.withOpacity(0.6),
                  ),
                ),
                child: Text(
                  "Upload CV",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
