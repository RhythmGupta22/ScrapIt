import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:scrap_it/screens/login/views/enter_name.dart';
import 'package:scrap_it/utils/firebase_functions.dart';

class LoginController extends GetxController {
  var isPhoneNumberValid = true.obs;
  final phoneNumberController = TextEditingController();

  void checkPhoneNumber() {
    if (phoneNumberController.text.length == 10) {
      isPhoneNumberValid.value = true;
    } else {
      isPhoneNumberValid.value = false;
    }
    update();
  }

  final otpPinController = TextEditingController();
  final otpFocusNode = FocusNode();
  final otpFormKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final nameFormKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();

  final RxBool isSeller = false.obs;
  final RxBool isCollector = false.obs;

  void updateRole(bool seller, bool collector) {
    isSeller.value = seller;
    isCollector.value = collector;
    update();
  }

  Future<void> loginWithEmailAndPassword() async {
    if (emailFormKey.currentState!.validate()) {
      UserCredential? userCredential = await AuthRepository.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (userCredential == null) {
        Get.snackbar('Error', 'Login failed', backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    }
  }

  void loginWithPhoneNumber() {
    AuthRepository.instance.signInWithPhoneNumber(
      phoneNumber: phoneNumberController.text,
    );
  }

  void createUserWithPhoneNumber({
    required String name,
    required String phoneNumber,
    required String uid,
  }) {
    FirebaseFunctions.instance.createUserWithPhoneNumber(
      name: name,
      phoneNumber: phoneNumber,
      uid: uid,
    );
    nameTextController.clear();
    phoneNumberController.clear();
    otpPinController.clear();
  }

  Future<void> verifyOtp() async {
    if (otpFormKey.currentState!.validate()) {
      UserCredential? userCredential = await AuthRepository.instance.verifyOtp(
        phoneNumber: phoneNumberController.text,
        smsCode: otpPinController.text,
      );
      if (userCredential == null) {
        Get.snackbar('Error', 'OTP verification failed', backgroundColor: Colors.redAccent, colorText: Colors.white);
      } else if (userCredential.user != null) {
        bool userExists = await FirebaseFunctions.instance.checkIfPhoneNumberExists(phoneNumberController.text);
        if (!userExists) {
          Get.to(() => EnterNameScreen(
            phoneNumber: phoneNumberController.text,
            isCollector: isCollector.value,
          ));
        }
      }
    }
  }

  Future<void> signInWithGoogle() async {
    UserCredential? userCredential = await AuthRepository.instance.signInWithGoogle();
    if (userCredential == null) {
      Get.snackbar('Error', 'Google login failed', backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  void logout() {
    AuthRepository.instance.signOut();
    isSeller.value = false;
    isCollector.value = false;
    Get.offAllNamed('/landing');
  }
}