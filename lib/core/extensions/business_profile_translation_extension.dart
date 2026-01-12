import 'package:elad_giserman/core/services/translation_service.dart';
import 'package:elad_giserman/features/home/home/model/business_profile_model.dart';
import 'package:get/get.dart';

extension BusinessProfileTranslation on BusinessProfile {
  /// Create a copy of BusinessProfile with translated fields
  Future<BusinessProfile> translated(String targetLanguage) async {
    final translationService = Get.find<TranslationService>();

    // Translate multiple fields at once for efficiency
    final textsToTranslate = [title, description, location, category.name];

    final translatedTexts = await translationService.translateMultiple(
      texts: textsToTranslate,
      targetLanguage: targetLanguage,
      sourceLanguage: 'en',
    );

    // Create new category with translated name
    final translatedCategory = ProfileCategory(
      id: category.id,
      name: translatedTexts[3],
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );

    // Create new BusinessProfile with translated fields
    return BusinessProfile(
      id: id,
      title: translatedTexts[0],
      description: translatedTexts[1],
      location: translatedTexts[2],
      isActive: isActive,
      openingTime: openingTime,
      closingTime: closingTime,
      categoryId: categoryId,
      profileTypeName: profileTypeName,
      ownerId: ownerId,
      facebook: facebook,
      instagram: instagram,
      twitter: twitter,
      website: website,
      linkedin: linkedin,
      pinterest: pinterest,
      youtube: youtube,
      createdAt: createdAt,
      updatedAt: updatedAt,
      category: translatedCategory,
      gallery: gallery,
      owner: owner,
      totalOffers: totalOffers,
      totalRedemptions: totalRedemptions,
      reviewCount: reviewCount,
      avgRating: avgRating,
    );
  }
}

extension ProfileCategoryTranslation on ProfileCategory {
  /// Create a copy with translated name
  Future<ProfileCategory> translated(String targetLanguage) async {
    final translationService = Get.find<TranslationService>();
    final translatedName = await translationService.translateText(
      text: name,
      targetLanguage: targetLanguage,
      sourceLanguage: 'en',
    );

    return ProfileCategory(
      id: id,
      name: translatedName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
