import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_category.dart';
import '../models/default_food_data.dart';
import 'country_detection_service.dart';

class StorageService {
  final SharedPreferences _prefs;

  static const String _categoriesKey = 'food_categories';
  static const String _selectedCategoryKey = 'selected_category_id';
  static const String _hasMigratedKey = 'has_migrated';

  StorageService(this._prefs);

  /// Load all categories from SharedPreferences
  Future<List<FoodCategory>> loadCategories() async {
    try {
      final String? categoriesJson = _prefs.getString(_categoriesKey);
      if (categoriesJson == null || categoriesJson.isEmpty) {
        return [];
      }

      final List<dynamic> decoded = jsonDecode(categoriesJson);
      return decoded
          .map((json) => FoodCategory.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading categories: $e');
      return [];
    }
  }

  /// Save all categories to SharedPreferences
  Future<void> saveCategories(List<FoodCategory> categories) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          categories.map((cat) => cat.toJson()).toList();
      final String encoded = jsonEncode(jsonList);
      await _prefs.setString(_categoriesKey, encoded);
    } catch (e) {
      print('Error saving categories: $e');
      rethrow;
    }
  }

  /// Save the selected category ID
  Future<void> saveSelectedCategoryId(String? categoryId) async {
    if (categoryId == null) {
      await _prefs.remove(_selectedCategoryKey);
    } else {
      await _prefs.setString(_selectedCategoryKey, categoryId);
    }
  }

  /// Get the selected category ID
  Future<String?> getSelectedCategoryId() async {
    return _prefs.getString(_selectedCategoryKey);
  }

  /// Check if data has been migrated
  bool get hasMigrated => _prefs.getBool(_hasMigratedKey) ?? false;

  /// Set migration flag
  Future<void> setMigrated() async {
    await _prefs.setBool(_hasMigratedKey, true);
  }

  /// Migrate initial hardcoded data to a default category
  Future<void> migrateInitialData() async {
    if (hasMigrated) return;

    try {
      // Detect country based on timezone (geographic location, not language)
      String countryCode = CountryDetectionService.detectCountryCode();

      // Get default categories for the detected country
      final categories = DefaultFoodData.getCategoriesByCountry(countryCode);

      // Save all default categories
      await saveCategories(categories);

      // Set the first category as the selected category
      await saveSelectedCategoryId(categories.first.id);

      // Mark as migrated
      await setMigrated();

      print('Successfully migrated initial data with ${categories.length} default categories for country: $countryCode');
    } catch (e) {
      print('Error during migration: $e');
      rethrow;
    }
  }

  /// Clear all data (for testing purposes)
  Future<void> clearAll() async {
    await _prefs.remove(_categoriesKey);
    await _prefs.remove(_selectedCategoryKey);
    await _prefs.remove(_hasMigratedKey);
  }
}
