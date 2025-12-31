import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/category_provider.dart';
import '../widgets/lucky_wheel.dart';
import '../widgets/ad_banner.dart';
import 'result_screen.dart';
import 'category_list_screen.dart';
import 'notification_settings_screen.dart';

// Custom curve for natural spin with slow deceleration
class SpinWheelCurve extends Curve {
  const SpinWheelCurve();

  @override
  double transformInternal(double t) {
    // Easing out cubic curve for natural deceleration
    return 1 - pow(1 - t, 3).toDouble();
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
  double _targetRotation = 0;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000), // 4 seconds for natural spin
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
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.noItemsInCategory),
        ),
      );
      return;
    }

    // Select random item
    final randomIndex = Random().nextInt(items.length);

    // Calculate rotation to land on selected item
    // Items are positioned starting from top (index 0) going clockwise
    // We want to rotate so the selected item ends up at the top (under the pointer)
    final itemAngle = 2 * pi / items.length;
    const baseSpins = 5; // Number of full rotations for visual effect

    // Calculate target rotation:
    // - baseSpins * 2 * pi: several full rotations
    // - randomIndex * itemAngle: rotate to position the selected item at top
    // We rotate clockwise, so we need to rotate to align item to top
    final targetRotation = (baseSpins * 2 * pi) - (randomIndex * itemAngle);

    setState(() {
      _isSpinning = true;
      _targetRotation = targetRotation;
    });

    _spinController.reset();
    await _spinController.animateTo(
      1.0,
      curve: const SpinWheelCurve(),
    );

    setState(() => _isSpinning = false);

    // Small delay before showing result
    await Future.delayed(const Duration(milliseconds: 300));

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
    final l10n = AppLocalizations.of(context)!;
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
                          SnackBar(
                            content: Text(l10n.selectCategoryFirst),
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
                  Expanded(
                    child: Text(
                      l10n.homeTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
                              l10n.noCategoryTitle,
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
                            child: Text(l10n.noCategoryButton),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 44,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory?.id == category.id;

                      return InkWell(
                        onTap: () => provider.setSelectedCategory(category.id),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                category.name,
                                style: TextStyle(
                                  fontSize: 13,
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
                      targetRotation: _targetRotation,
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
                                _isSpinning ? l10n.spinning : l10n.spinButton,
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
                    l10n.spinHint,
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
            // Ad Banner at the bottom (Google AdMob)
            const AdBanner(),
          ],
        ),
      ),
    );
  }
}
