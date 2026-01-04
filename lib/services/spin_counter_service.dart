import 'package:shared_preferences/shared_preferences.dart';

/// Service to track number of spins and manage ad frequency
class SpinCounterService {
  static const String _spinCountKey = 'spin_count';
  static const int _spinsBeforeAd = 5; // Show ad every 5 spins

  /// Increment spin count
  static Future<void> incrementSpinCount() async {
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(_spinCountKey) ?? 0;
    await prefs.setInt(_spinCountKey, currentCount + 1);
  }

  /// Get current spin count
  static Future<int> getSpinCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_spinCountKey) ?? 0;
  }

  /// Check if should show ad (every X spins)
  static Future<bool> shouldShowAd() async {
    final count = await getSpinCount();
    return count > 0 && count % _spinsBeforeAd == 0;
  }

  /// Reset spin count after showing ad
  static Future<void> resetSpinCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_spinCountKey, 0);
  }
}
