import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:scrap_it/sharedWidgets/bottom_navbar.dart';
import 'package:scrap_it/utils/firebase_functions.dart';

class EnterNameScreen extends StatelessWidget {
  final String phoneNumber;
  final bool isCollector;

  const EnterNameScreen({super.key, required this.phoneNumber, required this.isCollector});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Enter Your Name')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    String uid = AuthRepository.instance.firebaseUser.value!.uid;
                    await FirebaseFunctions.instance.setUserRole(
                      uid: uid,
                      role: isCollector ? 'collector' : 'seller',
                    );
                    await FirebaseFunctions.instance.createUserWithPhoneNumber(
                      name: nameController.text,
                      phoneNumber: phoneNumber,
                      uid: uid,
                    );
                    Get.offAll(() => BottomNavBar(
                      initialIndex: 0,
                      userType: isCollector ? UserType.collector : UserType.seller,
                    ));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}