// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scrap_it/constants/colors.dart';
// import 'package:scrap_it/constants/fonts.dart';
// import 'package:scrap_it/constants/styles.dart';
// import 'package:scrap_it/screens/signup/controller/signup_controller.dart';
// import 'package:scrap_it/sharedWidgets/custom_filled_button.dart';
//
// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});
//   final signUpController = Get.put(SignUpController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(
//             16.0,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(
//                   child: Text(
//                     'Register With Email',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 35,
//                 ),
//                 Form(
//                   key: signUpController.signUpFormKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Name',
//                         style: kSubtitleStyle,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                         controller: signUpController.nameController,
//                         cursorColor: kPrimaryColor,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your name',
//                           focusedBorder: focusedBorderStyle,
//                           border: borderStyle,
//                           errorBorder: errorBorderStyle,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         'Email',
//                         style: kSubtitleStyle,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       TextFormField(
//                         validator: (value) {
//                           if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
//                               .hasMatch(value!)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                         controller: signUpController.emailController,
//                         cursorColor: kPrimaryColor,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your email',
//                           focusedBorder: focusedBorderStyle,
//                           border: borderStyle,
//                           errorBorder: errorBorderStyle,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         'Password',
//                         style: kSubtitleStyle,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your password';
//                           } else if (value.length < 8) {
//                             return 'Password must be at least 8 characters long';
//                           }
//                           return null;
//                         },
//                         controller: signUpController.passwordController,
//                         cursorColor: kPrimaryColor,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your password',
//                           focusedBorder: focusedBorderStyle,
//                           border: borderStyle,
//                           errorBorder: errorBorderStyle,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         'Confirm Password',
//                         style: kSubtitleStyle,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your password';
//                           } else if (value.length < 8) {
//                             return 'Password must be at least 8 characters long';
//                           } else if (value !=
//                               signUpController.passwordController.text) {
//                             return 'Passwords do not match';
//                           }
//                           return null;
//                         },
//                         controller: signUpController.confirmPasswordController,
//                         cursorColor: kPrimaryColor,
//                         decoration: InputDecoration(
//                           hintText: 'Re-enter your password',
//                           focusedBorder: focusedBorderStyle,
//                           border: borderStyle,
//                           errorBorder: errorBorderStyle,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 35,
//                       ),
//                       CustomFilledButton(
//                           title: 'Register',
//                           onPressed: () {
//                             signUpController.signUp();
//                           }),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/constants/styles.dart';
import 'package:scrap_it/screens/signup/controller/signup_controller.dart';
import 'package:scrap_it/sharedWidgets/custom_filled_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              // Web/Tablet Layout
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome to ScrapIt!',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Create an account to get started.',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32.0),
                      child: _buildSignUpForm(),
                    ),
                  ),
                ],
              );
            } else {
              // Mobile Layout
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: _buildSignUpForm(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Register With Email',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 35),
        Form(
          key: signUpController.signUpFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: kSubtitleStyle,
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                controller: signUpController.nameController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  focusedBorder: focusedBorderStyle,
                  border: borderStyle,
                  errorBorder: errorBorderStyle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email',
                style: kSubtitleStyle,
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                      .hasMatch(value!)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: signUpController.emailController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  focusedBorder: focusedBorderStyle,
                  border: borderStyle,
                  errorBorder: errorBorderStyle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: kSubtitleStyle,
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
                controller: signUpController.passwordController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  focusedBorder: focusedBorderStyle,
                  border: borderStyle,
                  errorBorder: errorBorderStyle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Confirm Password',
                style: kSubtitleStyle,
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  } else if (value !=
                      signUpController.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                controller: signUpController.confirmPasswordController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Re-enter your password',
                  focusedBorder: focusedBorderStyle,
                  border: borderStyle,
                  errorBorder: errorBorderStyle,
                ),
              ),
              SizedBox(height: 35),
              CustomFilledButton(
                title: 'Register',
                onPressed: () {
                  signUpController.signUp();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
