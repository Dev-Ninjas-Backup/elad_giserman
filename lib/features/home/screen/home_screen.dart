import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/widgets/home_app_bar.dart';
import 'package:elad_giserman/features/home/widgets/popular_near_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeAppBar(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Popular Near You',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'See All >',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF636363),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                PopularNearWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
