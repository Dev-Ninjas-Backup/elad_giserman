// ignore_for_file: avoid_print

import 'package:elad_giserman/core/extensions/business_profile_translation_extension.dart';
import 'package:elad_giserman/core/services/translation_service.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/home/home/model/business_profile_model.dart';
import 'package:elad_giserman/features/home/home/model/category_model.dart';
import 'package:elad_giserman/features/home/home/model/custom_app_details_model.dart';
import 'package:elad_giserman/features/home/home/model/favorite_model.dart';
import 'package:elad_giserman/features/home/home/service/business_profile_service.dart';
import 'package:elad_giserman/features/home/home/service/category_service.dart';
import 'package:elad_giserman/features/home/home/service/custom_app_details_service.dart';
import 'package:elad_giserman/features/home/home/service/favorite_service.dart';
import 'package:get/get.dart';

class Place {
  final String image;
  final String title;
  final String subTitle;
  final double rating;
  final int reviewNum;
  final String category;
  bool isFavorite;

  Place({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.rating,
    required this.reviewNum,
    required this.category,
    this.isFavorite = false,
  });
}

class Recommended {
  final String image;
  final String title;
  final String description;
  final String location;
  bool isFavorite;

  Recommended({
    required this.image,
    required this.title,
    required this.description,
    required this.location,
    this.isFavorite = false,
  });
}

class HomeController extends GetxController {
  var restaurants = <Place>[].obs;
  var recommended = <Recommended>[].obs;
  var categories = <CategoryModel>[].obs;
  var businessProfiles = <BusinessProfile>[].obs;
  var searchResults = <BusinessProfile>[].obs;
  var favorites = <Favorite>[].obs;
  var isLoadingFavorites = false.obs;
  var searchQuery = ''.obs;
  var customAppDetails = Rx<CustomAppDetails?>(null);

  String? _pendingTranslationLanguageCode;

  final CategoryService _categoryService = CategoryService();
  final BusinessProfileService _profileService = BusinessProfileService();
  final FavoriteService _favoriteService = FavoriteService();
  final CustomAppDetailsService _customAppDetailsService =
      CustomAppDetailsService();

