import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scrap_it/landing_screen.dart';
import 'package:scrap_it/screens/login/controller/login_controller.dart';
import 'package:scrap_it/screens/login/views/enter_name.dart';
import 'package:scrap_it/screens/login/views/enter_otp.dart';
import 'package:scrap_it/sharedWidgets/bottom_navbar.dart';
import 'package:scrap_it/utils/firebase_functions.dart';
import 'package:scrap_it/screens/collector/controllers/collector_profile_controller.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialRoute);
    super.onReady();
  }

  _setInitialRoute(User? user) async {
    if (user == null) {
      Get.offAll(() => LandingScreen());
    } else {
      final loginController = Get.find<LoginController>();
      String? role = await FirebaseFunctions.instance.getUserRole(user.uid);
      log('Retrieved role for uid ${user.uid}: $role');

      // For new users or if role is not set, use the selected role from LoginController
      if (role == null) {
        role = loginController.isCollector.value ? 'collector' : 'seller';
        await FirebaseFunctions.instance.setUserRole(uid: user.uid, role: role);
        log('Setting initial role to $role for uid ${user.uid} based on login selection');
      }

      // Navigate based on role
      if (role.toLowerCase() == 'collector') {
        log('Navigating to CollectorHomeScreen for role: $role');
        // Initialize and fetch collector details before navigation
        final collectorController = Get.put(CollectorProfileController());
        await collectorController.fetchCollectorName();
        await collectorController.fetchTaskCounts();
        Get.offAll(() => BottomNavBar(initialIndex: 0, userType: UserType.collector));
      } else {
        log('Navigating to HomeScreen for role: $role');
        Get.offAll(() => BottomNavBar(initialIndex: 0, userType: UserType.seller));
      }
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final loginController = Get.find<LoginController>();
      String? currentRole = await FirebaseFunctions.instance.getUserRole(userCredential.user!.uid);
      if (currentRole == null || loginController.isCollector.value || loginController.isSeller.value) {
        await FirebaseFunctions.instance.setUserRole(
          uid: userCredential.user!.uid,
          role: loginController.isCollector.value ? 'collector' : 'seller',
        );
        log('Updated role to ${loginController.isCollector.value ? 'collector' : 'seller'} for uid ${userCredential.user!.uid}');
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Incorrect password.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      } else {
        Get.snackbar('Error', e.message ?? e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
      return null;
    }
  }

  void signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        value.user!.updateDisplayName(name);
        await FirebaseFunctions.instance.createUserDocumentWithEmailAndPassword(
          name: name,
          email: email,
          password: password,
          uid: value.user!.uid,
        );
        final loginController = Get.find<LoginController>();
        String? currentRole = await FirebaseFunctions.instance.getUserRole(value.user!.uid);
        if (currentRole == null) {
          await FirebaseFunctions.instance.setUserRole(
            uid: value.user!.uid,
            role: loginController.isCollector.value ? 'collector' : 'seller',
          );
          log('Set initial role to ${loginController.isCollector.value ? 'collector' : 'seller'} for uid ${value.user!.uid}');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      } else {
        Get.snackbar('Error', e.message ?? e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  void signInWithPhoneNumber({required String phoneNumber}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91 $phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid.', backgroundColor: Colors.redAccent, colorText: Colors.white);
          } else {
            Get.snackbar('Error', e.message ?? e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          Get.to(() => EnterOtpScreen());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  Future<UserCredential?> verifyOtp({required String phoneNumber, required String smsCode}) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      bool userExists = await FirebaseFunctions.instance.checkIfPhoneNumberExists(phoneNumber);
      if (userExists == false) {
        final loginController = Get.find<LoginController>();
        Get.to(() => EnterNameScreen(
          phoneNumber: phoneNumber,
          isCollector: loginController.isCollector.value,
        ));
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        Get.snackbar('Error', 'The verification code is invalid.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      } else {
        Get.snackbar('Error', e.message ?? e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: '1051853292640-qqvf3k3j7u8ik9t8u5d2ok2rqj1ilh1n.apps.googleusercontent.com',
      );
      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        final UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
        final User? user = userCredential.user;
        if (user != null) {
          await FirebaseFunctions.instance.createUserDocumentWithEmailAndPassword(
            name: user.displayName.toString(),
            email: user.email.toString(),
            password: '',
            uid: user.uid,
          );
          final loginController = Get.find<LoginController>();
          String? currentRole = await FirebaseFunctions.instance.getUserRole(userCredential.user!.uid);
          if (currentRole == null) {
            await FirebaseFunctions.instance.setUserRole(
              uid: userCredential.user!.uid,
              role: loginController.isCollector.value ? 'collector' : 'seller',
            );
            log('Set initial role to ${loginController.isCollector.value ? 'collector' : 'seller'} for uid ${userCredential.user!.uid}');
          }
          log("User signed in: ${user.displayName}");
        }
        return userCredential;
      } else {
        final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          final UserCredential userCredential = await _auth.signInWithCredential(credential);
          final User? user = userCredential.user;
          if (user != null) {
            await FirebaseFunctions.instance.createUserDocumentWithEmailAndPassword(
              name: user.displayName.toString(),
              email: user.email.toString(),
              password: '',
              uid: user.uid,
            );
            final loginController = Get.find<LoginController>();
            String? currentRole = await FirebaseFunctions.instance.getUserRole(userCredential.user!.uid);
            if (currentRole == null) {
              await FirebaseFunctions.instance.setUserRole(
                uid: userCredential.user!.uid,
                role: loginController.isCollector.value ? 'collector' : 'seller',
              );
              log('Set initial role to ${loginController.isCollector.value ? 'collector' : 'seller'} for uid ${userCredential.user!.uid}');
            }
            log("User signed in: ${user.displayName}");
          }
          return userCredential;
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        Get.snackbar('Error', 'Account exists with different credentials.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      } else if (e.code == 'invalid-credential') {
        Get.snackbar('Error', 'Invalid credential. Please try again.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      } else {
        Get.snackbar('Error', e.message ?? 'An unknown error occurred.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
      return null;
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: '1051853292640-qqvf3k3j7u8ik9t8u5d2ok2rqj1ilh1n.apps.googleusercontent.com',
      );
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      Get.offAll(() => LandingScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}