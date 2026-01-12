// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class TranslationService extends GetxService {
  static const String _googleTranslateApiKey =
      'AIzaSyAuPWebHwdZnEDc46kdBMf9ouOxMpAmJA8';
  static const String _googleTranslateUrl =
      'https://translation.googleapis.com/language/translate/v2';

  // Cache for translations: key -> {targetLanguage -> translatedText}
  final Map<String, Map<String, String>> _translationCache = {};

  // Current language
  late String _currentLanguage = 'en';

  @override
  void onInit() {
    super.onInit();
    _currentLanguage = Get.locale?.languageCode ?? 'en';
  }

  /// Update the current language
  void updateLanguage(String languageCode) {
    _currentLanguage = languageCode;
  }

  /// Get current language code
  String getCurrentLanguage() => _currentLanguage;

  /// Translate a single text
  /// Returns cached translation if available, otherwise fetches from Google Translate API
  Future<String> translateText({
    required String text,
    required String targetLanguage,
    String sourceLanguage = 'en',
  }) async {
    if (text.isEmpty) return text;

    // If source and target are same, return original text
    if (sourceLanguage == targetLanguage) return text;

    // Check cache first
    if (_translationCache.containsKey(text) &&
        _translationCache[text]!.containsKey(targetLanguage)) {
      return _translationCache[text]![targetLanguage]!;
    }

    try {
      final body = <String, Object?>{'q': text, 'target': targetLanguage};
      // Let Google auto-detect by omitting `source`
      if (sourceLanguage.isNotEmpty && sourceLanguage != 'auto') {
        body['source'] = sourceLanguage;
      }

      final response = await http
          .post(
            Uri.parse('$_googleTranslateUrl?key=$_googleTranslateApiKey'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              print('Translation request timeout');
              throw Exception('Translation request timeout');
            },
          );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final translatedText =
            json['data']['translations'][0]['translatedText'];

        // Cache the translation
        if (!_translationCache.containsKey(text)) {
          _translationCache[text] = {};
        }
        _translationCache[text]![targetLanguage] = translatedText;

        return translatedText;
      } else {
        print('Translation error: ${response.statusCode}');
        print('Response: ${response.body}');
        return text; // Return original text on error
      }
    } catch (e) {
      print('Exception during translation: $e');
      return text; // Return original text on error
    }
  }

  /// Translate multiple texts at once (more efficient)
  /// Returns a list of translated texts in the same order
  Future<List<String>> translateMultiple({
    required List<String> texts,
    required String targetLanguage,
    String sourceLanguage = 'en',
  }) async {
    if (texts.isEmpty) return const <String>[];

    // If source and target are same, return original texts
    if (sourceLanguage == targetLanguage) return List<String>.from(texts);

    // Always return a list matching input length/order
    final output = List<String?>.filled(texts.length, null);

    // Filter out empty/cached texts; collect the rest for a single API call
    final textsToTranslate = <String>[];
    final indicesToTranslate = <int>[];

    for (int i = 0; i < texts.length; i++) {
      final text = texts[i];
      if (text.isEmpty) {
        output[i] = text;
        continue;
      }

      final cached = _translationCache[text]?[targetLanguage];
      if (cached != null) {
        output[i] = cached;
        continue;
      }

      textsToTranslate.add(text);
      indicesToTranslate.add(i);
    }

    if (textsToTranslate.isEmpty) {
      return output.map((e) => e ?? '').toList(growable: false);
    }

    try {
      final body = <String, Object?>{
        'q': textsToTranslate,
        'target': targetLanguage,
      };
      // Let Google auto-detect by omitting `source`
      if (sourceLanguage.isNotEmpty && sourceLanguage != 'auto') {
        body['source'] = sourceLanguage;
      }

      final response = await http
          .post(
            Uri.parse('$_googleTranslateUrl?key=$_googleTranslateApiKey'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              print('Translation request timeout');
              throw Exception('Translation request timeout');
            },
          );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final translations = json['data']['translations'] as List<dynamic>;

        if (translations.length != textsToTranslate.length) {
          print('Translation error: unexpected translations length');
          return List<String>.from(texts);
        }

        // Cache translations and fill output in original order
        for (int i = 0; i < translations.length; i++) {
          final translatedText = translations[i]['translatedText'] as String;
          final originalText = textsToTranslate[i];

          _translationCache.putIfAbsent(originalText, () => <String, String>{});
          _translationCache[originalText]![targetLanguage] = translatedText;

          final originalIndex = indicesToTranslate[i];
          output[originalIndex] = translatedText;
        }

        // Fill any remaining nulls with original text (shouldn't happen)
        for (int i = 0; i < output.length; i++) {
          output[i] ??= texts[i];
        }

        return output.cast<String>().toList(growable: false);
      } else {
        print('Translation error: ${response.statusCode}');
        print('Response: ${response.body}');
        return texts; // Return original texts on error
      }
    } catch (e) {
      print('Exception during translation: $e');
      return texts; // Return original texts on error
    }
  }

  /// Clear the translation cache
  void clearCache() {
    _translationCache.clear();
  }

  /// Get cache statistics
  Map<String, dynamic> getCacheStats() {
    return {
      'totalCachedTexts': _translationCache.length,
      'totalTranslations': _translationCache.values.fold(
        0,
        (sum, map) => sum + map.length,
      ),
    };
  }
}
