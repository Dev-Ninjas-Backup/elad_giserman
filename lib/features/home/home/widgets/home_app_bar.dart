// ignore_for_file: unused_import, unused_field

import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/home/home/controller/custom_app_details_controller.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/notifications/service/notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with TickerProviderStateMixin {
  late CustomAppDetailsController _appDetailsController;
  late HomeController _homeController;
  final TextEditingController _searchController = TextEditingController();
  final searchQuery = ''.obs;
  final NotificationService _notificationService = NotificationService();
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;
  // final text = 'welcome_back'.tr;

  @override
  void initState() {
    super.initState();
    _appDetailsController = Get.put(CustomAppDetailsController());
    _homeController = Get.find<HomeController>();
    _searchController.addListener(() {
      searchQuery.value = _searchController.text;
      // Perform search as user types
      _homeController.searchByQuery(_searchController.text);
      if (kDebugMode) {
        print('🔍 Search query: ${_searchController.text}');
      }
    });

    // Initialize slide animation
    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _slideAnimationController,
            curve: Curves.easeInOut,
          ),
        );
    _slideAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  void _showSearchResults() {
    if (_searchController.text.isEmpty) {
      Get.snackbar(
        'Search',
        'Please enter a search term',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      return;
    }

    if (kDebugMode) {
      print('🔍 Performing search for: ${_searchController.text}');
    }

    // Navigate to search results screen
    Get.toNamed(
      AppRoute.getHomeScreen(),
      arguments: {'searchQuery': _searchController.text},
    );
  }

  Future<void> _handleNotificationTap() async {
    try {
      // Mark all notifications as read
      await _notificationService.markAllNotificationsAsRead();
      // Navigate to notification screen
      Get.toNamed(AppRoute.getNotificationScreen());
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error handling notification tap: $e');
      }
      // Still navigate even if marking as read fails
      Get.toNamed(AppRoute.getNotificationScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0, 62, 0, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0xFF0088A3)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/logo_black_nobg.png',
                height: 40,
                width: 150,
                fit: BoxFit.contain,
              ),
              Spacer(),
              FutureBuilder<String?>(
                future: SharedPreferencesHelper.getAccessToken(),
                builder: (context, snapshot) {
                  // Check if user is logged in
                  final isLoggedIn =
                      snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty;

                  return Row(
                    children: [
                      // Show notification icon only if logged in
                      if (isLoggedIn)
                        IconButton(
                          onPressed: _handleNotificationTap,
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: Colors.black,
                          ),
                        ),
                      if (isLoggedIn) SizedBox(width: 10),
                      // Show login button only if not logged in
                      if (!isLoggedIn)
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed('/signInScreen');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                              height: 28,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.primaryFontColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  'login'.tr,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SlideTransition(
              position: _slideAnimation,
              child:
                  //               RichText(
                  //   text: TextSpan(
                  //     children: text.split('').asMap().entries.map((entry) {
                  //       int index = entry.key;
                  //       String char = entry.value;
                  //       return TextSpan(
                  //         text: char,
                  //         style: GoogleFonts.poppins(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.w400,
                  //           color: Colors.primaries[index % Colors.primaries.length],
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // )
                  Text(
                    'welcome_back'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
            ),
          ),
          //   style: TextStyle(
          //     fontSize: 20,
          //     fontWeight: FontWeight.w600,
          //     color: AppColors.primaryFontColor,
          //   ),
          // ),
          SizedBox(height: 10),
          Container(
            // padding: EdgeInsets.zero,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _searchController,
              onSubmitted: (_) => _showSearchResults(),
              decoration: InputDecoration(
                hintText: 'search_hint'.tr,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                //  prefixIcon: Icon(Icons.search, color: AppColors.buttonColor),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: AppColors.buttonColor,
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 30),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: InputBorder.none,
                // suffixIcon: GestureDetector(
                //   onTap: _showSearchResults,
                //   child: Image.asset(IconPath.searchSuffix),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
