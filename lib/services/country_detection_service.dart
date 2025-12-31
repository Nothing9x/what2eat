import 'package:flutter/widgets.dart';

/// Service to detect user's country based on timezone (geographic location)
/// This is more accurate than using locale language for determining actual location
class CountryDetectionService {
  /// Detect country code based on device timezone
  /// Falls back to locale country code if timezone detection fails
  static String detectCountryCode() {
    // Try timezone-based detection first (more accurate for geographic location)
    String countryCode = _getCountryFromTimezone();

    // Debug logging
    final now = DateTime.now();
    print('=== Country Detection Debug ===');
    print('Timezone Name: ${now.timeZoneName}');
    print('Timezone Offset: ${now.timeZoneOffset.inHours}h');
    print('Detected from Timezone: $countryCode');

    // Fallback to locale country code if timezone detection fails
    if (countryCode == 'UNKNOWN') {
      final locale = WidgetsBinding.instance.platformDispatcher.locale;
      countryCode = locale.countryCode ?? 'US';
      print('Fallback to Locale: $countryCode (from ${locale.toString()})');
    }

    print('Final Country Code: $countryCode');
    print('==============================');

    return countryCode;
  }

  /// Map device timezone to country code
  /// This uses timezone to determine geographic location, not language preference
  static String _getCountryFromTimezone() {
    // Get the device timezone
    final now = DateTime.now();
    final timezone = now.timeZoneName;
    final offset = now.timeZoneOffset;

    // Map common timezones to countries
    // This is a heuristic approach - timezone names vary by platform

    // Handle numeric timezone format (e.g., "+07", "+08", "-05")
    // This is common on some Android devices
    if (timezone.startsWith('+') || timezone.startsWith('-')) {
      return _getCountryFromOffset(offset);
    }

    if (timezone.contains('Asia/Ho_Chi_Minh') ||
        timezone.contains('ICT') ||
        (offset.inHours == 7 && timezone.contains('Asia'))) {
      return 'VN'; // Vietnam (UTC+7)
    } else if (timezone.contains('Asia/Bangkok')) {
      return 'TH'; // Thailand
    } else if (timezone.contains('Asia/Singapore')) {
      return 'SG'; // Singapore
    } else if (timezone.contains('Asia/Jakarta')) {
      return 'ID'; // Indonesia
    } else if (timezone.contains('Asia/Kuala_Lumpur')) {
      return 'MY'; // Malaysia
    } else if (timezone.contains('Asia/Manila')) {
      return 'PH'; // Philippines
    } else if (timezone.contains('Asia/Seoul')) {
      return 'KR'; // Korea
    } else if (timezone.contains('Asia/Tokyo') || timezone.contains('JST')) {
      return 'JP'; // Japan
    } else if (timezone.contains('Asia/Shanghai') ||
        timezone.contains('Asia/Hong_Kong') ||
        timezone.contains('CST')) {
      return 'CN'; // China
    } else if (timezone.contains('Asia/Kolkata') || timezone.contains('IST')) {
      return 'IN'; // India
    } else if (timezone.contains('Australia/')) {
      return 'AU'; // Australia
    } else if (timezone.contains('Europe/London') ||
        timezone.contains('GMT') ||
        timezone.contains('BST')) {
      return 'GB'; // UK
    } else if (timezone.contains('Europe/Paris') ||
        timezone.contains('Europe/Berlin')) {
      return 'DE'; // Germany (or France)
    } else if (timezone.contains('America/New_York') ||
        timezone.contains('America/Los_Angeles') ||
        timezone.contains('America/Chicago') ||
        timezone.contains('EST') ||
        timezone.contains('PST') ||
        timezone.contains('CST') ||
        timezone.contains('MST')) {
      return 'US'; // USA
    } else if (timezone.contains('America/Toronto') ||
        timezone.contains('America/Vancouver')) {
      return 'CA'; // Canada
    }

    return 'UNKNOWN';
  }

  /// Map timezone offset to most likely country
  /// This is used when timezone name is numeric (e.g., "+07")
  /// Returns the most populous/common country for each offset
  static String _getCountryFromOffset(Duration offset) {
    final hours = offset.inHours;
    final minutes = offset.inMinutes % 60;

    // Map timezone offsets to most common countries
    switch (hours) {
      case 7: // UTC+7
        return 'VN'; // Vietnam (also Thailand, Indonesia WIB)
      case 8: // UTC+8
        return 'CN'; // China (also Singapore, Malaysia, Philippines)
      case 9: // UTC+9
        return 'JP'; // Japan (also Korea)
      case 5: // UTC+5
        if (minutes == 30) return 'IN'; // India (UTC+5:30)
        return 'IN';
      case 6: // UTC+6
        if (minutes == 30) return 'IN'; // Myanmar (UTC+6:30), but return IN
        return 'IN';
      case -5: // UTC-5
        return 'US'; // US East Coast
      case -6: // UTC-6
        return 'US'; // US Central
      case -7: // UTC-7
        return 'US'; // US Mountain
      case -8: // UTC-8
        return 'US'; // US West Coast
      case 0: // UTC+0
        return 'GB'; // UK (also Portugal, Iceland)
      case 1: // UTC+1
        return 'DE'; // Germany (also France, Spain, Italy)
      case 2: // UTC+2
        return 'DE'; // Central Europe (Germany summer time)
      case 10: // UTC+10
        return 'AU'; // Australia (East)
      case 11: // UTC+11
        return 'AU'; // Australia (summer time)
      case -4: // UTC-4
        return 'CA'; // Canada Atlantic
      case -3: // UTC-3
        return 'CA'; // Canada (also Brazil)
      default:
        return 'UNKNOWN';
    }
  }
}
