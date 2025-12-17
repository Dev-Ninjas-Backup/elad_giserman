// ignore_for_file: unused_field

import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/home/home/controller/custom_app_details_controller.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late Future<String?> _tokenFuture;
  late CustomAppDetailsController _appDetailsController;
  late HomeController _homeController;
  final TextEditingController _searchController = TextEditingController();
  final searchQuery = ''.obs;

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
  }

  @override
  void dispose() {
    _searchController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 62, 20, 22),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Obx(() {
                final logoUrl = _appDetailsController.logoUrl;
                if (logoUrl.isNotEmpty) {
                  return Image.network(
                    logoUrl,
                    height: 25,
                    width: 98,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        IconPath.appIcon,
                        height: 25,
                        width: 98,
                      );
                    },
                  );
                } else {
                  return Image.asset(IconPath.appIcon, height: 25, width: 98);
                }
              }),
              Spacer(),
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoute.getNotificationScreen());
                },
                icon: Icon(Icons.notifications_outlined, color: Colors.black),
              ),
              SizedBox(width: 10),
              FutureBuilder<String?>(
                future: SharedPreferencesHelper.getAccessToken(),
                builder: (context, snapshot) {
                  // Show login button only if token is null or empty
                  final isLoggedIn =
                      snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty;

                  if (isLoggedIn) {
                    return SizedBox.shrink(); // Hide login button if logged in
                  }

                  return GestureDetector(
                    onTap: () {
                      Get.offAllNamed('/signInScreen');
                    },
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
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            'welcome_back'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryFontColor,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextField(
              controller: _searchController,
              onSubmitted: (_) => _showSearchResults(),
              decoration: InputDecoration(
                hintText: 'search_hint'.tr,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.buttonColor),
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
