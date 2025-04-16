import 'package:flutter/material.dart';
import 'package:scrap_it/screens/collector/views/collector_home_screen.dart';
import 'package:scrap_it/screens/seller/home/views/home_screen.dart';
import 'package:scrap_it/screens/seller/profile/views/profile_screen.dart';
import 'package:scrap_it/screens/seller/trashPickup/views/scheduled_pickups.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/screens/collector/views/assigned_orders_screen.dart';
import 'package:scrap_it/screens/collector/views/collector_profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.initialIndex,
    this.userType = UserType.collector,
  });

  final int initialIndex;
  final UserType userType;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

enum UserType { collector, seller }

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialIndex,
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
            return Row(
              children: [
                NavigationRailWidget(
                  tabController: _tabController,
                  userType: widget.userType,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _getScreens(),
                  ),
                ),
              ],
            );
          } else {
            return Scaffold(
              bottomNavigationBar: CustomNavBarWidget(
                tabController: _tabController,
                userType: widget.userType,
              ),
              body: TabBarView(
                controller: _tabController,
                children: _getScreens(),
              ),
            );
          }
        },
      ),
    );
  }

  List<Widget> _getScreens() {
    if (widget.userType == UserType.seller) {
      return [
        HomeScreen(),
        ScheduledPickupScreen(backButtonVisible: false),
        ProfileScreen(),
      ];
    } else {
      return [
        CollectorHomeScreen(),
        AssignedOrdersScreen(),
        CollectorProfileScreen(),
      ];
    }
  }
}

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({
    super.key,
    required this.tabController,
    required this.userType,
  });

  final TabController tabController;
  final UserType userType;

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
        controller: tabController,
        tabs: _getTabs(),
      ),
    );
  }

  List<Widget> _getTabs() {
    final firstTab = Tab(
      icon: Icon(
        userType == UserType.seller ? UIcons.regularRounded.shop : UIcons.regularRounded.home,
        size: 24,
        color: tabController.index == 0 ? kPrimaryColor : kUnselectedItemColor,
      ),
    );

    final secondTab = Tab(
      icon: Icon(
        userType == UserType.seller ? UIcons.regularRounded.list : UIcons.regularRounded.list,
        size: 24,
        color: tabController.index == 1 ? kPrimaryColor : kUnselectedItemColor,
      ),
    );

    final thirdTab = Tab(
      icon: Icon(
        UIcons.regularRounded.user,
        size: 24,
        color: tabController.index == 2 ? kPrimaryColor : kUnselectedItemColor,
      ),
    );

    return [firstTab, secondTab, thirdTab];
  }
}

class NavigationRailWidget extends StatelessWidget {
  const NavigationRailWidget({
    super.key,
    required this.tabController,
    required this.userType,
  });

  final TabController tabController;
  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: tabController.index,
      onDestinationSelected: (index) {
        tabController.animateTo(index);
      },
      labelType: NavigationRailLabelType.all,
      backgroundColor: Colors.grey.shade50,
      destinations: _getDestinations(),
    );
  }

  List<NavigationRailDestination> _getDestinations() {
    final firstDestination = NavigationRailDestination(
      icon: Icon(
        userType == UserType.seller ? UIcons.regularRounded.shop : UIcons.regularRounded.home,
        size: 20,
        color: kUnselectedItemColor,
      ),
      selectedIcon: Icon(
        userType == UserType.seller ? UIcons.solidRounded.shop : UIcons.solidRounded.home,
        size: 20,
        color: kPrimaryColor,
      ),
      label: Text(
        userType == UserType.seller ? 'Dashboard' : 'Home',
        style: TextStyle(
          color: tabController.index == 0 ? kPrimaryColor : kUnselectedItemColor,
          fontSize: 12,
        ),
      ),
    );

    final secondDestination = NavigationRailDestination(
      icon: Icon(
        userType == UserType.seller ? UIcons.regularRounded.list : UIcons.regularRounded.list,
        size: 20,
        color: kUnselectedItemColor,
      ),
      selectedIcon: Icon(
        userType == UserType.seller ? UIcons.solidRounded.list : UIcons.solidRounded.list,
        size: 20,
        color: kPrimaryColor,
      ),
      label: Text(
        userType == UserType.seller ? 'Orders' : 'Orders',
        style: TextStyle(
          color: tabController.index == 1 ? kPrimaryColor : kUnselectedItemColor,
          fontSize: 12,
        ),
      ),
    );

    final thirdDestination = NavigationRailDestination(
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
          color: tabController.index == 2 ? kPrimaryColor : kUnselectedItemColor,
          fontSize: 12,
        ),
      ),
    );

    return [firstDestination, secondDestination, thirdDestination];
  }
}