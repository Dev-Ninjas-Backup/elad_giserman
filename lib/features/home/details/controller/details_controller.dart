// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:elad_giserman/features/home/details/model/profile_detail_model.dart';
import 'package:elad_giserman/features/home/details/service/profile_detail_service.dart';
import 'package:elad_giserman/features/home/details/service/review_service.dart';
import 'package:elad_giserman/features/home/offers/models/offer_model.dart';

class DetailsController extends GetxController {
  final ProfileDetailService _service = ProfileDetailService();
  final ReviewService _reviewService = ReviewService();

  final Rx<BusinessProfileDetail?> profileDetail = Rx<BusinessProfileDetail?>(
    null,
  );
  final RxBool isLoading = true.obs;
  final RxBool isExpanded = false.obs;
  final RxBool isPostingReview = false.obs;
  final RxBool isReplyingToReview = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(profileDetail, (_) {
      print('🔄 Profile detail updated: ${profileDetail.value?.title}');
    });
  }

  Future<void> fetchProfileDetail(String profileId) async {
    try {
      isLoading.value = true;
      print('📡 Fetching profile detail for ID: $profileId');
      final detail = await _service.getProfileDetail(profileId);
      if (detail != null) {
        profileDetail.value = detail;
        print('✅ Profile detail loaded: ${detail.title}');
      } else {
        print('❌ Failed to load profile detail');
      }
    } catch (e) {
      print('❌ Error fetching profile detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postReview({
    required String comment,
    required int rating,
  }) async {
    try {
      if (comment.trim().isEmpty) {
        print('⚠️ Comment cannot be empty');
        return;
      }

      if (profileDetail.value == null) {
        print('⚠️ Profile detail not loaded');
        return;
      }

      isPostingReview.value = true;
      print('📝 Posting review...');

      final review = await _reviewService.postReview(
        comment: comment,
        rating: rating,
        businessProfileId: profileDetail.value!.id,
      );

      if (review != null) {
        // Add the new review to the list
        final currentReviews = List<Review>.from(
          profileDetail.value?.reviews ?? [],
        );
        currentReviews.insert(0, review);

        // Update the profile detail with new review
        final updatedDetail = profileDetail.value?.copyWith(
          reviews: currentReviews,
          reviewCount: (profileDetail.value?.reviewCount ?? 0) + 1,
        );

        if (updatedDetail != null) {
          profileDetail.value = updatedDetail;
        }

        print('✅ Review posted and list updated');
      }
    } catch (e) {
      print('❌ Error posting review: $e');
    } finally {
      isPostingReview.value = false;
    }
  }

  Future<void> replyToReview({
    required String reviewId,
    required String comment,
  }) async {
    try {
      if (comment.trim().isEmpty) {
        print('⚠️ Reply comment cannot be empty');
        return;
      }

      isReplyingToReview.value = true;
      print('💬 Posting reply...');

      final reply = await _reviewService.replyToReview(
        reviewId: reviewId,
        comment: comment,
      );

      if (reply != null) {
        // Find the review and add the reply to it
        final currentReviews = List<Review>.from(
          profileDetail.value?.reviews ?? [],
        );

        final reviewIndex = currentReviews.indexWhere((r) => r.id == reviewId);
        if (reviewIndex != -1) {
          final currentReview = currentReviews[reviewIndex];
          final updatedReplies = List<ReviewReply>.from(currentReview.replies);
          updatedReplies.add(reply);

          // Create updated review with new replies
          final updatedReview = Review(
            id: currentReview.id,
            comment: currentReview.comment,
            rating: currentReview.rating,
            userId: currentReview.userId,
            businessId: currentReview.businessId,
            createdAt: currentReview.createdAt,
            updatedAt: currentReview.updatedAt,
            replies: updatedReplies,
          );

          currentReviews[reviewIndex] = updatedReview;

          // Update the profile detail
          final updatedDetail = profileDetail.value?.copyWith(
            reviews: currentReviews,
          );

          if (updatedDetail != null) {
            profileDetail.value = updatedDetail;
          }
        }

        print('✅ Reply posted and review updated');
      }
    } catch (e) {
      print('❌ Error replying to review: $e');
    } finally {
      isReplyingToReview.value = false;
    }
  }

  void toggleText() {
    isExpanded.value = !isExpanded.value;
  }

  // Helper methods for UI
  String get profileTitle => profileDetail.value?.title ?? 'Profile Details';
  String get profileDescription => profileDetail.value?.description ?? '';
  String get profileLocation => profileDetail.value?.location ?? '';
  String get profilePhone => profileDetail.value?.phone ?? '';
  List<GalleryItem> get galleryItems => profileDetail.value?.gallery ?? [];
  List<Offer> get offers => profileDetail.value?.offers ?? [];
  List<Review> get reviews => profileDetail.value?.reviews ?? [];
  double get rating => profileDetail.value?.rating ?? 0.0;
  int get reviewCount => profileDetail.value?.reviewCount ?? 0;
  String get openingTime => profileDetail.value?.openingTime ?? '';
  String get closingTime => profileDetail.value?.closingTime ?? '';

  // Convert Offer objects to OfferModel objects for business offers screen
  List<OfferModel> get businessOffers {
    final offersList = profileDetail.value?.offers ?? [];
    final profileDetail_ = profileDetail.value;

    return offersList
        .map(
          (offer) => OfferModel(
            id: offer.id,
            title: offer.title,
            description: offer.description,
            isActive: offer.isActive,
            status: offer.status,
            businessId: offer.businessId,
            expiredsAt: offer.expiredsAt,
            code: offer.code,
            qrCodeUrl: offer.qrCodeUrl,
            createdAt: offer.createdAt,
            updatedAt: offer.updatedAt,
            business: BusinessModel(
              id: profileDetail_?.id ?? '',
              title: profileDetail_?.title ?? '',
              description: profileDetail_?.description ?? '',
              location: profileDetail_?.location ?? '',
              isActive: profileDetail_?.isActive ?? false,
              openingTime: profileDetail_?.openingTime ?? '',
              closingTime: profileDetail_?.closingTime ?? '',
              categoryId: profileDetail_?.categoryId,
              ownerId: profileDetail_?.ownerId ?? '',
              createdAt: profileDetail_?.createdAt ?? '',
              updatedAt: profileDetail_?.updatedAt ?? '',
              profileTypeName: profileDetail_?.profileTypeName,
              facebook: profileDetail_?.facebook,
              instagram: profileDetail_?.instagram,
              linkedin: profileDetail_?.linkedin,
              pinterest: profileDetail_?.pinterest,
              twitter: profileDetail_?.twitter,
              website: profileDetail_?.website,
              youtube: profileDetail_?.youtube,
            ),
          ),
        )
        .toList();
  }
}

extension BusinessProfileDetailExtension on BusinessProfileDetail {
  BusinessProfileDetail copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    bool? isActive,
    String? openingTime,
    String? closingTime,
    String? categoryId,
    String? profileTypeName,
    String? ownerId,
    String? facebook,
    String? instagram,
    String? twitter,
    String? website,
    String? linkedin,
    String? pinterest,
    String? youtube,
    String? phone,
    String? createdAt,
    String? updatedAt,
    List<GalleryItem>? gallery,
    List<Offer>? offers,
    List<Review>? reviews,
    double? rating,
    int? reviewCount,
  }) {
    return BusinessProfileDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      isActive: isActive ?? this.isActive,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      categoryId: categoryId ?? this.categoryId,
      profileTypeName: profileTypeName ?? this.profileTypeName,
      ownerId: ownerId ?? this.ownerId,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      website: website ?? this.website,
      linkedin: linkedin ?? this.linkedin,
      pinterest: pinterest ?? this.pinterest,
      youtube: youtube ?? this.youtube,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gallery: gallery ?? this.gallery,
      offers: offers ?? this.offers,
      reviews: reviews ?? this.reviews,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}
