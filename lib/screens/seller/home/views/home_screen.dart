import 'package:carousel_slider/carousel_slider.dart' as custom_carousel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/seller/home/controllers/location_controller.dart';
import 'package:scrap_it/screens/seller/home/views/components/carousel_card.dart';

import '../data/carousel_blog_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: kSubtitleStyle.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.displayName ?? "User",
                              style: kTitleStyle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: kSecondaryColor,
                          backgroundImage: user?.photoURL != null 
                              ? NetworkImage(user!.photoURL!)
                              : null,
                          child: user?.photoURL == null
                              ? Icon(Icons.person, color: kPrimaryColor, size: 30)
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Let\'s clean our environment',
                      style: kTitle2Style.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
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
                    custom_carousel.CarouselSlider(
                      options: custom_carousel.CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        viewportFraction: 1.0,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.2,
                      ),
                      items: blogList.map((blog) {
                        return Builder(
                          builder: (BuildContext context) {
                            return CarouselCard(
                              title: blog.title,
                              description: blog.description,
                              imagePath: blog.imagePath,
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    GetX<LocationController>(
                      init: LocationController(),
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  controller.getCurrentPosition();
                                },
                                contentPadding: EdgeInsets.zero,
                                horizontalTitleGap: 13,
                                title: Text(
                                  'Your Location',
                                  style: kTitle2Style.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  controller.userAddress.value == ''
                                      ? 'Tap to get your location'
                                      : controller.userAddress.value,
                                  style: kSubtitleStyle.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                leading: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        kPrimaryColor.withOpacity(0.1),
                                        kPrimaryColor.withOpacity(0.2),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    UIcons.regularRounded.location_alt,
                                    color: kPrimaryColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  onMapCreated: (mapController) {
                                    controller.mapController = mapController;
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: controller.userLatLng.value,
                                    zoom: 14.4746,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: const MarkerId('userLocation'),
                                      position: controller.userLatLng.value,
                                    )
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
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
