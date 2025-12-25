import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_category.dart';
import '../providers/category_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/confirm_dialog.dart';
import 'category_form_screen.dart';
import 'food_items_list_screen.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF221a10) : const Color(0xFFF8F7F6);
    final primaryColor = const Color(0xFFEC9213);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          'Danh sách Quay',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _navigateToAddCategory(context),
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.add,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.categories.isEmpty) {
            return EmptyState(
              icon: Icons.add_task,
              title: 'Chưa có danh sách nào',
              subtitle: 'Tạo danh sách mới để\nphục vụ sở thích ăn uống của bạn!',
              actionLabel: 'Tạo danh sách',
              onAction: () => _navigateToAddCategory(context),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadCategories(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                final category = provider.categories[index];
                return CategoryCard(
                  category: category,
                  onTap: () => _navigateToItems(context, category),
                  onEdit: () => _navigateToEditCategory(context, category),
                  onDelete: () => _handleDelete(context, category),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.categories.isEmpty) return const SizedBox.shrink();

          return FloatingActionButton(
            onPressed: () => _navigateToAddCategory(context),
            backgroundColor: primaryColor,
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
    );
  }

  void _navigateToAddCategory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CategoryFormScreen(),
      ),
    );
  }

  void _navigateToEditCategory(BuildContext context, FoodCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryFormScreen(category: category),
      ),
    );
  }

  void _navigateToItems(BuildContext context, FoodCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodItemsListScreen(category: category),
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context, FoodCategory category) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Xóa danh sách',
      message: 'Bạn có chắc muốn xóa "${category.name}" và ${category.itemCount} món ăn?',
      confirmText: 'Xóa',
      cancelText: 'Hủy',
      isDestructive: true,
    );

    if (confirmed && context.mounted) {
      try {
        await context.read<CategoryProvider>().deleteCategory(category.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đã xóa danh sách')),
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
}
