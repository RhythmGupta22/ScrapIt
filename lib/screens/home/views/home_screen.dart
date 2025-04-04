import 'package:carousel_slider/carousel_slider.dart' as custom_carousel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/home/controllers/location_controller.dart';
import 'package:scrap_it/screens/home/views/components/carousel_card.dart';
import 'package:scrap_it/screens/home/views/components/top_row.dart';

import '../data/carousel_blog_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeScreenTopRow(userName: AuthRepository.instance.firebaseUser.value?.displayName ?? "User"),
              SizedBox(
                height: 20,
              ),
              Text(
                'Lets clean our environment',
                style: kTitle2LessEmphasis,
              ),
              SizedBox(
                height: 20,
              ),
              custom_carousel.CarouselSlider(
                options: custom_carousel.CarouselOptions(
                  height: 200.0,
                  autoPlay: false,
                  viewportFraction: 1.0,
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
              SizedBox(
                height: 20,
              ),
              GetX<LocationController>(
                  init: LocationController(),
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () {
                            controller.getCurrentPosition();
                          },
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 13,
                          title: Text(
                            'Your Location',
                            style: kTitle2Style,
                          ),
                          subtitle: Text(
                            controller.userAddress.value == ''
                                ? 'Tap to get your location'
                                : controller.userAddress.value,
                            style: kSubtitleStyle,
                          ),
                          leading: Icon(
                            UIcons.regularRounded.location_alt,
                            color: kPrimaryColor,
                          ),
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                                markerId: MarkerId('userLocation'),
                                position: controller.userLatLng.value,
                              )
                            },
                          ),
                        ),
                      ],
                    );
                  }),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   'Nearby Bins',
              //   style: kTitle2Style,
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}
