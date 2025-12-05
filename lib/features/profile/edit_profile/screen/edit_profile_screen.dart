import 'dart:io';

import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_text_field.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main/controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(lable: 'edit_profile'.tr, back: '/navBarScreen'),
            Obx(
              () => controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 20),
                      child: Stack(
                        children: [
                          Center(
                            child: Obx(
                              () => ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: controller.selectedImagePath.isEmpty
                                    ? (controller.profile.value?.avatarUrl !=
                                            null
                                        ? Image.network(
                                            controller.profile.value!
                                                .avatarUrl,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                stackTrace) {
                                              return Image.asset(
                                                ImagePath.profileImage2,
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            ImagePath.profileImage2,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ))
                                    : Image.file(
                                        File(controller.selectedImagePath
                                            .value),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: MediaQuery.of(context).size.width / 2 - 50,
                            child: GestureDetector(
                              onTap: () => controller.pickImage(),
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
                          ),
                        ],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: CustomTextField(
                labelText: 'full_name_label'.tr,
                controller: controller.nameController,
                hintText: 'Enter your name',
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'phone_number_label'.tr,
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryFontColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                children: [
                  Obx(
                    () => DropdownButton<String>(
                      value: controller.selectedCountryCode.value,
                      items: controller.countryCodes
                          .map(
                            (code) => DropdownMenuItem(
                              value: code,
                              child: Text(code),
                            ),
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
                  Expanded(
                    child: TextField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "phone_hint".tr,
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
              child: Obx(
                () => CustomButton(
                  label: 'save_btn'.tr,
                  onPressed: controller.isSaving.value
                      ? null
                      : () {
                          controller.updateProfile();
                        },
                  color: AppColors.buttonColor,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