  @override
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchBusinessProfiles();
    fetchCustomAppDetails();
    restaurants.value = [
      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Rothschild Blvd 22, Tel Aviv, Israel",
        rating: 4.9,
        reviewNum: 327,
        category: "Restaurant",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.7,
        reviewNum: 210,
        category: "Bar",
      ),
      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.5,
        reviewNum: 210,
        category: "Cafe",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.8,
        reviewNum: 210,
        category: "Bar",
      ),

      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Rothschild Blvd 22, Tel Aviv, Israel",
        rating: 4.9,
        reviewNum: 327,
        category: "Restaurant",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.7,
        reviewNum: 210,
        category: "Bar",
      ),
      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.5,
        reviewNum: 210,
        category: "Cafe",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.8,
        reviewNum: 210,
        category: "Bar",
      ),

      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Rothschild Blvd 22, Tel Aviv, Israel",
        rating: 4.9,
        reviewNum: 327,
        category: "Restaurant",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.7,
        reviewNum: 210,
        category: "Bar",
      ),
      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.5,
        reviewNum: 210,
        category: "Cafe",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.8,
        reviewNum: 210,
        category: "Bar",
      ),
    ];

    recommended.value = [
      Recommended(
        image: ImagePath.recommended1,
        title: 'Gatsby Vintage Cocktail Room & Lounge',
        description:
            'A renowned venue for live music, Zappa hosts both local and international acts in a vibrant, energetic environment. Ideal for concerts, music lovers, and late-night entertainment.',
        location: 'Rothschild Blvd 22, Tel Aviv, Israel',
      ),
      Recommended(
        image: ImagePath.recommended2,
        title: 'Mamilla Hotel Rooftop Lounge',
        description:
            'A renowned venue for live music, Zappa hosts both local and international acts in a vibrant, energetic environment. Ideal for concerts, music lovers, and late-night entertainment.',
        location: 'Rothschild Blvd 22, Tel Aviv, Israel',
      ),
      Recommended(
        image: ImagePath.recommended3,
        title: 'The Little Prince Bookstore Café',
        description:
            'A renowned venue for live music, Zappa hosts both local and international acts in a vibrant, energetic environment. Ideal for concerts, music lovers, and late-night entertainment.',
        location: 'Rothschild Blvd 22, Tel Aviv, Israel',
      ),
      Recommended(
        image: ImagePath.recommended1,
        title: 'The Vibe Bar',
        description:
            'A renowned venue for live music, Zappa hosts both local and international acts in a vibrant, energetic environment. Ideal for concerts, music lovers, and late-night entertainment.',
        location: 'Rothschild Blvd 22, Tel Aviv, Israel',
      ),
    ];
  }

  void toggleFavorite(int index) {
    restaurants[index].isFavorite = !restaurants[index].isFavorite;
    restaurants.refresh();
  }

  void toggleRecommendedFavorite(int index) {
    if (index < 0 || index >= recommended.length) return;
    recommended[index].isFavorite = !recommended[index].isFavorite;
    recommended.refresh();
  }

  Future<void> fetchCategories() async {
    final fetchedCategories = await _categoryService.getCategories();
    categories.value = fetchedCategories;

    final lang =
        _pendingTranslationLanguageCode ?? (Get.locale?.languageCode ?? 'en');
    if (lang != 'en') {
      await _translateCategories(lang);
    }
  }

  Future<void> fetchBusinessProfiles() async {
    final fetchedProfiles = await _profileService.getAllProfiles();
    businessProfiles.value = fetchedProfiles;

    final lang =
        _pendingTranslationLanguageCode ?? (Get.locale?.languageCode ?? 'en');
    if (lang != 'en') {
      await translateAllData(lang);
    }
  }

  Future<void> fetchMyFavorites() async {
    isLoadingFavorites.value = true;
    try {
      final fetchedFavorites = await _favoriteService.getMyFavorites();
      favorites.value = fetchedFavorites;
      print('✅ Favorites loaded: ${favorites.length} items');
    } catch (e) {
      print('❌ Error fetching favorites: $e');
    } finally {
      isLoadingFavorites.value = false;
    }
  }

  Future<void> toggleFavoriteBusiness(String restaurantId) async {
    try {
      await _favoriteService.toggleFavorite(restaurantId);
      // Always refresh favorites list after toggle (success or failure)
      await fetchMyFavorites();
    } catch (e) {
      print('❌ Error toggling favorite: $e');
    }
  }

  bool isFavoriteBusiness(String restaurantId) {
    return _favoriteService.isFavorite(restaurantId, favorites);
  }

  // Search functionality
  void searchByQuery(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    final lowerQuery = query.toLowerCase();
    print('🔍 Searching for: $query in ${businessProfiles.length} profiles');

    searchResults.value = businessProfiles
        .where(
          (profile) =>
              profile.title.toLowerCase().contains(lowerQuery) ||
              profile.description.toLowerCase().contains(lowerQuery) ||
              profile.location.toLowerCase().contains(lowerQuery),
        )
        .toList();

    print('✅ Found ${searchResults.length} results for: $query');
  }

  void clearSearchResults() {
    searchResults.clear();
    searchQuery.value = '';
  }

  Future<void> fetchCustomAppDetails() async {
    try {
      print('📡 Fetching custom app details...');
      final details = await _customAppDetailsService.fetchCustomAppDetails();
      if (details != null) {
        customAppDetails.value = details;
        print('✅ Custom app details loaded: ${details.title}');

        final lang =
            _pendingTranslationLanguageCode ??
            (Get.locale?.languageCode ?? 'en');
        if (lang != 'en') {
          await _translateCustomAppDetails(lang);
        }
      } else {
        print('⚠️ No custom app details found');
      }
    } catch (e) {
      print('❌ Error fetching custom app details: $e');
    }
  }

  /// Translate all business profiles to the target language
  /// This is called when the user changes the language
  Future<void> translateAllData(String targetLanguageCode) async {
    try {
      print('🌐 Translating all data to: $targetLanguageCode');

      // If called before data loads, remember the language and translate after fetch.
      if (businessProfiles.isEmpty) {
        _pendingTranslationLanguageCode = targetLanguageCode;
      }

      // Categories + custom details should also switch language
      await _translateCategories(targetLanguageCode);
      await _translateCustomAppDetails(targetLanguageCode);

      if (businessProfiles.isEmpty) {
        print('⚠️ No business profiles to translate yet (queued)');
        return;
      }

      // Translate all business profiles
      final translatedProfiles = <BusinessProfile>[];
      for (var profile in businessProfiles) {
        final translated = await profile.translated(targetLanguageCode);
        translatedProfiles.add(translated);
      }
      businessProfiles.value = translatedProfiles;
      print('✅ All ${translatedProfiles.length} profiles translated');

      // Translate search results if any
      if (searchResults.isNotEmpty) {
        final translatedSearchResults = <BusinessProfile>[];
        for (var profile in searchResults) {
          final translated = await profile.translated(targetLanguageCode);
          translatedSearchResults.add(translated);
        }
        searchResults.value = translatedSearchResults;
      }

      _pendingTranslationLanguageCode = null;
    } catch (e) {
      print('❌ Error translating data: $e');
    }
  }

  Future<void> _translateCategories(String targetLanguageCode) async {
    try {
      if (categories.isEmpty || targetLanguageCode == 'en') return;

      final translationService = Get.find<TranslationService>();
      final names = categories.map((c) => c.name).toList(growable: false);
      if (names.isEmpty) return;

      final translated = await translationService.translateMultiple(
        texts: names,
        targetLanguage: targetLanguageCode,
        sourceLanguage: 'en',
      );

      final updated = <CategoryModel>[];
      for (int i = 0; i < categories.length; i++) {
        final c = categories[i];
        updated.add(
          CategoryModel(
            id: c.id,
            name: translated[i],
            createdAt: c.createdAt,
            updatedAt: c.updatedAt,
          ),
        );
      }
      categories.value = updated;
    } catch (e) {
      print('❌ Error translating categories: $e');
    }
  }

  Future<void> _translateCustomAppDetails(String targetLanguageCode) async {
    try {
      final details = customAppDetails.value;
      if (details == null || targetLanguageCode == 'en') return;

      final translationService = Get.find<TranslationService>();
      final translated = await translationService.translateMultiple(
        texts: [details.title, details.description],
        targetLanguage: targetLanguageCode,
        sourceLanguage: 'en',
      );

      customAppDetails.value = CustomAppDetails(
        id: details.id,
        title: translated[0],
        description: translated[1],
        logo: details.logo,
        bannerCard: details.bannerCard,
        bannerPhoto: details.bannerPhoto,
        createAt: details.createAt,
        updatedAt: details.updatedAt,
      );
    } catch (e) {
      print('❌ Error translating custom app details: $e');
    }
  }

  /// Clear translation cache
  void clearTranslationCache() {
    try {
      final translationService = Get.find<TranslationService>();
      translationService.clearCache();
      print('✅ Translation cache cleared');
    } catch (e) {
      print('⚠️ Translation service not found');
    }
  }
}
