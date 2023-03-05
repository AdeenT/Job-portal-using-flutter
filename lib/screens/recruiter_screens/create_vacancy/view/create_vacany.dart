import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/global.dart';
import 'package:flutter_application_1/screens/recruiter_screens/create_vacancy/controller/create_vacancy_controller.dart';
import 'package:get/get.dart';

class CreateVacancyScreen extends StatelessWidget {
  CreateVacancyScreen({super.key});
  final controller = Get.put(VacancyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.button(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text(
          "Create vacancy",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.blue.shade400,
        ),
      ),
      body: GetBuilder<VacancyController>(
        builder: (controller) => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  color: Colors.orange,
                  height: 100,
                  width: 100,
                  child: const Center(
                    child: Text("logo"),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                const Divider(
                  color: Colors.black54,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                controller.subHeading("Open Position"),
                controller.textField("Name of the Position",
                    controller.positionController, TextInputType.text),
                SizedBox(
                  height: height * 0.03,
                ),
                controller.subHeading("Salary"),
                controller.textField("Salary per month",
                    controller.salaryController, TextInputType.number),
                SizedBox(
                  height: height * 0.03,
                ),
                controller.subHeading("Location"),
                controller.textField("Location ", controller.locationController,
                    TextInputType.text),
                SizedBox(
                  height: height * 0.03,
                ),
                controller.subHeading("Type"),
                controller.textField(
                    "Type ", controller.typeController, TextInputType.text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
