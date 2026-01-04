# Interstitial Ad Implementation

## Overview

The app now shows interstitial video ads every 5 spins to monetize the free app without being intrusive to users. A friendly notification dialog is shown before the ad to improve user experience.

## Implementation Summary

### 1. Spin Counter Service
**File:** [lib/services/spin_counter_service.dart](lib/services/spin_counter_service.dart)

Tracks the number of spins using SharedPreferences:
- `incrementSpinCount()`: Called when result screen is shown
- `shouldShowAd()`: Returns true every 5 spins
- `resetSpinCount()`: Called after ad is shown
- Configurable frequency: Change `_spinsBeforeAd` constant (currently 5)

### 2. Ad Service Updates
**File:** [lib/services/ad_service.dart](lib/services/ad_service.dart)

Added interstitial ad support:
- `interstitialAdUnitId`: Getter for ad unit ID (test and production)
- `loadInterstitialAd()`: Preloads an interstitial ad
- `showInterstitialAd()`: Shows the loaded ad
- Auto-reloads next ad after current ad is dismissed
- Supports both test ads (for development) and real ads (for production)

**Test Ad Unit IDs** (currently active with `useTestAds = false`):
- Android: `ca-app-pub-3940256099942544/1033173712`
- iOS: `ca-app-pub-3940256099942544/4411468910`

### 3. Friendly Ad Dialog
**File:** [lib/widgets/ad_dialog.dart](lib/widgets/ad_dialog.dart)

A polite dialog shown before the ad:
- Heart icon and warm message thanking users
- Explains why ad is shown (to keep app free)
- Info box explaining ad will show after button press
- "Watch Ad" button (primary) and "Cancel" button
- Fully localized in all 24 supported languages
- Matches app's dark/light theme

### 4. Localization Strings
**Files:** `lib/l10n/app_*.arb` (24 languages)

Added 5 new localization keys:
- `adDialogTitle`: "Thanks for Using What2Eat!"
- `adDialogMessage`: "To keep this app free, please watch a short ad..."
- `adDialogInfo`: "Ad will show after you press 'Watch Ad'"
- `watchAdButton`: "Watch Ad"
- `cancelButton`: "Cancel"

**Languages:** en, vi, zh, ja, ko, es, fr, de, th, it, pt, ru, hi, id, ar, tr, pl, nl, sv, uk, el, hu, cs, ro

### 5. Result Screen Integration
**File:** [lib/screens/result_screen.dart](lib/screens/result_screen.dart)

Modified to handle ad flow:
- Increments spin count when screen is shown
- `_handleBackNavigation()`: Intercepts back button presses
- Checks if ad should be shown
- Shows friendly dialog → Shows ad → Navigates back
- Handles both UI back button and system back button (PopScope)
- User can cancel ad and still navigate back

### 6. App Initialization
**File:** [lib/main.dart](lib/main.dart)

Preloads first interstitial ad on app start:
```dart
await AdService().initialize();
await AdService().loadInterstitialAd();
```

## User Experience Flow

1. User spins the wheel 5 times
2. On 5th spin, when trying to go back to home:
   - Friendly dialog appears: "Thanks for Using What2Eat! To keep this app free..."
   - User can choose "Watch Ad" or "Cancel"
3. If "Watch Ad":
   - Interstitial ad is shown
   - After ad completes/is closed, user returns to home
   - Spin counter resets to 0
4. If "Cancel":
   - User returns to home without ad
   - Counter is NOT reset (ad will show on next navigation)

## Configuration

### Before Publishing: Update Ad Unit IDs

**File to modify:** [lib/services/ad_service.dart](lib/services/ad_service.dart)

1. Create an interstitial ad unit in Google AdMob console
2. Replace placeholder IDs in `interstitialAdUnitId` getter:

```dart
// Your real ad unit IDs (replace with your actual interstitial ad unit IDs)
if (Platform.isAndroid) {
  return 'ca-app-pub-7177141603793917/YOUR_ANDROID_INTERSTITIAL_ID'; // TODO: Replace
} else if (Platform.isIOS) {
  return 'ca-app-pub-7177141603793917/YOUR_IOS_INTERSTITIAL_ID'; // TODO: Replace
}
```

### Testing

**Option 1: Use Test Ads** (Recommended for development)
```dart
static const bool useTestAds = true;  // In ad_service.dart
```
This uses Google's official test ad units - safe for development.

**Option 2: Use Real Ads with Test Device**
```dart
static const bool useTestAds = false;
```
Add your device ID to `testDeviceIds` array in `initialize()` method.
Your device will show real ads but clicks won't affect your account.

**Option 3: Production**
Set `useTestAds = false` and build in release mode. Real ads will show to real users.

### Adjusting Ad Frequency

**File:** [lib/services/spin_counter_service.dart](lib/services/spin_counter_service.dart)

Change the frequency constant:
```dart
static const int _spinsBeforeAd = 5; // Show ad every X spins
```

Recommendations:
- Too frequent (< 3): Annoying, users may uninstall
- Balanced (5-7): Good user experience while monetizing
- Too rare (> 10): Lower revenue

## Technical Details

### Ad Loading Strategy
- First ad is preloaded when app starts
- After each ad is shown, next ad is automatically preloaded
- Ads are always ready when needed (no loading time for user)

### Error Handling
- If ad fails to load: User can still navigate (graceful degradation)
- If ad fails to show: User can still navigate
- Ad errors are logged in debug mode only

### Performance
- Ads are loaded in background (non-blocking)
- Minimal impact on app startup time
- SharedPreferences for fast counter access

## Files Modified

1. ✅ `lib/services/spin_counter_service.dart` - NEW
2. ✅ `lib/services/ad_service.dart` - Updated
3. ✅ `lib/widgets/ad_dialog.dart` - NEW
4. ✅ `lib/screens/result_screen.dart` - Updated
5. ✅ `lib/main.dart` - Updated
6. ✅ `lib/l10n/app_*.arb` - Updated (24 files)

## Build Info

- Release APK: `build/app/outputs/flutter-apk/app-release.apk` (57.6 MB)
- Build status: ✅ Success
- All localization files: ✅ Updated

## Next Steps

1. **Test the implementation:**
   - Spin the wheel 5 times in a row
   - Verify dialog appears on 5th spin
   - Verify ad shows after "Watch Ad" button
   - Verify counter resets after ad

2. **Create interstitial ad units in AdMob:**
   - Log in to Google AdMob console
   - Navigate to your app (App ID: `ca-app-pub-7177141603793917~8941607826`)
   - Create new ad unit → Interstitial
   - Get ad unit IDs for Android and iOS

3. **Update ad unit IDs in code:**
   - Replace placeholders in [lib/services/ad_service.dart](lib/services/ad_service.dart)

4. **Test with real ads:**
   - Add your test device ID
   - Set `useTestAds = false`
   - Build and test

5. **Release to production:**
   - Build release APK/AAB
   - Upload to Google Play Store

## Notes

- The current configuration uses **test ads** by default (`useTestAds = false` in the code, but the ad unit IDs are still test IDs)
- User can always cancel the ad dialog and still navigate back
- Ad frequency is configurable and can be A/B tested
- All text is properly localized for international users
- Dialog design matches the app's existing design language
