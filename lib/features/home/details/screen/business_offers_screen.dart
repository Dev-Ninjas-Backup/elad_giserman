import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/offers/controller/offers_controller.dart';
import 'package:elad_giserman/features/home/offers/models/offer_model.dart';
import 'package:elad_giserman/features/home/redemption/controller/redemption_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  late TextEditingController _redeemCodeController;

  @override
  void initState() {
    super.initState();
    _offersController = Get.put(OffersController());
    _redemptionController = Get.put(RedemptionController());
    _redeemCodeController = TextEditingController();
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
    _redeemCodeController.dispose();
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
    _redeemCodeController.text = offer.code;
    String? errorMessageInDialog;
    bool isRedeemSuccess = false;

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
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[50],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.title,
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryFontColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              offer.description,
                              style: getTextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColors.fontColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Code Input Field
                      TextField(
                        controller: _redeemCodeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'voucher_code'.tr,
                          hintStyle: const TextStyle(
                            color: Color(0xFF636363),
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColors.textFieldFillColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.borderColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.buttonColor,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                        ),
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryFontColor,
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
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red[600],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  errorMessageInDialog!,
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red[700]!,
                                  ),
                                ),
                              ),
                            ],
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
                                  final code = _redeemCodeController.text
                                      .trim();
                                  if (code.isEmpty) {
                                    setState(() {
                                      errorMessageInDialog =
                                          'enter_redeem_code'.tr;
                                    });
                                    return;
                                  }

                                  // Clear previous error
                                  setState(() {
                                    errorMessageInDialog = null;
                                  });

                                  final success = await _redemptionController
                                      .redeemCode(code, offerId: offer.id);

                                  if (mounted) {
                                    if (success) {
                                      // Update UI to show success message
                                      setState(() {
                                        isRedeemSuccess = true;
                                      });
                                      _redeemCodeController.clear();
                                    } else {
                                      // Show error in dialog
                                      setState(() {
                                        errorMessageInDialog =
                                            _redemptionController
                                                .errorMessage
                                                .value;
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
}
