// update_password_screen.dart

import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/profile/update_password/controller/update_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key});

  final UpdatePasswordController controller = Get.put(
    UpdatePasswordController(),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(lable: 'update_password'.tr, back: '/navBarScreen'),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'secure_account'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'choose_strong_password'.tr,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Obx(
                      () => TextFormField(
                        onChanged: (value) =>
                            controller.oldPassword.value = value,
                        obscureText: !controller.oldPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: 'old_password_label'.tr,
                          hintText: 'old_password_hint'.tr,
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.oldPasswordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.toggleOldPasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: AppColors.textFieldFillColor,
                        ),
                        validator: controller.validateOldPassword,
                      ),
                    ),
                    SizedBox(height: 24),
                    Obx(
                      () => TextFormField(
                        onChanged: (value) =>
                            controller.newPassword.value = value,
                        obscureText: !controller.newPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: 'new_password_label'.tr,
                          hintText: 'new_password_hint'.tr,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.newPasswordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.toggleNewPasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: AppColors.textFieldFillColor,
                        ),
                        validator: controller.validateNewPassword,
                      ),
                    ),
                    SizedBox(height: 24),
                    Obx(
                      () => TextFormField(
                        onChanged: (value) =>
                            controller.confirmPassword.value = value,
                        obscureText: !controller.confirmPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: 'confirm_new_password_label'.tr,
                          hintText: 'confirm_new_password_hint'.tr,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.confirmPasswordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: AppColors.textFieldFillColor,
                        ),
                        validator: controller.validateConfirmPassword,
                      ),
                    ),
                    SizedBox(height: 40),
                    CustomButton(
                      label: 'update_password'.tr,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.updatePassword();
                        }
                      },
                      color: AppColors.buttonColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
