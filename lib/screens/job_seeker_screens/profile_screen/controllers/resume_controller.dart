import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/state_manager.dart';

class ResumeController extends GetxController {
  
   RxBool noResume = true.obs;
  Future<String> userUploadCV(File file) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var storageRef =
        FirebaseStorage.instance.ref().child('seeker/cv/$currentUserId.pdf');

    await storageRef.putFile(file);
    String userCvUrl = await storageRef.getDownloadURL();
    return userCvUrl;
  }

  void deleteCV() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var storageRef =
        FirebaseStorage.instance.ref().child('seeker/cv/$currentUserId.pdf');

    await storageRef.delete();
    await FirebaseFirestore.instance
        .collection('seeker')
        .doc(currentUserId)
        .update({'cv': null});
    update();
  }
}
