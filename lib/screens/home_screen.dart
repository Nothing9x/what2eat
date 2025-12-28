import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../widgets/lucky_wheel.dart';
import 'result_screen.dart';
import 'category_list_screen.dart';
import 'notification_settings_screen.dart';

// Custom curve with gradual start and very slow 1s stop at end
class SpinWheelCurve extends Curve {
  const SpinWheelCurve();

  @override
  double transformInternal(double t) {
    // For 20s total: slow start, fast middle, 1s (5%) extremely slow stop
    if (t < 0.05) {
      // Gradual acceleration at start (first 1 second)
      return (t / 0.05) * (t / 0.05) * 0.01;
    } else if (t < 0.95) {
      // Fast middle section (seconds 1-19)
      final adjusted = (t - 0.05) / 0.9;
      return 0.01 + (adjusted * adjusted * (3 - 2 * adjusted)) * 0.94;
    } else {
      // Extremely slow deceleration at end (last 1 second = 5%)
      final adjusted = (t - 0.95) / 0.05;
      // Ultra-extreme exponential decay - crawls to a stop
      return 0.95 + (1 - pow(1 - adjusted, 10.0)) * 0.05;
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _spinController;
  bool _isSpinning = false;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 20000),
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  void _spinWheel() async {
    if (_isSpinning) return;

    final provider = context.read<CategoryProvider>();
    final items = provider.selectedCategoryItems;

    // Check if there are items to spin
    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Danh sách này chưa có món ăn. Vui lòng thêm món!'),
        ),
      );
      return;
    }

    setState(() => _isSpinning = true);

    // Random rotation (5-8 full spins + random position)
    final randomSpins = 5 + Random().nextInt(4);
    final randomIndex = Random().nextInt(items.length);
    final targetRotation = (randomSpins * 2 * pi) + (randomIndex * (2 * pi / items.length));

    _spinController.reset();
    await _spinController.animateTo(
      1.0,
      curve: const SpinWheelCurve(),
    );

    setState(() => _isSpinning = false);

    // Navigate to result screen
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            foodItem: items[randomIndex],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF221a10) : const Color(0xFFFFFDF5);
    final primaryColor = const Color(0xFFEC9213);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Notification Settings Icon (left)
                  InkWell(
                    onTap: () {
                      final provider = context.read<CategoryProvider>();
                      if (provider.selectedCategory == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vui lòng chọn danh sách trước'),
                          ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationSettingsScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Consumer<CategoryProvider>(
                        builder: (context, provider, _) {
                          final hasNotification = provider.selectedCategory?.notificationSettings?.enabled ?? false;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.notifications_outlined,
                                color: primaryColor,
                                size: 28,
                              ),
                              if (hasNotification)
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDark ? const Color(0xFF221a10) : const Color(0xFFFFFDF5),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // Title (center)
                  const Expanded(
                    child: Text(
                      'Hôm nay ăn gì nhỉ? 🤔',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Manage Lists Icon (right)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoryListScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.edit_note,
                        size: 28,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal Category Chips
            Consumer<CategoryProvider>(
              builder: (context, provider, _) {
                final categories = provider.categories;
                final selectedCategory = provider.selectedCategory;

                if (categories.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2d2418) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: primaryColor, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Chưa có danh sách món ăn',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CategoryListScreen(),
                                ),
                              );
                            },
                            child: const Text('Tạo ngay'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 48,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory?.id == category.id;

                      return InkWell(
                        onTap: () => provider.setSelectedCategory(category.id),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryColor
                                : (isDark ? const Color(0xFF2d2418) : Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? primaryColor
                                  : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                category.icon,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                category.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark ? Colors.grey[300] : Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            // Lucky Wheel - Takes up available space
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, provider, _) {
                  final items = provider.selectedCategoryItems;

                  return Center(
                    child: LuckyWheel(
                      controller: _spinController,
                      isSpinning: _isSpinning,
                      items: items,
                    ),
                  );
                },
              ),
            ),
            // Spin Button Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Spin Button with gradient
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEC9213), Color(0xFFFF6B00)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEC9213).withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _isSpinning ? null : _spinWheel,
                        borderRadius: BorderRadius.circular(32),
                        child: Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.casino,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _isSpinning ? 'ĐANG QUAY...' : 'QUAY NGAY',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nhấn để chọn món ngẫu nhiên',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[500] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Ad Banner at the bottom
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2d2418) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                  width: 1,
                ),
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
                  // Ad Image
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isDark ? Colors.grey[700] : Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=400',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.fastfood, color: primaryColor, size: 32),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Ad Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'AD',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: primaryColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.more_horiz,
                              size: 20,
                              color: isDark ? Colors.grey[600] : Colors.grey[400],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Combo Gà Rán + Pepsi Chỉ 39k',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ưu đãi độc quyền cho thành viên mới',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
