import 'package:elad_giserman/app.dart';
import 'package:flutter/material.dart';
import 'package:elad_giserman/core/localization/localization_service.dart';
import 'package:elad_giserman/core/localization/app_translations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await AppTranslations.loadTranslations();
  Locale savedLocale = await LocalizationService.initializeLocale();
  runApp(MyApp(initialLocale: savedLocale));
}
