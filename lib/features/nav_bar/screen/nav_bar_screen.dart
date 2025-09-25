import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/home/home/screen/home_screen.dart';
import 'package:elad_giserman/features/nav_bar/controller/nav_bar_controller.dart';
import 'package:elad_giserman/features/profile/main/screen/profile_screen.dart';
import 'package:elad_giserman/features/profile/my_reservation/screen/reservation_history_screen.dart';
import 'package:elad_giserman/features/profile/subscriptions/screen/subscriptions_screen.dart';
import 'package:elad_giserman/features/spinner/screen/spinner_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavbarController controller = Get.put(NavbarController());

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                HomeScreen(),
                ReservationHistoryScreen(),
                SpinnerScreen(),
                SubscriptionsScreen(),
                ProfileScreen(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(105, 105, 105, 0.14),
              offset: Offset(0, -3),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Obx(
                () => BottomNavigationBar(
                  elevation: 5,
                  backgroundColor: Color(0xFFFFFFFF),
                  currentIndex: controller.selectedIndex.value,
                  onTap: (index) {
                    controller.changeTabIndex(index);
                  },
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        IconPath.activeHome,
                        width: 24,
                        height: 24,
                        color: controller.selectedIndex.value == 0
                            ? Colors.black
                            : Colors.grey,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        IconPath.activeHistory,
                        width: 24,
                        height: 24,
                        color: controller.selectedIndex.value == 1
                            ? Colors.black
                            : Colors.grey,
                      ),
                      label: 'History',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(height: 24),
                      label: 'Spin',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        IconPath.activeVip,
                        width: 24,
                        height: 24,
                        color: controller.selectedIndex.value == 3
                            ? Colors.black
                            : Colors.grey,
                      ),
                      label: 'VIP',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        IconPath.activeProfile,
                        width: 24,
                        height: 24,
                        color: controller.selectedIndex.value == 4
                            ? Colors.black
                            : Colors.grey,
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -30,
              child: GestureDetector(
                onTap: () {
                  controller.changeTabIndex(2);
                },
                child: Image.asset(IconPath.activeSpin, width: 70, height: 70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
