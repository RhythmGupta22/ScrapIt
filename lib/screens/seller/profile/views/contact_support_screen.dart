import 'package:flutter/material.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/seller/profile/views/components/contact_support_tile.dart';
import 'package:scrap_it/sharedWidgets/top_header_with_back.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopHeaderWithBackButton(title: 'Contact Support'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'We are committed to providing you with the best possible service. If you have any questions or concerns, please contact us through the following channels',
                  style: kSubtitleStyle,
                ),
                SizedBox(
                  height: 35,
                ),
                ContactSupportTile(
                  icon: UIcons.regularRounded.envelope,
                  contactHandle: 'support@ScrapIt.com ',
                ),
                SizedBox(
                  height: 25,
                ),
                ContactSupportTile(
                  icon: UIcons.regularRounded.call_history,
                  contactHandle: '+91 9419291449',
                ),
                SizedBox(
                  height: 25,
                ),
                ContactSupportTile(
                  icon: UIcons.brands.facebook,
                  contactHandle: 'facebook.com/ScrapIt',
                ),
                SizedBox(
                  height: 25,
                ),
                ContactSupportTile(
                  icon: UIcons.brands.instagram,
                  contactHandle: 'instagram.com/ScrapIt',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
