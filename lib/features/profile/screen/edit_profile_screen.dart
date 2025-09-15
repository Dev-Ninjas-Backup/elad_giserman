import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_text_field.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(lable: 'Edit Profile', back: '/profileScreen'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      ImagePath.profileImage2,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: MediaQuery.of(context).size.width / 2 - 50,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.fontColor,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: CustomTextField(
              labelText: 'Full Name',
              controller: TextEditingController(),
              hintText: 'Enter your full name',
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: CustomTextField(
              labelText: 'Email',
              controller: TextEditingController(),
              hintText: 'Enter your email',
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Phone number',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryFontColor,
              ),
            ),
          ),

          /// Phone Number Row (Dropdown + TextField)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              children: [
                /// Country Code Dropdown
                Obx(
                  () => DropdownButton<String>(
                    value: controller.selectedCountryCode.value,
                    items: controller.countryCodes
                        .map(
                          (code) =>
                              DropdownMenuItem(value: code, child: Text(code)),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedCountryCode.value = value;
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10),

                /// Number Field
                Expanded(
                  child: TextField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: CustomButton(
              label: 'Save',
              onPressed: () {
                Get.offNamed('/profileScreen');
              },
              color: AppColors.buttonColor,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
