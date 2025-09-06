import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeAppBar(),
          SizedBox(height: 20),
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
            ],
          ),
        ],
      ),
    );
  }
}
