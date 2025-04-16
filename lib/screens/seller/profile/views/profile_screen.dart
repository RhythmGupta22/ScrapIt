import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:scrap_it/screens/seller/profile/views/components/profile_list_tile.dart';
import 'package:scrap_it/screens/seller/profile/views/contact_support_screen.dart';
import 'package:scrap_it/screens/seller/profile/views/faq_screen.dart';
import 'package:scrap_it/screens/seller/profile/views/feedback_screen.dart';
import 'package:scrap_it/screens/seller/trashPickup/views/scheduled_pickups.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthRepository.instance.firebaseUser.value;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          DashedCircle(
                            dashes: 10,
                            color: kPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: kSecondaryColor,
                                radius: 50,
                                backgroundImage: user?.photoURL != null 
                                    ? NetworkImage(user!.photoURL!)
                                    : null,
                                child: user?.photoURL == null
                                    ? SvgPicture.asset(
                                        'assets/images/homeScreen/profile_pic.svg',
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                UIcons.regularRounded.camera,
                                color: kPrimaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AuthRepository.instance.firebaseUser.value?.displayName ?? "User",
                      style: kTitleStyle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? "",
                      style: kSubtitleStyle.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bookings',
                      style: kTitle2Style.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ProfileListTile(
                      title: 'My Bookings',
                      icon: UIcons.regularRounded.boxes,
                      onTap: () => Get.to(
                        () => ScheduledPickupScreen(
                          backButtonVisible: true,
                        ),
                        transition: Transition.zoom,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Support And Feedback',
                      style: kTitle2Style.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ProfileListTile(
                      title: 'FAQs',
                      icon: UIcons.regularRounded.comment_question,
                      onTap: () => Get.to(
                        () => FAQScreen(),
                        transition: Transition.zoom,
                      ),
                    ),
                    ProfileListTile(
                      title: 'Contact Support',
                      icon: UIcons.regularRounded.call_history,
                      onTap: () => Get.to(
                        () => ContactSupportScreen(),
                        transition: Transition.zoom,
                      ),
                    ),
                    ProfileListTile(
                      title: 'Feedback',
                      icon: UIcons.regularRounded.notebook,
                      onTap: () => Get.to(
                        () => FeedbackScreen(),
                        transition: Transition.zoom,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Account Settings',
                      style: kTitle2Style.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ProfileListTile(
                      title: 'Logout',
                      icon: UIcons.regularRounded.exit,
                      onTap: () {
                        AuthRepository.instance.signOut();
                      },
                    ),
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
