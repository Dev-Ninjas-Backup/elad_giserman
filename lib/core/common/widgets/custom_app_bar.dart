import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String lable;
  final bool? cancelText;
  const CustomAppBar({super.key, required this.lable, this.cancelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 56, left: 20, bottom: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color.fromARGB(255, 48, 194, 223)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: 5),
          Text(
            lable,
            style: TextStyle(
              color: AppColors.primaryFontColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (cancelText == true)
            TextButton(
              onPressed: () {},
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.primaryFontColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
