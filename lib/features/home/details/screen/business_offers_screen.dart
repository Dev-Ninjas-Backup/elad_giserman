import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/core/services/translation_service.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/offers/controller/offers_controller.dart';
import 'package:elad_giserman/features/home/offers/models/offer_model.dart';
import 'package:elad_giserman/features/home/redemption/controller/redemption_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BusinessOffersScreen extends StatefulWidget {
  final String businessId;
  final String businessName;
  final List<OfferModel>? offers;

  const BusinessOffersScreen({
    super.key,
    required this.businessId,
    required this.businessName,
    this.offers,
  });

  @override
  State<BusinessOffersScreen> createState() => _BusinessOffersScreenState();
}

class _BusinessOffersScreenState extends State<BusinessOffersScreen> {
  late OffersController _offersController;
  late RedemptionController _redemptionController;

  @override
  void initState() {
    super.initState();
    _offersController = Get.put(OffersController());
    _redemptionController = Get.put(RedemptionController());
    // If offers are passed from details screen, use them directly
    if (widget.offers != null && widget.offers!.isNotEmpty) {
      _offersController.setOffers(widget.offers!);
    } else {
      // Otherwise fetch from API
      Future.delayed(Duration.zero, () {
        _offersController.fetchOffers();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _checkLoginStatus() async {
    final token = await SharedPreferencesHelper.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('login_required'.tr),
          content: Text('login_to_redeem_offers'.tr),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Get.offAllNamed('/signInScreen');
              },
              child: Text(
                'sign_in'.tr,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleOfferTap(OfferModel offer) async {
    final isLoggedIn = await _checkLoginStatus();
    if (!isLoggedIn) {
      _showLoginRequiredDialog();
      return;
    }
    _showOfferRedeemDialog(offer);
  }

  void _showOfferRedeemDialog(OfferModel offer) {
    String? errorMessageInDialog;
    bool isRedeemSuccess = false;

    // Translate offer data
    final translatedTitle = offer.title.obs;
    final translatedDescription = offer.description.obs;
    _translateOfferData(
      offer.title,
      offer.description,
      translatedTitle,
      translatedDescription,
    );

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'redeem_voucher_code'.tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Success message display
                    if (isRedeemSuccess) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          border: Border.all(
                            color: Colors.green[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.green[700],
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'code_redeemed_success'.tr,
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _redemptionController.successMessage.value,
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Offer Details Card
                      // Container(
                      //   padding: const EdgeInsets.all(12),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: AppColors.borderColor,
                      //       width: 1,
                      //     ),
                      //     borderRadius: BorderRadius.circular(8),
                      //     color: Colors.grey[50],
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Obx(
                      //         () => Text(
                      //           translatedTitle.value,
                      //           style: getTextStyle(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w600,
                      //             color: AppColors.primaryFontColor,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(height: 8),
                      //       Obx(
                      //         () => Text(
                      //           translatedDescription.value,
                      //           style: getTextStyle(
                      //             fontSize: 13,
                      //             fontWeight: FontWeight.w400,
                      //             color: AppColors.fontColor,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(height: 8),
                      //       Row(
                      //         children: [
                      //           Icon(
                      //             Icons.calendar_today,
                      //             size: 14,
                      //             color: AppColors.fontColor,
                      //           ),
                      //           const SizedBox(width: 4),
                      //           Text(
                      //             '${'expires'.tr}${DateFormat('MMM dd, yyyy').format(DateTime.parse(offer.expiredsAt))}',
                      //             style: getTextStyle(
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.w400,
                      //               color: AppColors.fontColor,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 16),

                      // QR/Barcode Redemption Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.buttonColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Business Name Header
                            Text(
                              widget.businessName,
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.fontColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),

                            // QR Code
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.buttonColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: QrImageView(
                                data: offer.code.isEmpty
                                    ? 'Code not available'
                                    : offer.code,
                                version: QrVersions.auto,
                                errorCorrectionLevel: QrErrorCorrectLevel.H,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Offer Benefits
                            Obx(
                              () => Text(
                                translatedTitle.value,
                                style: getTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryFontColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(
                              () => Text(
                                translatedDescription.value,
                                style: getTextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.fontColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: AppColors.fontColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${'expires'.tr}${DateFormat('MMM dd, yyyy').format(DateTime.parse(offer.expiredsAt))}',
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.fontColor,
                                  ),
                                ),
                              ],
                            ),

                            // // Redemption Date and Time
                            // Container(
                            //   padding: const EdgeInsets.symmetric(
                            //     vertical: 8,
                            //     horizontal: 12,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: Colors.grey[50],
                            //     borderRadius: BorderRadius.circular(6),
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Icon(
                            //         Icons.calendar_today,
                            //         size: 14,
                            //         color: AppColors.fontColor,
                            //       ),
                            //       const SizedBox(width: 6),
                            //       // Text(
                            //       //   'Code Generation: ${DateFormat('MMM dd, yyyy').format(DateTime.now())} - ${DateFormat('HH:mm').format(DateTime.now())}',
                            //       //   style: getTextStyle(
                            //       //     fontSize: 12,
                            //       //     fontWeight: FontWeight.w400,
                            //       //     color: AppColors.fontColor,
                            //       //   ),
                            //       // ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                      // Error message display
                      if (errorMessageInDialog != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            border: Border.all(
                              color: Colors.red[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red[600],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  errorMessageInDialog ?? 'N/A',
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red[700]!,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
              actions: isRedeemSuccess
                  ? [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text('ok'.tr),
                      ),
                    ]
                  : [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text('cancel'.tr),
                      ),
                      Obx(
                        () => TextButton(
                          onPressed: _redemptionController.isLoading.value
                              ? null
                              : () async {
                                  // Clear previous error
                                  setState(() {
                                    errorMessageInDialog = null;
                                  });

                                  final success = await _redemptionController
                                      .redeemCode(
                                        offer.code,
                                        offerId: offer.id,
                                      );

                                  if (mounted) {
                                    if (success) {
                                      // Update UI to show success message
                                      setState(() {
                                        isRedeemSuccess = true;
                                      });
                                    } else {
                                      // Translate error message
                                      final errorMsg = _redemptionController
                                          .errorMessage
                                          .value;
                                      _translateText(
                                        errorMsg,
                                        Get.locale?.languageCode ?? 'en',
                                      ).then((translatedError) {
                                        if (mounted) {
                                          setState(() {
                                            errorMessageInDialog =
                                                translatedError;
                                          });
                                        }
                                      });
                                    }
                                  }
                                },
                          child: Text(
                            _redemptionController.isLoading.value
                                ? 'redeeming'.tr
                                : 'redeem'.tr,
                            style: TextStyle(
                              color: _redemptionController.isLoading.value
                                  ? Colors.grey
                                  : AppColors.buttonColor,
                            ),
                          ),
                        ),
                      ),
                    ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(lable: widget.businessName, back: '/navBarScreen'),
              Container(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 30),
                width: Get.width,
                child: _offersController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      )
                    : _offersController.offers
                          .where(
                            (offer) => offer.businessId == widget.businessId,
                          )
                          .toList()
                          .isEmpty
                    ? Column(
                        children: [
                          if (_offersController.errorMessage.value.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  border: Border.all(
                                    color: Colors.red[300]!,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red[600],
                                      size: 48,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      _offersController.errorMessage.value,
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red[700]!,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        _offersController.fetchOffers();
                                      },
                                      child: Text('retry'.tr),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                Icon(
                                  Icons.local_offer_outlined,
                                  size: 80,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'no_offers_available'.tr,
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.fontColor,
                                  ),
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          if (_offersController.errorMessage.value.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  border: Border.all(
                                    color: Colors.orange[300]!,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.orange[600],
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _offersController.errorMessage.value,
                                        style: getTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.orange[700]!,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _offersController.offers
                                .where(
                                  (offer) =>
                                      offer.businessId == widget.businessId,
                                )
                                .length,
                            itemBuilder: (context, index) {
                              final filteredOffers = _offersController.offers
                                  .where(
                                    (offer) =>
                                        offer.businessId == widget.businessId,
                                  )
                                  .toList();
                              final offer = filteredOffers[index];
                              final isExpired = DateTime.parse(
                                offer.expiredsAt,
                              ).isBefore(DateTime.now());

                              return GestureDetector(
                                onTap: !isExpired
                                    ? () => _handleOfferTap(offer)
                                    : null,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isExpired
                                          ? Colors.grey[300]!
                                          : AppColors.buttonColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: isExpired
                                        ? Colors.grey[100]
                                        : Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Header row with title and badge
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              offer.title,
                                              style: getTextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: isExpired
                                                    ? Colors.grey
                                                    : AppColors
                                                          .primaryFontColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isExpired
                                                  ? Colors.grey[300]
                                                  : AppColors.buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              isExpired
                                                  ? 'offer_status_expired'.tr
                                                  : 'offer_status_active'.tr,
                                              style: getTextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),

                                      // Description
                                      Text(
                                        offer.description,
                                        style: getTextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.fontColor,
                                        ),
                                      ),
                                      const SizedBox(height: 12),

                                      // Code and expiry info
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'code'.tr,
                                                style: getTextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.fontColor,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                offer.code,
                                                style: getTextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .primaryFontColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'expires_short'.tr,
                                                style: getTextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.fontColor,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                DateFormat('MMM dd').format(
                                                  DateTime.parse(
                                                    offer.expiredsAt,
                                                  ),
                                                ),
                                                style: getTextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: isExpired
                                                      ? Colors.red
                                                      : AppColors
                                                            .primaryFontColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      // Redeem button
                                      if (!isExpired)
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.buttonColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () =>
                                                _handleOfferTap(offer),
                                            child: Text(
                                              'view_and_redeem'.tr,
                                              style: getTextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
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

  void _translateOfferData(
    String title,
    String description,
    RxString translatedTitle,
    RxString translatedDescription,
  ) {
    final currentLanguage = Get.locale?.languageCode ?? 'en';

    if (currentLanguage != 'en') {
      _translateText(title, currentLanguage).then((translated) {
        translatedTitle.value = translated;
      });

      _translateText(description, currentLanguage).then((translated) {
        translatedDescription.value = translated;
      });
    }
  }

  Future<String> _translateText(String text, String targetLanguage) async {
    try {
      final translationService = Get.find<TranslationService>();
      return await translationService.translateText(
        text: text,
        targetLanguage: targetLanguage,
        sourceLanguage: 'en',
      );
    } catch (e) {
      return text;
    }
  }
}
