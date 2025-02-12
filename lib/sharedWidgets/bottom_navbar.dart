// import 'package:flutter/material.dart';
// import 'package:tab_indicator_styler/tab_indicator_styler.dart';
// import 'package:uicons/uicons.dart';
// import 'package:scrap_it/constants/colors.dart';
// import 'package:scrap_it/screens/trashPickup/views/scheduled_pickups.dart';
// import 'package:scrap_it/screens/home/views/home_screen.dart';
// import 'package:scrap_it/screens/profile/views/profile_screen.dart';
// import 'package:scrap_it/screens/shop/views/shop_screen.dart';
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key, required this.initailIndex}) : super(key: key);
//   final int initailIndex;
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar>
//     with SingleTickerProviderStateMixin {
//   //controller to manage different tabs of the navbar
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//         // length: 4,
//         length: 3,
//         vsync: this, initialIndex: widget.initailIndex);
//     _tabController.addListener(_handleTabSelection);
//   }
//
//   void _handleTabSelection() {
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         //custom made tabview used as bottom navbar
//         bottomNavigationBar: CustomNavBarWidget(tabController: _tabController),
//         body: TabBarView(
//           controller: _tabController,
//           //tab pages in correspondence to the navbar
//           children: [
//             HomeScreen(),
//             ScheduledPickupScreen(
//               backButtonVisible: false,
//             ),
//             // ShopScreen(),
//             ProfileScreen(),
//           ],
//         ));
//   }
// }
//
// class CustomNavBarWidget extends StatelessWidget {
//   const CustomNavBarWidget({
//     Key? key,
//     required TabController tabController,
//   })  : _tabController = tabController,
//         super(key: key);
//
//   final TabController _tabController;
//
//   @override
//   Widget build(BuildContext context) {
//     //outer container to hold the navbar
//     return Container(
//       // padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.all(
//           Radius.circular(0.0),
//         ),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: TabBar(
//             //indicator package for the dot indication
//             indicator: DotIndicator(
//               color: kPrimaryColor,
//               distanceFromCenter: 20,
//               radius: 3,
//               paintingStyle: PaintingStyle.fill,
//             ),
//             // BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
//             //inner padding for the icons of the navbar
//             controller: _tabController,
//             tabs: <Widget>[
//               Tab(
//                 icon: Icon(
//                   UIcons.regularRounded.home,
//                   color: _tabController.index == 0
//                       ? kPrimaryColor
//                       : kUnselectedItemColor,
//                 ),
//               ),
//               Tab(
//                 icon: Icon(
//                   UIcons.regularRounded.calendar,
//                   color: _tabController.index == 1
//                       ? kPrimaryColor
//                       : kUnselectedItemColor,
//                 ),
//               ),
//               // Tab(
//               //   icon: Icon(
//               //     UIcons.regularRounded.shopping_bag,
//               //     color: _tabController.index == 2
//               //         ? kPrimaryColor
//               //         : kUnselectedItemColor,
//               //   ),
//               // ),
//               Tab(
//                 icon: Icon(
//                   UIcons.regularRounded.user,
//                   color: _tabController.index == 3
//                       ? kPrimaryColor
//                       : kUnselectedItemColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/screens/trashPickup/views/scheduled_pickups.dart';
import 'package:scrap_it/screens/home/views/home_screen.dart';
import 'package:scrap_it/screens/profile/views/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.initailIndex}) : super(key: key);
  final int initailIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initailIndex,
    );
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            // Web/Tablet Layout: Sidebar navigation
            return Row(
              children: [
                NavigationRailWidget(tabController: _tabController),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      HomeScreen(),
                      ScheduledPickupScreen(backButtonVisible: false),
                      ProfileScreen(),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // Mobile Layout: Bottom navigation bar
            return Scaffold(
              bottomNavigationBar:
              CustomNavBarWidget(tabController: _tabController),
              body: TabBarView(
                controller: _tabController,
                children: [
                  HomeScreen(),
                  ScheduledPickupScreen(backButtonVisible: false),
                  ProfileScreen(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: TabBar(
        indicator: DotIndicator(
          color: kPrimaryColor,
          distanceFromCenter: 18,
          radius: 4,
          paintingStyle: PaintingStyle.fill,
        ),
        controller: _tabController,
        tabs: [
          Tab(
            icon: Icon(
              UIcons.regularRounded.home,
              size: 24,
              color: _tabController.index == 0
                  ? kPrimaryColor
                  : kUnselectedItemColor,
            ),
          ),
          Tab(
            icon: Icon(
              UIcons.regularRounded.calendar,
              size: 24,
              color: _tabController.index == 1
                  ? kPrimaryColor
                  : kUnselectedItemColor,
            ),
          ),
          Tab(
            icon: Icon(
              UIcons.regularRounded.user,
              size: 24,
              color: _tabController.index == 2
                  ? kPrimaryColor
                  : kUnselectedItemColor,
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationRailWidget extends StatelessWidget {
  const NavigationRailWidget({Key? key, required this.tabController})
      : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: tabController.index,
      onDestinationSelected: (index) {
        tabController.animateTo(index);
      },
      labelType: NavigationRailLabelType.all,
      backgroundColor: Colors.grey.shade50,
      destinations: [
        NavigationRailDestination(
          icon: Icon(
            UIcons.regularRounded.home,
            size: 20,
            color: kUnselectedItemColor,
          ),
          selectedIcon: Icon(
            UIcons.solidRounded.home,
            size: 20,
            color: kPrimaryColor,
          ),
          label: Text(
            'Home',
            style: TextStyle(
              color: tabController.index == 0
                  ? kPrimaryColor
                  : kUnselectedItemColor,
              fontSize: 12,
            ),
          ),
        ),
        NavigationRailDestination(
          icon: Icon(
            UIcons.regularRounded.calendar,
            size: 20,
            color: kUnselectedItemColor,
          ),
          selectedIcon: Icon(
            UIcons.solidRounded.calendar,
            size: 20,
            color: kPrimaryColor,
          ),
          label: Text(
            'Pickups',
            style: TextStyle(
              color: tabController.index == 1
                  ? kPrimaryColor
                  : kUnselectedItemColor,
              fontSize: 12,
            ),
          ),
        ),
        NavigationRailDestination(
          icon: Icon(
            UIcons.regularRounded.user,
            size: 20,
            color: kUnselectedItemColor,
          ),
          selectedIcon: Icon(
            UIcons.solidRounded.user,
            size: 20,
            color: kPrimaryColor,
          ),
          label: Text(
            'Profile',
            style: TextStyle(
              color: tabController.index == 2
                  ? kPrimaryColor
                  : kUnselectedItemColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
