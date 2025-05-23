// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scrap_it/screens/login/views/login_screen.dart';
// import 'package:scrap_it/screens/signup/views/signup_screen.dart';
// import 'package:scrap_it/sharedWidgets/custom_bordered_button.dart';
// import 'package:scrap_it/sharedWidgets/custom_filled_button.dart';
//
// class LandingScreen extends StatelessWidget {
//   const LandingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Text(
//                     'Welcome',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 35,
//                 ),
//                 Image.asset(
//                   'assets/images/loginScreen/login_landing.png',
//                   height: 350,
//                   width: 350,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: Text(
//                     'Let\'s clean our homes with',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Center(
//                   child: Text(
//                     'ScrapIt',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomFilledButton(
//                   title: 'LOGIN',
//                   onPressed: () {
//                     Get.to(() => LoginScreen());
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomBorderedButton(
//                   title: 'SIGN UP',
//                   onPressed: () {
//                     Get.to(() => SignUpScreen());
//                   },
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
import 'package:scrap_it/screens/login/views/login_screen.dart';
import 'package:scrap_it/screens/signup/views/signup_screen.dart';
import 'package:scrap_it/sharedWidgets/custom_bordered_button.dart';
import 'package:scrap_it/sharedWidgets/custom_filled_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check if it's web view (wide screen)
            if (constraints.maxWidth > 800) {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to ScrapIt',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Let\'s clean our homes and environment with ease.',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 40),
                          CustomFilledButton(
                            title: 'LOGIN',
                            onPressed: () {
                              Get.to(() => LoginScreen());
                            },
                          ),
                          SizedBox(height: 20),
                          CustomBorderedButton(
                            title: 'SIGN UP',
                            onPressed: () {
                              Get.to(() => SignUpScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Image.asset(
                        'assets/images/loginScreen/login_landing.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Mobile view
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Image.asset(
                        'assets/images/loginScreen/login_landing.png',
                        height: 400,
                        width: 400,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Let\'s clean our homes with',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Center(
                        child: Text(
                          'ScrapIt',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomFilledButton(
                        title: 'LOGIN',
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                      ),
                      SizedBox(height: 20),
                      CustomBorderedButton(
                        title: 'SIGN UP',
                        onPressed: () {
                          Get.to(() => SignUpScreen());
                        },
                      ),

                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
