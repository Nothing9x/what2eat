import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_category.dart';
import '../models/food_item.dart';

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
      // Create default categories for different meal times
      final categories = <FoodCategory>[
        // Sáng (Breakfast)
        FoodCategory(
          name: 'Sáng',
          icon: '🌅',
          color: const Color(0xFFFFB74D), // Orange 300
          items: [
            FoodItem(name: 'Bánh Mì', icon: '🥖', description: 'Bánh mì Việt Nam', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
            FoodItem(name: 'Phở', icon: '🍜', description: 'Phở bò tái', imageUrl: 'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=800'),
            FoodItem(name: 'Xôi', icon: '🍙', description: 'Xôi xéo', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
            FoodItem(name: 'Cháo', icon: '🥣', description: 'Cháo gà', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
            FoodItem(name: 'Bún Bò', icon: '🍜', description: 'Bún bò Huế', imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800'),
            FoodItem(name: 'Hủ Tiếu', icon: '🍜', description: 'Hủ tiếu Nam Vang', imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800'),
          ],
        ),

        // Trưa (Lunch)
        FoodCategory(
          name: 'Trưa',
          icon: '☀️',
          color: const Color(0xFFEF5350), // Red 400
          items: [
            FoodItem(name: 'Cơm Tấm', icon: '🍚', description: 'Cơm tấm sườn bì', imageUrl: 'https://images.unsplash.com/photo-1569562211093-4ed0d0758f12?w=800'),
            FoodItem(name: 'Bún Bò', icon: '🍜', description: 'Bún bò Huế', imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800'),
            FoodItem(name: 'Mì Quảng', icon: '🍜', description: 'Mì Quảng tôm thịt', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
            FoodItem(name: 'Cơm Rang', icon: '🍛', description: 'Cơm rang dương châu', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
            FoodItem(name: 'Bún Chả', icon: '🍢', description: 'Bún chả Hà Nội', imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=800'),
            FoodItem(name: 'Phở', icon: '🍜', description: 'Phở bò tái', imageUrl: 'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=800'),
          ],
        ),

        // Tối (Dinner)
        FoodCategory(
          name: 'Tối',
          icon: '🌙',
          color: const Color(0xFF5C6BC0), // Indigo 400
          items: [
            FoodItem(name: 'Lẩu', icon: '🍲', description: 'Lẩu Thái', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
            FoodItem(name: 'Nướng', icon: '🥩', description: 'Thịt nướng BBQ', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
            FoodItem(name: 'Gà Rán', icon: '🍗', description: 'Gà rán giòn', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
            FoodItem(name: 'Pizza', icon: '🍕', description: 'Pizza Hải Sản', imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800'),
            FoodItem(name: 'Burger', icon: '🍔', description: 'Burger bò phô mai', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800'),
            FoodItem(name: 'Mì Ý', icon: '🍝', description: 'Mì Ý sốt bò băm', imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800'),
          ],
        ),

        // Party
        FoodCategory(
          name: 'Party',
          icon: '🎉',
          color: const Color(0xFFEC407A), // Pink 400
          items: [
            FoodItem(name: 'Pizza', icon: '🍕', description: 'Pizza Size L', imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800'),
            FoodItem(name: 'Burger', icon: '🍔', description: 'Burger Set', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800'),
            FoodItem(name: 'Gà Rán', icon: '🍗', description: 'Gà rán giỏ lớn', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
            FoodItem(name: 'Nem Rán', icon: '🥟', description: 'Nem rán giòn', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
            FoodItem(name: 'Sushi', icon: '🍣', description: 'Sushi Mix', imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800'),
            FoodItem(name: 'Salad', icon: '🥗', description: 'Salad trộn', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
          ],
        ),

        // Cafe
        FoodCategory(
          name: 'Cafe',
          icon: '☕',
          color: const Color(0xFF8D6E63), // Brown 300
          items: [
            FoodItem(name: 'Cà Phê', icon: '☕', description: 'Cà phê đen đá', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
            FoodItem(name: 'Trà Sữa', icon: '🧋', description: 'Trà sữa trân châu', imageUrl: 'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=800'),
            FoodItem(name: 'Bánh Ngọt', icon: '🧁', description: 'Bánh cupcake', imageUrl: 'https://images.unsplash.com/photo-1587668178277-295251f900ce?w=800'),
            FoodItem(name: 'Smoothie', icon: '🥤', description: 'Smoothie dâu', imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800'),
            FoodItem(name: 'Bánh Croissant', icon: '🥐', description: 'Croissant bơ', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
            FoodItem(name: 'Trà Trái Cây', icon: '🍹', description: 'Trà đào cam sả', imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800'),
          ],
        ),
      ];

      // Save all default categories
      await saveCategories(categories);

      // Set the first category (Sáng) as the selected category
      await saveSelectedCategoryId(categories.first.id);

      // Mark as migrated
      await setMigrated();

      print('Successfully migrated initial data with 5 default categories');
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
