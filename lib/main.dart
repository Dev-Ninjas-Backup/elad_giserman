import 'package:elad_giserman/app.dart';
import 'package:elad_giserman/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:elad_giserman/core/localization/localization_service.dart';
import 'package:elad_giserman/core/localization/app_translations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await MobileAds.instance.initialize();
  await AppTranslations.loadTranslations();
  Locale savedLocale = await LocalizationService.initializeLocale();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(initialLocale: savedLocale));
}
