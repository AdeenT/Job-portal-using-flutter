import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/selection_screen/controller/selection_screen_controller.dart';
import 'package:get/get.dart';

class SelectionScreen extends StatelessWidget {
  SelectionScreen({super.key});
  final controller = Get.put(SelectionScreenController);
  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    final width = Get.size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.12),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Icon(
                Icons.person_pin_rounded,
                color: Colors.blue.withOpacity(0.4),
                size: 28,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                'What are you looking for?',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GetBuilder<SelectionScreenController>(
                builder: (controller) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.seekerButtonTap();
                      },
                      child: JobRoleButtonWidget(
                        icon: Icons.hail,
                        text: 'I want a Job',
                        elevation: controller.elevation1,
                        visibility: controller.checkVisibility1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.recruterButtonTap();
                      },
                      child: JobRoleButtonWidget(
                        icon: Icons.groups_outlined,
                        text: 'I want an employee',
                        elevation: controller.elevation2,
                        visibility: controller.checkVisibility2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                      },
                      color: Colors.white70,
                      elevation: 2,
                      child: const Text(
                        'Start',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
