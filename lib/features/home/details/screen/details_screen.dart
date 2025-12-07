import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/home/details/controller/details_controller.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/reservation/screen/reservation_screen.dart';
import 'package:elad_giserman/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  final String profileId;

  const DetailsScreen({super.key, required this.profileId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late DetailsController _controller;
  late TextEditingController _commentController;
  late TextEditingController _ratingController;
  final Map<String, TextEditingController> _replyControllers = {};
  final Map<String, bool> _showReplySection = {};
  final Map<String, bool> _showRepliesList = {};
  int _selectedRating = 5;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(DetailsController());
    _commentController = TextEditingController();
    _ratingController = TextEditingController();
    _controller.fetchProfileDetail(widget.profileId);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _ratingController.dispose();
    for (var controller in _replyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _getReplyController(String reviewId) {
    if (!_replyControllers.containsKey(reviewId)) {
      _replyControllers[reviewId] = TextEditingController();
    }
    return _replyControllers[reviewId]!;
  }

  bool _isReplyVisible(String reviewId) {
    return _showReplySection[reviewId] ?? false;
  }

  void _toggleReplyVisibility(String reviewId) {
    setState(() {
      _showReplySection[reviewId] = !_isReplyVisible(reviewId);
      // Show replies list when reply form is opened
      if (_isReplyVisible(reviewId)) {
        _showRepliesList[reviewId] = true;
      }
    });
  }

  bool _isRepliesListVisible(String reviewId) {
    return _showRepliesList[reviewId] ?? true;
  }

  void _toggleRepliesListVisibility(String reviewId) {
    setState(() {
      _showRepliesList[reviewId] = !_isRepliesListVisible(reviewId);
    });
  }

  void _submitReview() async {
    if (_commentController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter a comment',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    await _controller.postReview(
      comment: _commentController.text.trim(),
      rating: _selectedRating,
    );

    _commentController.clear();
    _selectedRating = 5;

    Get.snackbar(
      'Success',
      'Review posted successfully!',
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  void _submitReply(String reviewId) async {
    final replyController = _getReplyController(reviewId);

    if (replyController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter a reply',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    await _controller.replyToReview(
      reviewId: reviewId,
      comment: replyController.text.trim(),
    );

    replyController.clear();

    Get.snackbar(
      'Success',
      'Reply posted successfully!',
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  Widget _buildRatingStars(double rating) {
    int fullStars = rating.toInt();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            i < fullStars
                ? Icons.star
                : (i == fullStars && hasHalfStar)
                ? Icons.star_half
                : Icons.star_outline,
            size: 15,
            color: Colors.deepOrangeAccent,
          ),
      ],
    );
  }

  Widget _buildImageDisplay(String imageUrl) {
    if (imageUrl.isEmpty) {
      return Container(
        height: 248,
        width: Get.width,
        color: Colors.grey[300],
        child: Icon(Icons.image, size: 80, color: Colors.grey),
      );
    }

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        height: 248,
        width: Get.width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 248,
            width: Get.width,
            color: Colors.grey[300],
            child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
          );
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        height: 248,
        width: Get.width,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: AppColors.buttonColor),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 58),
                          child: _controller.galleryItems.isNotEmpty
                              ? _buildImageDisplay(
                                  _controller.galleryItems.first.url,
                                )
                              : Container(
                                  height: 248,
                                  width: Get.width,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        CustomAppBar(
                          lable: 'details_title'.tr,
                          back: '/navBarScreen',
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(18, 20, 18, 30),
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Rating and Favorite
                          Row(
                            children: [
                              _buildRatingStars(_controller.rating),
                              SizedBox(width: 6),
                              Text(
                                '${_controller.rating.toStringAsFixed(1)} (${'reviews'.trParams({'count': _controller.reviewCount.toString()})})',
                                style: getTextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.fontColor,
                                ),
                              ),
                              Spacer(),
                              Obx(
                                () {
                                  final homeController = Get.find<HomeController>();
                                  final isFav = homeController.isFavoriteBusiness(widget.profileId);
                                  return IconButton(
                                    onPressed: () {
                                      homeController.toggleFavoriteBusiness(widget.profileId);
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: isFav ? Colors.red : Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 13),

                          // Title
                          Text(
                            _controller.profileTitle,
                            style: getTextStyle(
                              color: AppColors.primaryFontColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 14),

                          // Location
                          Row(
                            children: [
                              Image.asset(
                                IconPath.activeHistory,
                                height: 18,
                                width: 18,
                                color: AppColors.buttonColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                _controller.profileLocation,
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryFontColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),

                          // Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.buttonColor,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    shadowColor: const Color.fromRGBO(
                                      0,
                                      136,
                                      163,
                                      0.20,
                                    ),
                                    elevation: 10,
                                  ),
                                  onPressed: () {
                                    String mainImage =
                                        _controller.galleryItems.isNotEmpty
                                        ? _controller.galleryItems.first.url
                                        : '';
                                    Get.to(
                                      () => ReservationScreen(image: mainImage),
                                      transition: Transition.downToUp,
                                      duration: const Duration(
                                        milliseconds: 400,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'reserve_seats'.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.buttonColor,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    shadowColor: const Color.fromRGBO(
                                      0,
                                      136,
                                      163,
                                      0.20,
                                    ),
                                    elevation: 10,
                                  ),
                                  onPressed: () {
                                    Get.offNamed(
                                      AppRoute.getRedemptionHistoryScreen(),
                                    );
                                  },
                                  child: Text(
                                    'Redeem Voucher',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Divider(),
                          SizedBox(height: 24),

                          // Organizer Info
                          Row(
                            children: [
                              Image.asset(IconPath.man, height: 45, width: 45),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _controller.profileTitle.isNotEmpty
                                        ? _controller.profileTitle
                                        : 'Organizer',
                                    style: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryFontColor,
                                    ),
                                  ),
                                  Text(
                                    'Organizer',
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.fontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // About Section
                          Text(
                            'about_restaurant'.tr,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Obx(
                            () => Text(
                              _controller.profileDescription,
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.fontColor,
                              ),
                              maxLines: _controller.isExpanded.value ? null : 4,
                              overflow: _controller.isExpanded.value
                                  ? null
                                  : TextOverflow.ellipsis,
                            ),
                          ),
                          if (_controller.profileDescription.length > 150)
                            GestureDetector(
                              onTap: _controller.toggleText,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Obx(
                                  () => Text(
                                    _controller.isExpanded.value
                                        ? 'see_less'.tr
                                        : 'read_more'.tr,
                                    style: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.buttonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 25),

                          // Facilities Section
                          Text(
                            'facilities'.tr,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: AppColors.buttonColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Snack bar',
                                        style: getTextStyle(
                                          fontSize: 14,
                                          color: AppColors.fontColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: AppColors.buttonColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Bikes and Car Parking',
                                        style: getTextStyle(
                                          fontSize: 14,
                                          color: AppColors.fontColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: AppColors.buttonColor,
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            'Toilet',
                                            style: getTextStyle(
                                              fontSize: 14,
                                              color: AppColors.fontColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: AppColors.buttonColor,
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            '24/7 Water facility',
                                            style: getTextStyle(
                                              fontSize: 14,
                                              color: AppColors.fontColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Divider(),
                          SizedBox(height: 25),

                          // Rating & Comments Section
                          Row(
                            children: [
                              Text(
                                'rating_label'.tr,
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryFontColor,
                                ),
                              ),
                              SizedBox(width: 5),
                              _buildRatingStars(_controller.rating),
                              SizedBox(width: 6),
                              Text(
                                '${_controller.rating.toStringAsFixed(1)} (${'reviews'.trParams({'count': _controller.reviewCount.toString()})})',
                                style: getTextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.fontColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Rating Selection
                          Text(
                            'Select Rating:',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              for (int i = 1; i <= 5; i++)
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedRating = i),
                                    child: Icon(
                                      _selectedRating >= i
                                          ? Icons.star
                                          : Icons.star_outline,
                                      size: 28,
                                      color: Colors.deepOrangeAccent,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 12),

                          // Comment TextField
                          TextField(
                            controller: _commentController,
                            maxLines: null,
                            minLines: 3,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: Color(0xFFD2D2D2),
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: Color(0xFFD2D2D2),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: Color(0xFFD2D2D2),
                                  width: 1,
                                ),
                              ),
                              hintText: 'add_a_comment'.tr,
                            ),
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Obx(
                            () => _controller.isPostingReview.value
                                ? CustomSmallButton(
                                    text: 'Posting...',
                                    onPressed: () {},
                                    buttonColor: Colors.grey,
                                    fontColor: Colors.white,
                                    width: 130,
                                  )
                                : CustomSmallButton(
                                    text: 'add_comments_btn'.tr,
                                    onPressed: _submitReview,
                                    buttonColor: AppColors.buttonColor,
                                    fontColor: Colors.white,
                                    width: 130,
                                  ),
                          ),
                          SizedBox(height: 20),
                          Divider(),
                          SizedBox(height: 20),

                          // Existing Reviews Display
                          Row(
                            children: [
                              Image.asset(IconPath.man, height: 24, width: 24),
                              SizedBox(width: 5),
                              Text(
                                'Sarah L.',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryFontColor,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'hours_ago'.trParams({'count': '1'}),
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.fontColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          _buildRatingStars(5.0),
                          SizedBox(height: 12),
                          Text(
                            "Had an amazing time at Karaoke Night! The atmosphere was vibrant, and the staff was super friendly. A perfect night out with friends. Highly recommend the cocktails too!",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.fontColor,
                            ),
                            maxLines: _controller.isExpanded.value ? null : 4,
                            overflow: _controller.isExpanded.value
                                ? null
                                : TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: Color(0xFFD2D2D2),
                              ),
                            ),
                            child: Text(
                              'reply'.tr,
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.fontColor,
                              ),
                            ),
                          ),

                          // API Reviews Display
                          Obx(
                            () => _controller.reviews.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _controller.reviews.length,
                                        itemBuilder: (context, index) {
                                          final review =
                                              _controller.reviews[index];
                                          final replyController =
                                              _getReplyController(review.id);
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 16,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      IconPath.man,
                                                      height: 24,
                                                      width: 24,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'User ${index + 1}',
                                                      style: getTextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .primaryFontColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                _buildRatingStars(
                                                  review.rating.toDouble(),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  review.comment,
                                                  style: getTextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.fontColor,
                                                  ),
                                                ),
                                                SizedBox(height: 12),
                                                GestureDetector(
                                                  onTap: () {
                                                    _toggleReplyVisibility(
                                                      review.id,
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Color(
                                                          0xFFD2D2D2,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'reply'.tr,
                                                          style: getTextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .buttonColor,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Icon(
                                                          _isReplyVisible(
                                                                review.id,
                                                              )
                                                              ? Icons
                                                                    .expand_less
                                                              : Icons
                                                                    .expand_more,
                                                          size: 16,
                                                          color: AppColors
                                                              .buttonColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Show reply input if expanded
                                                if (_isReplyVisible(
                                                  review.id,
                                                )) ...[
                                                  SizedBox(height: 12),
                                                  TextField(
                                                    controller: replyController,
                                                    maxLines: null,
                                                    minLines: 3,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 16,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: Color(
                                                            0xFFD2D2D2,
                                                          ),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  6,
                                                                ),
                                                            borderSide:
                                                                BorderSide(
                                                                  color: Color(
                                                                    0xFFD2D2D2,
                                                                  ),
                                                                  width: 1,
                                                                ),
                                                          ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  6,
                                                                ),
                                                            borderSide:
                                                                BorderSide(
                                                                  color: Color(
                                                                    0xFFD2D2D2,
                                                                  ),
                                                                  width: 1,
                                                                ),
                                                          ),
                                                      hintText:
                                                          'Enter your reply...',
                                                    ),
                                                    style: getTextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .primaryFontColor,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Obx(
                                                    () =>
                                                        _controller
                                                            .isReplyingToReview
                                                            .value
                                                        ? CustomSmallButton(
                                                            text: 'Replying...',
                                                            onPressed: () {},
                                                            buttonColor:
                                                                Colors.grey,
                                                            fontColor:
                                                                Colors.white,
                                                            width: 100,
                                                          )
                                                        : CustomSmallButton(
                                                            text: 'reply'.tr,
                                                            onPressed: () =>
                                                                _submitReply(
                                                                  review.id,
                                                                ),
                                                            buttonColor:
                                                                AppColors
                                                                    .buttonColor,
                                                            fontColor:
                                                                Colors.white,
                                                            width: 100,
                                                          ),
                                                  ),
                                                ],
                                                // Display replies if any
                                                if (review
                                                    .replies
                                                    .isNotEmpty) ...[
                                                  SizedBox(height: 12),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _toggleRepliesListVisibility(
                                                        review.id,
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 2,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                            0xFFD2D2D2,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Replies (${review.replies.length})',
                                                            style: getTextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .buttonColor,
                                                            ),
                                                          ),
                                                          SizedBox(width: 4),
                                                          Icon(
                                                            _isRepliesListVisible(
                                                                  review.id,
                                                                )
                                                                ? Icons
                                                                      .expand_less
                                                                : Icons
                                                                      .expand_more,
                                                            size: 16,
                                                            color: AppColors
                                                                .buttonColor,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Show replies container if expanded
                                                  if (_isRepliesListVisible(
                                                    review.id,
                                                  )) ...[
                                                    SizedBox(height: 8),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 16,
                                                        top: 8,
                                                        bottom: 8,
                                                      ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border(
                                                            left: BorderSide(
                                                              color: AppColors
                                                                  .buttonColor,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          color: Color(
                                                            0xFFF5F5F5,
                                                          ),
                                                        ),
                                                        padding: EdgeInsets.all(
                                                          12,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: review
                                                              .replies
                                                              .map(
                                                                (
                                                                  reply,
                                                                ) => Padding(
                                                                  padding:
                                                                      EdgeInsets.only(
                                                                        bottom:
                                                                            12,
                                                                      ),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(
                                                                              horizontal: 8,
                                                                              vertical: 2,
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                              color: AppColors.buttonColor,
                                                                              borderRadius: BorderRadius.circular(
                                                                                4,
                                                                              ),
                                                                            ),
                                                                            child: Text(
                                                                              'Organizer',
                                                                              style: getTextStyle(
                                                                                fontSize: 11,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            'Just now',
                                                                            style: getTextStyle(
                                                                              fontSize: 11,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.fontColor,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        reply
                                                                            .comment,
                                                                        style: getTextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              AppColors.primaryFontColor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                              .toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : SizedBox(),
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
