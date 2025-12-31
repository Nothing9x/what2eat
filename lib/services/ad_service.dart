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

    await MobileAds.instance.initialize();
    _isInitialized = true;
  }

  /// Banner Ad Unit ID for your app
  /// App ID: ca-app-pub-7177141603793917~8941607826
  /// Ad Unit ID: ca-app-pub-7177141603793917/9726229975
  ///
  /// Automatically uses test ads in debug mode and real ads in release mode
  String get bannerAdUnitId {
    // Use test ads in debug mode to avoid policy violations
    if (kDebugMode) {
      // Google's official test ad unit IDs
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/9726229975'; // Test ID
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716'; // Test ID
      }
    } else {
      // Your real ad unit IDs (production - release mode)
      if (Platform.isAndroid) {
        return 'ca-app-pub-7177141603793917/9726229975';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-7177141603793917/9726229975';
      }
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
