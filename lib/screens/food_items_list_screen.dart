import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_category.dart';
import '../models/food_item.dart';
import '../providers/category_provider.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/empty_state.dart';
import 'food_item_form_screen.dart';

class FoodItemsListScreen extends StatelessWidget {
  final FoodCategory category;

  const FoodItemsListScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF221a10) : const Color(0xFFF8F7F6);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          category.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToAddItem(context),
          ),
        ],
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, _) {
          final currentCategory = provider.categories
              .firstWhere((cat) => cat.id == category.id, orElse: () => category);
          final items = currentCategory.items;

          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.restaurant_menu,
              title: 'Chưa có món ăn nào',
              subtitle: 'Thêm món ăn vào danh sách để bắt đầu',
              actionLabel: 'Thêm món ngay',
              onAction: () => _navigateToAddItem(context),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildFoodItemCard(context, item, isDark);
            },
          );
        },
      ),
    );
  }

  Widget _buildFoodItemCard(BuildContext context, FoodItem item, bool isDark) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await ConfirmDialog.show(
          context: context,
          title: 'Xóa món ăn',
          message: 'Bạn có chắc muốn xóa "${item.name}"?',
          confirmText: 'Xóa',
          isDestructive: true,
        );
      },
      onDismissed: (direction) => _handleDeleteItem(context, item),
      child: InkWell(
        onTap: () => _navigateToEditItem(context, item),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2c241b) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    item.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF181511),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : const Color(0xFF897961),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Action buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _navigateToEditItem(context, item),
                    icon: const Icon(Icons.edit),
                    color: isDark ? Colors.grey[400] : const Color(0xFF897961),
                    iconSize: 20,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    onPressed: () => _handleDeleteItemWithConfirmation(context, item),
                    icon: const Icon(Icons.delete),
                    color: isDark ? Colors.grey[400] : const Color(0xFF897961),
                    iconSize: 20,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAddItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodItemFormScreen(categoryId: category.id),
      ),
    );
  }

  void _navigateToEditItem(BuildContext context, FoodItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodItemFormScreen(
          categoryId: category.id,
          item: item,
        ),
      ),
    );
  }

  Future<void> _handleDeleteItemWithConfirmation(BuildContext context, FoodItem item) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Xóa món ăn',
      message: 'Bạn có chắc muốn xóa "${item.name}"?',
      confirmText: 'Xóa',
      isDestructive: true,
    );

    if (confirmed && context.mounted) {
      _handleDeleteItem(context, item);
    }
  }

  Future<void> _handleDeleteItem(BuildContext context, FoodItem item) async {
    try {
      await context.read<CategoryProvider>().deleteFoodItem(category.id, item.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã xóa "${item.name}"')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${e.toString()}')),
        );
      }
    }
  }
}
