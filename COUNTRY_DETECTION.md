# Country Detection for Food Delivery Platforms & Default Food Data

## Problem

Previously, the app used the device's **language setting** to determine:
1. **Food delivery platforms** to show on result screen
2. **Default food categories and items** to load on first launch

This caused issues when:
- User in Vietnam sets device language to English → Shows Uber Eats/DoorDash + American food (not available in VN)
- User in USA sets device language to Vietnamese → Shows ShopeeFood/Grab + Vietnamese food (not available in USA)

## Solution

The app now detects the user's **geographic location** (not language) using two methods:

### 1. Primary Detection: Timezone-based (Most Accurate)

The app analyzes the device timezone to determine the country:

```dart
_getCountryFromTimezone() {
  final now = DateTime.now();
  final timezone = now.timeZoneName;    // e.g., "Asia/Ho_Chi_Minh" or "+07"
  final offset = now.timeZoneOffset;    // e.g., UTC+7

  // Handle numeric timezone format (common on Android)
  if (timezone.startsWith('+') || timezone.startsWith('-')) {
    return _getCountryFromOffset(offset);  // Map UTC+7 → VN, UTC+8 → CN, etc.
  }

  // Map named timezone to country
  if (timezone.contains('Asia/Ho_Chi_Minh') || offset.inHours == 7) {
    return 'VN'; // Vietnam
  }
  // ... other countries
}
```

**Note:** On some Android devices, the timezone name is numeric (e.g., "+07" instead of "Asia/Ho_Chi_Minh"). The app handles both formats by mapping the UTC offset to the most common country for that timezone.

**Timezone Mappings:**
- 🇻🇳 Vietnam: `Asia/Ho_Chi_Minh`, `ICT`, UTC+7
- 🇹🇭 Thailand: `Asia/Bangkok`
- 🇸🇬 Singapore: `Asia/Singapore`
- 🇮🇩 Indonesia: `Asia/Jakarta`
- 🇲🇾 Malaysia: `Asia/Kuala_Lumpur`
- 🇵🇭 Philippines: `Asia/Manila`
- 🇰🇷 Korea: `Asia/Seoul`
- 🇯🇵 Japan: `Asia/Tokyo`, `JST`
- 🇨🇳 China: `Asia/Shanghai`, `Asia/Hong_Kong`, `CST`
- 🇮🇳 India: `Asia/Kolkata`, `IST`
- 🇦🇺 Australia: `Australia/*`
- 🇬🇧 UK: `Europe/London`, `GMT`, `BST`
- 🇩🇪 Germany: `Europe/Berlin`, `Europe/Paris`
- 🇺🇸 USA: `America/New_York`, `America/Los_Angeles`, `EST`, `PST`, `CST`, `MST`
- 🇨🇦 Canada: `America/Toronto`, `America/Vancouver`

### 2. Fallback Detection: Locale Country Code

If timezone detection fails (returns `UNKNOWN`), the app falls back to the device locale's country code:

```dart
if (countryCode == 'UNKNOWN') {
  final locale = WidgetsBinding.instance.platformDispatcher.locale;
  countryCode = locale.countryCode ?? 'US';
}
```

This ensures the app always has a country code, even if timezone detection doesn't work.

## Platform Selection by Country

Based on the detected country, the app shows the most popular food delivery platforms:

| Country | Platforms |
|---------|-----------|
| 🇻🇳 Vietnam | ShopeeFood, GrabFood, Now |
| 🇹🇭 Thailand | GrabFood, foodpanda |
| 🇸🇬 Singapore | GrabFood, foodpanda, Deliveroo |
| 🇮🇩 Indonesia | GoFood, GrabFood, foodpanda |
| 🇲🇾 Malaysia | GrabFood, foodpanda |
| 🇵🇭 Philippines | GrabFood, foodpanda |
| 🇰🇷 Korea | 배달의민족 (Baemin), Coupang Eats, Uber Eats |
| 🇯🇵 Japan | Uber Eats, 出前館 (Demae-can) |
| 🇨🇳 China | 美团外卖 (Meituan), 饿了么 (Ele.me) |
| 🇮🇳 India | Swiggy, Zomato |
| 🇦🇺 Australia | Menulog, Uber Eats, Deliveroo |
| 🇬🇧 UK | Deliveroo, Just Eat, Uber Eats |
| 🇺🇸 USA | Uber Eats, DoorDash, Grubhub |
| 🇨🇦 Canada | Uber Eats, DoorDash, SkipTheDishes |
| 🇪🇺 Europe | Deliveroo, Just Eat, Uber Eats |

## Example Scenarios

### Scenario 1: Vietnamese User with English Language
- **Device Settings:** Language = English, Timezone = Asia/Ho_Chi_Minh
- **Detection:** Timezone → Vietnam (VN)
- **Platforms Shown:** ✅ ShopeeFood, GrabFood, Now

### Scenario 2: American Tourist in Vietnam
- **Device Settings:** Language = English, Timezone = Asia/Ho_Chi_Minh (if changed)
- **Detection:** Timezone → Vietnam (VN)
- **Platforms Shown:** ✅ ShopeeFood, GrabFood, Now
- **Note:** Tourist should change device timezone to Vietnam time

### Scenario 3: Vietnamese Living Abroad
- **Device Settings:** Language = Vietnamese, Timezone = America/Los_Angeles
- **Detection:** Timezone → USA (US)
- **Platforms Shown:** ✅ Uber Eats, DoorDash, Grubhub

## Benefits

1. **Accurate Geographic Detection:** Uses timezone, which reflects actual location
2. **Language Independent:** Works regardless of device language setting
3. **Multiple Fallbacks:** Timezone → Locale → Default (US)
4. **Covers 15+ Countries:** Support for major markets worldwide

## Technical Implementation

### Central Detection Service
All country detection logic is centralized in [lib/services/country_detection_service.dart](lib/services/country_detection_service.dart).

This service is used by:
1. **[lib/services/storage_service.dart](lib/services/storage_service.dart)** - To load appropriate default food data on first launch
2. **[lib/screens/result_screen.dart](lib/screens/result_screen.dart)** - To show appropriate food delivery platforms

Platform definitions are in [lib/models/food_delivery_platform.dart](lib/models/food_delivery_platform.dart).

Default food data by country is in [lib/models/default_food_data.dart](lib/models/default_food_data.dart).
