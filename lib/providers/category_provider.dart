import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'dart:math';
import '../models/food_category.dart';
import '../models/food_item.dart';
import '../models/notification_settings.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class CategoryProvider extends ChangeNotifier {
  final StorageService _storage;
  final NotificationService _notificationService;

  List<FoodCategory> _categories = [];
  String? _selectedCategoryId;
  bool _isLoading = false;
  String? _error;

  CategoryProvider(this._storage, this._notificationService);

  // Getters
  List<FoodCategory> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedCategoryId => _selectedCategoryId;

  FoodCategory? get selectedCategory {
    if (_selectedCategoryId == null) return null;
    try {
      return _categories.firstWhere((cat) => cat.id == _selectedCategoryId);
    } catch (e) {
      return null;
    }
  }

  List<FoodItem> get selectedCategoryItems {
    final category = selectedCategory;
    return category?.items ?? [];
  }

  /// Load categories from storage and handle migration
  Future<void> loadCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Check if we need to migrate
      if (!_storage.hasMigrated) {
        await _storage.migrateInitialData();
      }

      // Load categories
      _categories = await _storage.loadCategories();

      // Load selected category ID
      _selectedCategoryId = await _storage.getSelectedCategoryId();

      // If no selected category but we have categories, select the first one
      if (_selectedCategoryId == null && _categories.isNotEmpty) {
        _selectedCategoryId = _categories.first.id;
        await _storage.saveSelectedCategoryId(_selectedCategoryId);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Không thể tải dữ liệu: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  /// Add a new category
  Future<void> addCategory(FoodCategory category) async {
    try {
      _categories.add(category);
      await _storage.saveCategories(_categories);

      // If this is the first category, select it
      if (_categories.length == 1) {
        _selectedCategoryId = category.id;
        await _storage.saveSelectedCategoryId(_selectedCategoryId);
      }

      notifyListeners();
    } catch (e) {
      _error = 'Không thể thêm danh sách: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  /// Update an existing category
  Future<void> updateCategory(FoodCategory updatedCategory) async {
    try {
      final index = _categories.indexWhere((cat) => cat.id == updatedCategory.id);
      if (index == -1) {
        throw Exception('Category not found');
      }

      _categories[index] = updatedCategory.copyWith(
        updatedAt: DateTime.now(),
      );
      await _storage.saveCategories(_categories);
      notifyListeners();
    } catch (e) {
      _error = 'Không thể cập nhật danh sách: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  /// Delete a category
  Future<void> deleteCategory(String categoryId) async {
    try {
      _categories.removeWhere((cat) => cat.id == categoryId);
      await _storage.saveCategories(_categories);

      // If the deleted category was selected, select another one
      if (_selectedCategoryId == categoryId) {
        _selectedCategoryId = _categories.isNotEmpty ? _categories.first.id : null;
        await _storage.saveSelectedCategoryId(_selectedCategoryId);
      }

      notifyListeners();
    } catch (e) {
      _error = 'Không thể xóa danh sách: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  /// Add a food item to a category
  Future<void> addFoodItem(String categoryId, FoodItem item) async {
    try {
      final categoryIndex = _categories.indexWhere((cat) => cat.id == categoryId);
      if (categoryIndex == -1) {
        throw Exception('Category not found');
      }

      final category = _categories[categoryIndex];
      final updatedItems = List<FoodItem>.from(category.items)
        ..add(item.copyWith(categoryId: categoryId));

      _categories[categoryIndex] = category.copyWith(
        items: updatedItems,
        updatedAt: DateTime.now(),
      );

      await _storage.saveCategories(_categories);
      notifyListeners();
    } catch (e) {
      _error = 'Không thể thêm món ăn: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  /// Update a food item in a category
  Future<void> updateFoodItem(String categoryId, FoodItem updatedItem) async {
    try {
      final categoryIndex = _categories.indexWhere((cat) => cat.id == categoryId);
      if (categoryIndex == -1) {
        throw Exception('Category not found');
      }

      final category = _categories[categoryIndex];
      final itemIndex = category.items.indexWhere((item) => item.id == updatedItem.id);
      if (itemIndex == -1) {
        throw Exception('Item not found');
      }

      final updatedItems = List<FoodItem>.from(category.items);
      updatedItems[itemIndex] = updatedItem.copyWith(categoryId: categoryId);

      _categories[categoryIndex] = category.copyWith(
        items: updatedItems,
        updatedAt: DateTime.now(),
      );

      await _storage.saveCategories(_categories);
      notifyListeners();
    } catch (e) {
      _error = 'Không thể cập nhật món ăn: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  /// Delete a food item from a category
  Future<void> deleteFoodItem(String categoryId, String itemId) async {
    try {
      final categoryIndex = _categories.indexWhere((cat) => cat.id == categoryId);
      if (categoryIndex == -1) {
        throw Exception('Category not found');
      }

      final category = _categories[categoryIndex];
      final updatedItems = category.items.where((item) => item.id != itemId).toList();

      _categories[categoryIndex] = category.copyWith(
        items: updatedItems,
        updatedAt: DateTime.now(),
      );

      await _storage.saveCategories(_categories);
      notifyListeners();
    } catch (e) {
      _error = 'Không thể xóa món ăn: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  /// Set the selected category
  Future<void> setSelectedCategory(String? categoryId) async {
    _selectedCategoryId = categoryId;
    await _storage.saveSelectedCategoryId(categoryId);
    notifyListeners();
  }

  /// Get a category by ID
  FoodCategory? getCategoryById(String id) {
    try {
      return _categories.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Update notification settings for a category
  Future<void> updateCategoryNotificationSettings(
    String categoryId,
    NotificationSettings settings,
  ) async {
    try {
      final categoryIndex = _categories.indexWhere((cat) => cat.id == categoryId);
      if (categoryIndex == -1) {
        throw Exception('Category not found');
      }

      final category = _categories[categoryIndex];

      _categories[categoryIndex] = category.copyWith(
        notificationSettings: settings,
        updatedAt: DateTime.now(),
      );

      await _storage.saveCategories(_categories);

      // Handle Notifications
      final notificationId = categoryId.hashCode;
      
      // Cancel existing notifications for this category
      // Cancel base ID (for one-time notifications)
      await _notificationService.cancelNotification(notificationId);
      // Cancel weekday-based IDs (base + 1..7)
      for (int i = 1; i <= 7; i++) {
         await _notificationService.cancelNotification(notificationId + i);
      }

      if (settings.enabled) {
        final time = material.TimeOfDay(
          hour: settings.time.hour, 
          minute: settings.time.minute
        );
        
        // Prepare notification content based on mode
        String title;
        String body;
        
        if (settings.mode == OperationMode.autoSpin && category.items.isNotEmpty) {
          // Auto-spin mode: pick a random meal and show it
          final random = Random();
          final randomItem = category.items[random.nextInt(category.items.length)];
          title = '${randomItem.icon} ${category.name}';
          body = 'Hôm nay ăn: ${randomItem.name}!';
        } else {
          // Notify only mode: show reminder
          title = '🍽️ ${category.name}';
          body = 'Đã đến giờ chọn món ăn!';
        }
        
        if (settings.onceNextDay) {
          // Schedule one-time notification for the next occurrence of the specified time
          await _notificationService.scheduleOneTimeNotification(
            id: notificationId,
            title: title,
            body: body,
            time: time,
          );
        } else if (settings.weekdays.isNotEmpty) {
          // Schedule weekly recurring notifications
          await _notificationService.scheduleWeeklyNotification(
            id: notificationId,
            title: title,
            body: body,
            time: time,
            weekdays: settings.weekdays,
          );
        }
      }

      notifyListeners();
    } catch (e) {
      _error = 'Không thể cập nhật cài đặt: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  /// Clear all data (for testing)
  Future<void> clearAll() async {
    await _storage.clearAll();
    _categories = [];
    _selectedCategoryId = null;
    notifyListeners();
  }
}
