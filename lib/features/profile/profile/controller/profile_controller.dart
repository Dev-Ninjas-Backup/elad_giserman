import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final phoneController = TextEditingController();

  var selectedCountryCode = "+880".obs;

  final countryCodes = ["+880", "+91", "+1", "+44", "+61"];
}
