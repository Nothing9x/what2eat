import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  bool _isInitialized = false;

  /// Initialize Google Mobile Ads SDK
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Configure test device for testing real ads before publishing
    final RequestConfiguration configuration = RequestConfiguration(
      testDeviceIds: [
        "3CEEC2ACC6CE6FEF357A197589F988BE", // Your test device
        // Add more device IDs here if needed
      ],
    );
    MobileAds.instance.updateRequestConfiguration(configuration);

    await MobileAds.instance.initialize();
    _isInitialized = true;
  }

  /// Banner Ad Unit ID for your app
  /// App ID: ca-app-pub-7177141603793917~8941607826
  /// Android Main Bottom Banner: ca-app-pub-7177141603793917/2877804494
  ///
  /// Testing modes:
  /// 1. For initial testing: Use Google test IDs (useTestAds = true)
  /// 2. For pre-publish testing: Use your real ad unit ID + add device to testDeviceIds above
  /// 3. For production: Build in release mode (kDebugMode = false)

  /// Set to false to test your real ad unit (make sure to add your device ID above!)
  static const bool useTestAds = false;

  String get bannerAdUnitId {
    // Use test ads for initial testing
    if (kDebugMode && useTestAds) {
      // Google's official test ad unit IDs
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111'; // Official Google test banner ID for Android
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716'; // Official Google test banner ID for iOS
      }
    }

    // Your real ad unit IDs (for testing before publish or production)
    if (Platform.isAndroid) {
      return 'ca-app-pub-7177141603793917/2877804494'; // Android Main Bottom Banner
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7177141603793917/2877804494'; // iOS (update with iOS ad unit when created)
    }

    throw UnsupportedError('Unsupported platform');
  }

  /// Create a banner ad
  BannerAd createBannerAd({
    required AdSize adSize,
    required void Function(Ad ad, LoadAdError error) onAdFailedToLoad,
    required void Function(Ad ad) onAdLoaded,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }
}
