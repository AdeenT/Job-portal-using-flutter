import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreenController extends GetxController {
  final googleSignIn = GoogleSignIn();

  Future logout() async {
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
