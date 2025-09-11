import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/home/screen/home_screen.dart';
import 'package:elad_giserman/features/nav_bar/controller/nav_bar_controller.dart';
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
                Center(child: Text('History Page')),
                Center(child: Text('Twist Page')),
                Center(child: Text('VIP Page')),
                Center(child: Text('Profile Page')),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            left:
                MediaQuery.of(context).size.width * (2 / 5) +
                (MediaQuery.of(context).size.width / 5 - 46) / 2,
            child: Container(
              width: 46,
              height: 46,
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Color(0xFF0088A3),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(2, 93, 112, 0.50),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Image.asset(
                IconPath.activeVip,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
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
        child: ClipRRect(
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
                  icon: Image.asset(
                    IconPath.activeVip,
                    width: 24,
                    height: 24,
                    color: controller.selectedIndex.value == 2
                        ? Colors.black
                        : Colors.grey,
                  ),
                  label: 'Twist',
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
      ),
    );
  }
}
