// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionScreenController extends GetxController {
  final height = Get.size.height;
  final width = Get.size.width;
  double elevation1 = 0;
  double elevation2 = 0;
  bool checkVisibility1 = false;
  bool checkVisibility2 = false;
  int selected = 0;
  bottomSheet() {
    return Get.bottomSheet(
      Container(
        height: height * 0.5,
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.person_pin_rounded,
                color: Colors.blue.withOpacity(0.4),
              ),
              Text(
                "What are you looking for?",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [],
              )
            ],
          ),
        ),
      ),
      barrierColor: Colors.black,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: BorderSide(width: 5, color: Colors.black),
      ),
    );
  }

  seekerButtonTap() {
    elevation1 = 3;
    elevation2 = 0;
    checkVisibility1 = true;
    checkVisibility2 = false;
    selected = 1;
    update();
  }

  recruterButtonTap() {
    elevation1 = 0;
    elevation2 = 3;
    checkVisibility1 = false;
    checkVisibility2 = true;
    selected = 2;
    update();
  }
}

class JobRoleButtonWidget extends StatelessWidget {
  JobRoleButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.elevation,
    required this.visibility,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final elevation;
  final bool visibility;

  final rolecontrol = Get.put(SelectionScreenController());

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    final width = Get.size.width;
    return SizedBox(
      width: width * 0.41,
      height: height * 0.14,
      child: Material(
        elevation: elevation,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon),
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Visibility(
                visible: visibility,
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
