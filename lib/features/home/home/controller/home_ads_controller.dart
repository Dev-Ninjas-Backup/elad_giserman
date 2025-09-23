import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeAdsController extends GetxController {
  Rx<BannerAd?> bannerAd1 = Rx<BannerAd?>(null);
  Rx<BannerAd?> bannerAd2 = Rx<BannerAd?>(null);
  Rx<BannerAd?> bannerAd3 = Rx<BannerAd?>(null);

  final String adUnitId = 'ca-app-pub-3940256099942544/6300978111';

  @override
  void onInit() {
    super.onInit();
    _loadBanner(bannerAd1);
    _loadBanner(bannerAd2);
    _loadBanner(bannerAd3);
  }

  void _loadBanner(Rx<BannerAd?> bannerSlot) {
    final ad = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => bannerSlot.value = ad as BannerAd,
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          bannerSlot.value = null;
        },
      ),
    );
    ad.load();
  }

  @override
  void onClose() {
    bannerAd1.value?.dispose();
    bannerAd2.value?.dispose();
    bannerAd3.value?.dispose();
    super.onClose();
  }
}
